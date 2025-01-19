import 'dart:convert';

import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../utils/constants/api_constants.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
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
      final uri = Uri.parse(APIConstants.cloudinaryBaseUrl);

      var request = http.MultipartRequest('POST', uri);

      request.fields['upload_preset'] = APIConstants.cloudinaryUploadPreset;
      request.fields['resource_type'] = 'image';
      request.fields['folder'] = folderPath;
      request.fields['public_id'] = imageName;

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
        print("Cloudinary Response: $jsonResponse");

        // Create the ImageModel from the response
        return ImageModel.fromCloudinaryResponse(jsonResponse);
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadImageFileInDB(ImageModel image) async {
    try {
      final data = await _db.collection('Images').add(image.toJson());
      return data.id;
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
