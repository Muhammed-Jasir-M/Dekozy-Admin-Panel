import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Firebase Firestore Instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all categories from the Categories collection
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final result =
          snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  // Creat a new category document in the 'Categoryies' collection
  Future<String> createCategory(CategoryModel category) async {
    try {
      final data = await _db.collection("Categories").add(category.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  // Delete an existing category document from the 'Categories' collection
  Future<void> deleteCategory(String categoryId) async {
    try {
      await _db.collection("Categories").doc(categoryId).delete();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  // Create a new category document in the 'Categories' collection
  Future<void> updateCategory(CategoryModel category) async {
    try {
      await _db
          .collection("Categories")
          .doc(category.id)
          .update(category.toJson());
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }
}
