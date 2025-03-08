import 'package:aura_kart_admin_panel/features/personalisation/controllers/settings_controller.dart';
import 'package:aura_kart_admin_panel/features/personalisation/models/setting_model.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingsRepository extends GetxController {
  static SettingsController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save data on firestore
  Future<void> registerSettings(SettingsModel settings) async {
    try {
      await _db
          .collection("Settings")
          .doc('GLOBAL_SETTTINGS')
          .set(settings.toJson());
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Someting went wrong....please try again';
    }
  }

  // fucntion to fetch setting details based on setting id
  Future<SettingsModel> getSettings() async {
    try {
      final querySnapshot =
          await _db.collection("Settings").doc('GLOBAL_SETINGS').get();
      return SettingsModel.fromSnapshot(querySnapshot);
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something went wrong: $e');
      throw 'Something went wrong: $e';
    }
  }

  // function to update setting data in firestore
  Future<void> updateSettingsDetails(SettingsModel updatedSetting) async {
    try {
      await _db
          .collection("Settings")
          .doc('GLOBAL_SETTINGS')
          .update(updatedSetting.toJson());
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong....please try again';
    }
  }

  // update any field specific settings cololectoin
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Settings").doc('GLOBAL_SETTINGS').update(json);
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong...okease try again';
    }  
  }
}
