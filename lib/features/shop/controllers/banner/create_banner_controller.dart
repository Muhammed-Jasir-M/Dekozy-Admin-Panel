
import 'dart:math';

import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/banner_model.dart';
import 'package:aura_kart_admin_panel/routes/app_screens.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banners/banner_repository.dart';

class CreateBannerController extends GetxController{
  static CreateBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final formkey = GlobalKey<FormState>();
   
  // pick thuumbnail image from media
  void pickimage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();


    // handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {

      // set the selecte dmage to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;

      // update the main using the selected image
      imageURL.value = selectedImage.url;
    }
  }

  // register new banner
  Future<void> createBanenr() async {
    try {
 
      // statrt loading 
      AFullScreenLoader.popUpCircular();

      // chechk internet connectivity
      final isConnected  = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!formkey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // map data
      final newRecord = BannerModel(
        id: '',
        active: isActive.value,
        imageUrl: imageURL.value,
        targetScreen: targetScreen.value,
      );

      // call repository to create new banner and update id
      newRecord.id = await BannerRepository.instance.createBanner(newRecord);

      // update all data list
      BannerController.instance.addItemToLists(newRecord);

      // re,ove loader
      AFullScreenLoader.stopLoading();

      // success messege and redirect
      ALoaders.successSnackBar(title: 'Congratulations', message: 'New Record has been added');
    } catch (E) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
}