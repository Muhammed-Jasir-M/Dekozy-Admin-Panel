import 'dart:convert';
import 'dart:io';

import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/cloudinary_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class MediaRepository {
  static MediaRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Upload any Image using Uint8List
  Future<ImageModel> uploadImageFileCloudinary({
    required Uint8List fileData,
    required String mimeType,
    required String folderPath,
    required String imageName,
  }) async {
    try {
      final cloudinaryCloudName = APIConstants.cloudinaryCloudName;

      final resourceType = mimeType.startsWith('image/') ? 'image' : 'raw';

      final cloudinaryUploadUrl = APIConstants.getCloudinaryUploadUrl(
          cloudinaryCloudName, resourceType);

      final uri = Uri.parse(cloudinaryUploadUrl);

      var request = http.MultipartRequest('POST', uri);

      request.fields['upload_preset'] = APIConstants.cloudinaryUploadPreset;

      request.fields['resource_type'] = resourceType;

      request.fields['folder'] = folderPath;

      request.files.add(http.MultipartFile.fromBytes(
        'file',
        fileData,
        filename: imageName,
      ));

      // Send the request
      final response = await request.send();

      // Parse the response
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseBody);

        if (kDebugMode) print("Cloudinary Response: $jsonResponse");

        // Create the ImageModel from the response
        return ImageModel.fromCloudinaryResponse(
          jsonResponse,
          folderPath,
          imageName,
          mimeType,
        );
      } else {
        final error = await response.stream.bytesToString();
        throw Exception('Failed to upload image: $error');
      }
    } on ACloudinaryException catch (e) {
      if (kDebugMode) print(e.toString());
      throw ACloudinaryException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw e.toString();
    }
  }

  Future<String> uploadImageFileInDB(ImageModel image) async {
    try {
      final data = await _db.collection('Images').add(image.toJson());
      return data.id;
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch Images from Firestore based on media category & load count
  Future<List<ImageModel>> fetchImagesFromDatabase(
    MediaCategory mediaCategory,
    int loadCount,
  ) async {
    try {
      final querySnapshot = await _db
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Load Images from Firestore based on media category, load count & last fetched data
  Future<List<ImageModel>> loadMoreImagesFromDatabase(
    MediaCategory mediaCategory,
    int loadCount,
    DateTime lastFetchedDate,
  ) async {
    try {
      final querySnapshot = await _db
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt', descending: true)
          .startAfter([lastFetchedDate])
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Delete file from Cloudinary & corresponding document from Firebase
  Future<void> deleteImageFileFromCloudinary(ImageModel image) async {
    try {
      final cloudinaryCloudName = APIConstants.cloudinaryCloudName;

      final resourceType = image.contentType!;

      final deleteUrl = APIConstants.getCloudinaryDeleteUrl(
          cloudinaryCloudName, resourceType);

      final uri = Uri.parse(deleteUrl);

      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final publicId = image.publicId;

      final signatureString =
          'public_id=$publicId&timestamp=$timestamp${APIConstants.cloudinaryApiSecret}';

      final bytes = utf8.encode(signatureString);
      final signature = sha1.convert(bytes).toString();

      final response = await http.post(
        uri,
        body: {
          'public_id': publicId,
          'timestamp': timestamp.toString(),
          'api_key': APIConstants.cloudinaryApiKey,
          'signature': signature,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print('Image deleted successfully from Cloudinary: $jsonResponse');
        }
      } else {
        throw Exception(
            'Failed to delete image from Cloudinary: ${response.body}');
      }
    } on ACloudinaryException catch (e) {
      throw ACloudinaryException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Delete file from Cloudinary & corresponding document from Firebase
  Future<void> deleteImageDataFromFirestore(ImageModel image) async {
    try {
      await _db.collection("Images").doc(image.id).delete();
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
