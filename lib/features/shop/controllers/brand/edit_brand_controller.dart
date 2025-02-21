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

class EditBrandController extends GetxController {
  static EditBrandController get instance => Get.find();

  final loading = false.obs;

  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  final repository = Get.put(BrandRepository());

  final formKey = GlobalKey<FormState>();

  // Init Data
  void init(BrandModel brand) {
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  // Toggle Category Selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  /// Method to Reset Fields
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
  }

  /// Pick Thumbnail Images from Media
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

  // Register Brand
  Future<void> updateBrand(BrandModel brand) async {
    try {
      // Start loading
      AFullScreenLoader.popUpCircular();

      // Check Internet Connection
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

      // Is Data updated
      bool isBrandUpdated = false;
      if (brand.image != imageURL.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        // Map Data
        brand.image = imageURL.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        // Call Repository to update
        await repository.updateBrand(brand);
      }

      // Update BrandCategories
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // Update Brand Data in Products
      if (isBrandUpdated) await updateBrandInProducts(brand);

      // Update all Data in list
      BrandController.instance.updateItemfromLists(brand);

      // Remove Loaders
      AFullScreenLoader.stopLoading();

      // Success Messege & Redirect
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Record has been updated.');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Update Categories of this Brand
  updateBrandCategories(BrandModel brand) async {
    // Fetch all BrandCategories
    final brandCategories =
        await repository.getCategoriesOfSpecificBrand(brand.id);

    // Selected Categories
    final selectedCategoryIds = selectedCategories.map((e) => e.id);

    // Identify categories to remove
    final categoriesToRemove = brandCategories
        .where(
          (existingCategory) =>
              !selectedCategoryIds.contains(existingCategory.categoryId),
        )
        .toList();

    // Remove unselected categories
    for (var categoryToRemove in categoriesToRemove) {
      await BrandRepository.instance
          .deleteBrandCategory(categoryToRemove.id ?? '');
    }

    // Identify new Categories to add
    final newCategoriesToAdd = selectedCategories
        .where(
          (newCategory) => !brandCategories.any((existingCategory) =>
              existingCategory.categoryId == newCategory.id),
        )
        .toList();

    // Add new categories
    for (var newCategory in newCategoriesToAdd) {
      var brandCategory =
          BrandCategoryModel(brandId: brand.id, categoryId: newCategory.id);
      brandCategory.id =
          await BrandRepository.instance.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemfromLists(brand);
  }

  /// Update Products of this Brand
  updateBrandInProducts(BrandModel brand) async {}
}
