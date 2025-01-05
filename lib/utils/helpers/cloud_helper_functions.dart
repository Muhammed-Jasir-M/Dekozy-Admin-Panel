// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:aura_kart_admin_panel/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  /// Upload an image to Cloudinary and get the download URL
  static Future<String> uploadImageToCloudinary({
    required File file,
    required String folderPath,
    required String imageName,
  }) async {
    try {
      if (file.path.isEmpty) throw 'Invalid file path';

      final uri = Uri.parse(APIConstants.cloudinaryBaseUrl);

      var request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = APIConstants.cloudinaryUploadPreset;
      request.fields['resource_type'] = 'image';
      request.fields['folder'] = folderPath;
      request.fields['public_id'] = imageName;

      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        // Get Response
        final responseString = await response.stream.bytesToString();
        // Decode the response
        final data = jsonDecode(responseString);
        // Get the image URL
        final String imageUrl = data['secure_url'];
        return imageUrl;
      } else {
        throw 'Failed to upload image';
      }
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  //
  static Future<void> deleteImageFromCloudinary(String publicId) async {
    try {
      final uri = Uri.parse(APIConstants.cloudinaryDeleteUrl);

      // Create the authentication header
      final authHeader =
          'Basic ${base64Encode(utf8.encode('${APIConstants.cloudinaryApiKey}:${APIConstants.cloudinaryApiSecret}'))}';

      // Send the delete request
      final response = await http.post(
        uri,
        headers: {
          'Authorization': authHeader,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'public_id': publicId,
        }),
      );

      // Parse the response
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['result'] == 'ok') {
        print('File deleted successfully from Cloudinary.');
      } else {
        throw 'Failed to delete file.';
      }
    } catch (e) {
      throw 'Error deleting file: $e';
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
