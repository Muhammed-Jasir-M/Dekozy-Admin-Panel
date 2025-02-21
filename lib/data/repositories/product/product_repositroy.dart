import 'dart:core';
import 'package:aura_kart_admin_panel/features/shop/models/product_category_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/product_model.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // Firebase Instance for Databse Interaction
  final _db = FirebaseFirestore.instance;

  /// Create Product
  Future<String> createProduct(ProductModel product) async {
    try {
      final result = await _db.collection('Products').add(product.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw AFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  /// Create new product category
  Future<String> createProductCategory(
      ProductCategoryModel productCategory) async {
    try {
      final result =
          await _db.collection("ProductCategory").add(productCategory.toJson());
      return result.id;
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

  /// Update Product
  Future<void> updateProduct(ProductModel product) async {
    try {
      await _db.collection('Products').doc(product.id).update(product.toJson());
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  // Update Product Instance
  Future<void> updateProductSpecificValue(id, Map<String, dynamic> data) async {
    try {
      await _db.collection('Products').doc(id).update(data);
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  /// Get limited featured products
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  /// Get limited featured products
  Future<List<ProductCategoryModel>> getAllCategories(String productId) async {
    try {
      final snapshot = await _db
          .collection('ProductCategory')
          .where('productId', isEqualTo: productId)
          .get();
      return snapshot.docs
          .map((querySnapshot) =>
              ProductCategoryModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong!. Please try again';
    }
  }

  Future<void> deleteProduct(ProductModel product) async {
    try {
      // Delete all data once fromm Firebase
      await _db.runTransaction((transaction) async {
        final productRef = _db.collection("Products").doc(product.id);
        final productSnap = await transaction.get(productRef);

        if (!productSnap.exists) {
          throw Exception("Products not found");
        }

        // Fetch ProductCategories
        final productCategoriesSnapshot = await _db
            .collection("ProductCategory")
            .where('productId', isEqualTo: product.id)
            .get();
        final productCategories = productCategoriesSnapshot.docs
            .map((e) => ProductCategoryModel.fromSnapshot(e));

        if (productCategories.isNotEmpty) {
          for (var productCategory in productCategories) {
            transaction.delete(
                _db.collection("ProductCategory").doc(productCategory.id));
          }
        }
        transaction.delete(productRef);
      });
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
