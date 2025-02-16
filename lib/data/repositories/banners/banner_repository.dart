import 'dart:io';

import 'package:aura_kart_admin_panel/features/shop/models/banner_model.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/format_exceptions.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/platform_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // firebase firestore instance
  final _db = FirebaseFirestore.instance;

  // get all banners from firestore
  Future<List<BannerModel>> getAllBanners() async {
    try {
      final snapshot = await _db.collection("Banners").get();
      final result =
          snapshot.docs.map((e) => BannerModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw 'something went wrong! cplease try again';
    }
  }

  // craete a new banner in firestore
  Future<String> createBanner(BannerModel banner) async {
    try {
      final result = await _db.collection("Banners").add(banner.toJson());
      return result.id;
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong! plaease try again';
    }
  }

  // update an existing banner in firestore
  Future<String?> updateBanner(BannerModel banner) async {
    try {
      await _db.collection("Banners").doc(banner.id).update(banner.toJson());
      return banner.id;
    } on FirebaseException catch (e) {
       throw AFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const AFormatException();
    } on PlatformException catch (e) {
      throw APlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong! plaease try again';
    }
  }

  deleteBanner(String s) {}



}

