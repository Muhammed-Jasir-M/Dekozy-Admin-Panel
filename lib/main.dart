import 'package:aura_kart_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:aura_kart_admin_panel/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aura_kart_admin_panel/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that wiidgetsssss are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Initaialize GetX Local Storage
  await GetStorage.init();
  
  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  // Initialize and fetch Remote Config values
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  
  // Set defaults (used until the first successful fetch)
  await remoteConfig.setDefaults({
    'CLOUDINARY_CLOUD_NAME': '',
    'CLOUDINARY_API_KEY': '',
    'CLOUDINARY_API_SECRET': '',
    'CLOUDINARY_UPLOAD_PRESET': '',
  });
  
  await remoteConfig.fetchAndActivate();
      
  // Main App starts from here ...
  runApp(const MyApp());
}
