import 'package:aura_kart_admin_panel/data/repositories/category/category_repository.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  //Sorting

  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchTextController = TextEditingController();
  final _categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await _categoryRepository.getAllCategories();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;
    filteredItems.sort((a, b) {
      if (ascending) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      } else {
        return b.name.toLowerCase().compareTo(a.name.toLowerCase());
      }
    });
  }

  searchQuery(String query) {
    print(query);
    filteredItems.assignAll(
      allItems.where(
          (item) => item.name.toLowerCase().contains(query.toLowerCase())),
    );
  }
}
