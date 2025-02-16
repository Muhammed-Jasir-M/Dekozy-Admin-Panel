import 'dart:convert';
import 'dart:typed_data';
import 'package:aura_kart_admin_panel/utils/constants/api_constants.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../features/media/models/image_model.dart';

/// Helper functions for cloud-related operations.
class ACloudHelperFunctions {
  /// Helper function to check the state of a single database record.
  ///
  /// Returns a Widget based on the state of the snapshot.
  /// If data is still loading, it returns a CircularProgressIndicator.
  /// If no data is found, it returns a generic "No Data Found" message.
  /// If an error occurs, it returns a generic error message.
  /// Otherwise, it returns null.
  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Helper function to check the state of multiple (list) database records.
  ///
  /// Returns a Widget based on the state of the snapshot.
  /// If data is still loading, it returns a CircularProgressIndicator.
  /// If no data is found, it returns a generic "No Data Found" message or a custom nothingFoundWidget if provided.
  /// If an error occurs, it returns a generic error message.
  /// Otherwise, it returns null.
  static Widget? checkMultiRecordState<T>({
    required AsyncSnapshot<List<T>> snapshot,
    Widget? loader,
    Widget? error,
    Widget? nothingFound,
  }) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('No Data Found!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Something went wrong.'));
    }

    return null;
  }

  /// Upload any Image using Uint8List
  Future<ImageModel> uploadImageFileCloudinary({
    required Uint8List fileData,
    required String mimeType,
    required String folderPath,
    required String imageName,
  }) async {
    try {
      String resourceType = mimeType.startsWith('image/') ? 'image' : 'raw';

      final uri = Uri.parse(APIConstants.getCloudinaryBaseUrl(resourceType));

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

        // Create the ImageModel from the response
        return ImageModel.fromCloudinaryResponse(
          jsonResponse,
          folderPath,
          imageName,
          mimeType,
        );
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  // Delete file from Cloudinary & corresponding document from Firebase
  Future<void> deleteImageFileFromCloudinary(ImageModel image) async {
    try {
      String resourceType = image.contentType == 'image' ? 'image' : 'raw';

      final uri = Uri.parse(APIConstants.getCloudinaryDeleteUrl(resourceType));

      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final publicId = image.publicId;

      final signatureString =
          'public_id=$publicId&timestamp=$timestamp${APIConstants.cloudinaryApiSecret}';

      final bytes = utf8.encode(signatureString);
      final signature = sha1.convert(bytes).toString();

      final response = await http.post(uri, body: {
        'public_id': publicId,
        'timestamp': timestamp.toString(),
        'api_key': APIConstants.cloudinaryApiKey,
        'signature': signature,
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Image deleted successfully from Cloudinary: $jsonResponse');
      } else {
        throw Exception(
            'Failed to delete image from Cloudinary: ${response.body}');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  /// Retrieve the download URL from a given Cloudinary URL (use this when you already have the image's Cloudinary URL)
  static Future<String> getURLFromCloudinaryURI(String url) async {
    try {
      if (url.isEmpty) return '';
      return url;
    } catch (e) {
      throw 'Something went wrong.';
    }
  }
}
