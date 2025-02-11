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
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(BrandRepository());
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // init data
  void init(BrandModel brand) {
    name.text = brand.name;
    imageURL.value = brand.image;
    isFeatured.value = brand.isFeatured!;
    if (brand.brandCategories != null) {
      selectedCategories.addAll(brand.brandCategories ?? []);
    }
  }

  // toggle category selection
  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // method to reset fields
  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
  }

  // pick thumbnail images from media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages =
        await controller.SelectedImagesFromMedia();

    // handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // set the selected image to the main image
      ImageModel selectedImage = selectedImages.first;
      // update the main image using the selectedimages
      imageURL.value = selectedImage.url;
    }
  }

  // register the brand
  Future<void> updateBrand(BrandModel) async {
    try {
      // start loading
      AFullScreenLoader.popUpCircular();

      //check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!formKey.currentState!.widget()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // is data updated
      bool isBrandUpdated = false;
      if (brand.image != imageURL.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;

        // map data
        brand.image = imageURL.value;
        brand.name = name.text.trim();
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();

        // call repository to update
        await repository.updateBrand(brand);
      }
      // update Brandcategories
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // update brand data in profucts
      if (isBrandUpdated) await updateBrandInProducts(brand);

      // update all data in list
      BrandController.instance.updateItemforLists(brand);

  

      // remove loaders
      AFullScreenLoader.stopLoading();

      //success messege & redirect
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'your record has been updated');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Uh Oh', message: e.toString());
    }
  }

  // update categories of this brand
  updateBrandCategories(BrandModel brand) async {
    // fetch all BrandCategories
    final brandCategories =
        await repository.getCategoriesOfSpecificBrand(brand.id);

    // selected categories
    final selectedCategoryIds = selectedCategories.map((e) => e.id);

    // identify categhories to remove
    final categoriesToRemove = brandCategories
        .where((existingCategory) =>
            !selectedCategoryIds.contains(existingCategory.categoryId))
        .toList();

    // remove unselected categories
    for (var categoryToRemove in categoriesToRemove) {
      await BrandRepository.instance
          .deleteBrandCategory(categoryToRemove.id ?? '');
    }

    // identify new category to add
    final newCategoriesToAdd = selectedCategories
        .where((newCategory) => !brandCategories.any((existingCategory) =>
            existingCategory.categoryId == newCategory.id))
        .toList();

    // add new categories
    for (var newCategory in newCategoriesToAdd) {
      var brandCategory =
          BrandCategoryModel(brandId: brand.id, categoryId: newCategory.id);
      brandCategory.id =
          await BrandRepository.instance.createBrandCategory(brandCategory);
    }

    brand.brandCategories!.assignAll(selectedCategories);
    BrandController.instance.updateItemforLists(brand);
  }

  //updatew profuct of this brand
  updateBrandInProducts(BrandModel brand) async {}
}
