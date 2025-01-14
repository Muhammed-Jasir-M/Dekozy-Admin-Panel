import 'package:aura_kart_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:aura_kart_admin_panel/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aura_kart_admin_panel/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

/// Entry point of Flutter App
Future<void> main() async {
  // Ensure that wiidgetsssss are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load(fileName: ".env");

  // Initaialize GetX Local Storage

  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((_) => Get.put(AuthenticationRepository()));

  // Main App starts from here ...
  runApp(const MyApp());
}
