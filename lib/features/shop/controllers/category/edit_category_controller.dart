import 'package:aura_kart_admin_panel/data/repositories/category/category_repository.dart';
import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  /// Init Data
  void init(CategoryModel category) {
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    imageURL.value = category.image;
    if (category.parentId.isNotEmpty) {
      selectedParent.value = CategoryController.instance.allItems
          .where((c) => c.id == category.parentId)
          .single;
    }
  }

  /// Register Category
  Future<void> updateCategory(CategoryModel category) async {
    try {
      // Start Loading
      AFullScreenLoader.popUpCircular();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Map Data
      category.image = imageURL.value;
      category.name = name.text.trim();
      category.parentId = selectedParent.value.id;
      category.isFeatured = isFeatured.value;
      category.updatedAt = DateTime.now();

      // Call Repository to create new user
      await CategoryRepository.instance.updateCategory(category);

      // Update all Data list
      CategoryController.instance.updateItemfromLists(category);

      // Reset Form
      resetFields();

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Success Message & Redirect
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Record has been updated.');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
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

  /// Method to reset field
  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }
}
