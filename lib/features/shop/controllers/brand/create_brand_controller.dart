import 'package:aura_kart_admin_panel/data/repositories/brands/brand_repository.dart';
import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/brand_category_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/brand_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();

  final loading = false.obs;
  
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  final formKey = GlobalKey<FormState>();

  /// Toggle Category Seleciton
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  /// Method to reset fields
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
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

  /// Register new Brand
  Future<void> createBrand() async {
    try {
      // Start Loading
      AFullScreenLoader.popUpCircular();

      // Check  Internet Connectivity
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
      final newRecord = BrandModel(
        id: '',
        productsCount: 0,
        image: imageURL.value,
        name: name.text.trim(),
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      // Call repository to create New Brand
      newRecord.id = await BrandRepository.instance.createBrand(newRecord);

      // Register brand categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) {
          throw 'Error storing relational data. Try again';
        }

        // Loop selected Brand Categories
        for (var category in selectedCategories) {
          // Map Data
          final brandCategory = BrandCategoryModel(
            brandId: newRecord.id,
            categoryId: category.id,
            id: '',
          );
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }
        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }

      // Update all Data list
      BrandController.instance.addItemToLists(newRecord);

      // Reset Form
      resetFields();

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // Succes Messege and Redirect
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'New Record has been added.');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
