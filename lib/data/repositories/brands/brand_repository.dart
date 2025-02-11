import 'dart:io';

import 'package:aura_kart_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/brand_model.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  //  singleton instance of the BrandRepositiory
  static BrandRepository get instance => Get.find();

  //fiebase firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // get all brands from the 'Brands' collection
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'something went wrong!! please try again';
    }
  }

  // get all brands from the brandscatefgory collection
  Future<List<BrandCategoryModel>> getAllBrandCategories() async {
    try {
      final brandCategoryQuery = await _db.collection('BrandCategory').get();
      final brandCategories = brandCategoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'something went wrong!! plaese try again';
    }
  }

  //get specific brand categories for aa given brand id
  Future<List<BrandCategoryModel>> getCategoriesOfSpecificBrand(
      String brandId) async {
    try {
      final brandCatgeoryQuery = await _db
          .collection('BrandCategory')
          .where('brandId', isEqualTo: brandId)
          .get();
      final brandCategories = brandCatgeoryQuery.docs
          .map((doc) => BrandCategoryModel.fromSnapshot(doc))
          .toList();
      return brandCategories;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message!;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'something went wrong!! plaese try again';
    }
  }

  // create a new brand document in the 'Brands' collection
  Future<String> createBrand(BrandModel brand) async {
    try {
      final result = await _db.collection("Brands").add(brand.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong!! plaese try again';
    }
  }

  // create a new brand category document in the 'brandcategory' collection
  Future<String> createBrandCategory(BrandCategoryModel brandCategory) async {
    try {
      final result =
          await _db.collection("BrandCategory").add(brandCategory.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong!! plaese try again';
    }
  }

  // update an existing brand document in the 'brand' collection
  Future<void> updateBrand(BrandModel brand) async {
    try {
      await _db.collection("Brands").doc(brand.id).update(brand.toJson());
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong!! plaese try again';
    }
  }

  //  delete an existing document and its associated brand categories
  Future<void> deleteBrand(BrandModel brand) async {
    try {
      await _db.runTransaction((transaction) async {
        final brandRef = _db.collection("Brands").doc(brand.id);
        final brandSnap = await transaction.get(brandRef);

        if (!brandSnap.exists) {
          throw Exception('Brand not found');
        }

        final brandCatgoriesSnapshot = await _db
            .collection('Brandcategory')
            .where('brandId', isEqualTo: brand.id)
            .get();
        final brandCategories = brandCatgoriesSnapshot.docs
            .map((e) => BrandCategoryModel.fromSnapshot(e));

        if (brandCategories.isNotEmpty) {
          for (var brandCategory in brandCategories) {
            transaction
                .delete(_db.collection('BrandCategory').doc(brandCategory.id));
          }
        }
        transaction.delete(brandRef);
      });
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , please try again';
    }
  }

  // delete a brand document in the 'Brand Category' Collecion
  Future<void> deleteBrandCategory(String brandCategoryId) async {
    try {
      await _db.collection("BrandCategory").doc(brandCategoryId).delete();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong , please try again';
    }
  }
}
