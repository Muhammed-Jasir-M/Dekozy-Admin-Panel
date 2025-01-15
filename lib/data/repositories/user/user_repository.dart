import 'package:aura_kart_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:aura_kart_admin_panel/features/authentication/models/user_model.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Function to save user data to firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong.please try again';
    }
  }

  /// Function to fetch user details based on user ID
  Future<UserModel> fetchAdminDetails() async {
    try {
      final docSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRepository.instance.authUser!.uid)
          .get();

      return UserModel.fromSnapshot(docSnapshot);
    } on FirebaseAuthException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('Something Went Wrong: $e');
      throw 'Something went wrong.$e';
    }
  }
}
