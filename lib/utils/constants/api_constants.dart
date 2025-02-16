// List OF Constants used in APIs

import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConstants {
  static String cloudinaryUploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? "aura_kart_preset";
  static String cloudinaryApiKey = dotenv.env['CLOUDINARY_API_KEY'] ?? '';
  static String cloudinaryApiSecret = dotenv.env['CLOUDINARY_API_SECRET'] ?? '';
  static String cloudinaryCloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';

  static getCloudinaryBaseUrl(String resourceType) {
    return 'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/$resourceType/upload';
  }

  static getCloudinaryDeleteUrl(String resourceType) {
    return 'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/$resourceType/destroy';
  }
}
