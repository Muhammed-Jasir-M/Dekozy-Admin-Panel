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
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  //toggle category seleciton
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

  //pick thumbnial from media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // handle the selected images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      //set the selected image to the main image or perform ay other action
      ImageModel selectedImage = selectedImages.first;
      // update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  //register new brand
  Future<void> createBrand() async {
    try {
      // start loading
      AFullScreenLoader.popUpCircular();

      //check  iternet connectivity
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

      // map data
      final newRecord = BrandModel(
        id: '',
        productsCount: 0,
        image: imageURL.value,
        name: name.text.trim(),
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      // call reposotory to create new brand
      newRecord.id = await BrandRepository.instance.createBrand(newRecord);

      // register brand categorues if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty)
          throw 'Error storing relational data. try again';

        // loop selected brand categories
        for (var category in selectedCategories) {
          // map data
          final brandCategory = BrandCategoryModel(brandId: newRecord.id, categoryId: category.id, id: '');
          await BrandRepository.instance.createBrandCategory(brandCategory);
        }
        newRecord.brandCategories ??= [];
        newRecord.brandCategories!.addAll(selectedCategories);
      }

      // update all data list
      BrandController.instance.addItemToLists(newRecord);

      //reset formPcreate
      resetFields();

      // removce loader
      AFullScreenLoader.stopLoading();

      // succes  messege and redirect
      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'New Record has been added');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Uh Oh ', message: e.toString());
    }
  }
}
