import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;

class APIConstants {
  // Use Remote Config in production, dotenv in development
  static String get cloudinaryCloudName {
    if (kReleaseMode) {
      return FirebaseRemoteConfig.instance.getString('CLOUDINARY_CLOUD_NAME');
    }
    return dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  }
  
  static String get cloudinaryApiKey {
    if (kReleaseMode) {
      return FirebaseRemoteConfig.instance.getString('CLOUDINARY_API_KEY');
    }
    return dotenv.env['CLOUDINARY_API_KEY'] ?? '';
  }
  
  static String get cloudinaryApiSecret {
    if (kReleaseMode) {
      return FirebaseRemoteConfig.instance.getString('CLOUDINARY_API_SECRET');
    }
    return dotenv.env['CLOUDINARY_API_SECRET'] ?? '';
  }
  
  static String get cloudinaryUploadPreset {
    if (kReleaseMode) {
      return FirebaseRemoteConfig.instance.getString('CLOUDINARY_UPLOAD_PRESET');
    }
    return dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? 'aura_kart_preset';
  }

  static getCloudinaryUploadUrl(String cloudName, String resourceType) {
    return 'https://api.cloudinary.com/v1_1/$cloudName/$resourceType/upload';
  }

  static getCloudinaryDeleteUrl(String cloudName, String resourceType) {
    return 'https://api.cloudinary.com/v1_1/$cloudName/$resourceType/destroy';
  }
}
