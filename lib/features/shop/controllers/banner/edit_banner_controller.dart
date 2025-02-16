import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/banner_model.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banners/banner_repository.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  RxString targetScreen = ''.obs;
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BannerRepository());

  // init data
  void init(BannerModel banner) {
    imageURL.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
  }

  // pick thumbnail image from media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // set the selected image to the main image to perform any other action
      ImageModel selectedImage = selectedImages.first;

      // update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  // register new banner
  Future<void> updateBanner(BannerModel banner) async {
    try {
      // start loading
      AFullScreenLoader.popUpCircular();

      // check internet connecttivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!formKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // is data updated
      if (banner.imageUrl != imageURL.value ||
          banner.targetScreen != targetScreen.value ||
          banner.active != isActive.value) {
        // map data
        banner.imageUrl = imageURL.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        // call repository to update
        await repository.updateBanner(banner);
      }

      // update the list
      BannerController.instance.updateItemforLists(banner);

      // remove loader
      AFullScreenLoader.stopLoading();

      // success ms and redirect
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'Your record has been updated');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Uh oh', message: e.toString()); 
    }
  }
}
