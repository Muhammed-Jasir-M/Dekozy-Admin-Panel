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

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  /// Method to Reset Fileds
  void resetFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
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

  /// Register new Category
  Future<void> createcategory() async {
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
      final newRecord = CategoryModel(
        id: '',
        image: imageURL.value,
        name: name.text.trim(),
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
        parentId: selectedParent.value.id,
      );

      newRecord.id =
          await CategoryRepository.instance.createCategory(newRecord);

      // Update All Data list
      CategoryController.instance.addItemToLists(newRecord);

      // Reset Form
      resetFields();

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Success Message & Redirect
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'New Record Has Been Added.');
    } catch (e) {
      AFullScreenLoader.stopLoading();

      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
