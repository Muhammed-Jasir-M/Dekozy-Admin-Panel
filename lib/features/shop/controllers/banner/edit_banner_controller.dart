import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/banner_model.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/banner/banner_repository.dart';

class EditBannerController extends GetxController {
  static EditBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  RxString targetScreen = ''.obs;

  final formKey = GlobalKey<FormState>();

  final repository = Get.put(BannerRepository());

  // Init Data
  void init(BannerModel banner) {
    imageURL.value = banner.imageUrl;
    isActive.value = banner.active;
    targetScreen.value = banner.targetScreen;
  }

  /// Pick Thumbnail Image from Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image or perform any other action
      ImageModel selectedImage = selectedImages.first;
      // Update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  // Register Banner
  Future<void> updateBanner(BannerModel banner) async {
    try {
      // Start Loading
      AFullScreenLoader.popUpCircular();

      // Check Internet Connecttivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!formKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Is Data Updated
      if (banner.imageUrl != imageURL.value ||
          banner.targetScreen != targetScreen.value ||
          banner.active != isActive.value) {

        // Map Data
        banner.imageUrl = imageURL.value;
        banner.targetScreen = targetScreen.value;
        banner.active = isActive.value;

        // Call Repository to Update
        await repository.updateBanner(banner);
      }

      // Update the List
      BannerController.instance.updateItemfromLists(banner);

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Success Message and Redirect
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'Your record has been updated.');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString()); 
    }
  }
}
