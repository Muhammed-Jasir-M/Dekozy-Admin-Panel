import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aura_kart_admin_panel/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Load .env file
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}
