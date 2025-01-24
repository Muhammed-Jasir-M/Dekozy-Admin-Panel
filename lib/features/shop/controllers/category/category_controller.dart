import 'package:aura_kart_admin_panel/data/repositories/category/category_repository.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;

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
      selectedRows.assignAll(List.generate(allItems.length, (_) => false));

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

  confirmAndDeleteItem(CategoryModel category) {
    // show a confrimation dialogue box
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are You sure You Want to delete this item ??'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: () async => await deleteOnConfirm(category),
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: ASizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ASizes.buttonRadius * 5)),
          ),
          child: const Text('OK'),
        ),
      ),
      cancel: SizedBox(
        width: 80,
        child: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: ASizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ASizes.buttonRadius * 5)),
          ),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  deleteOnConfirm(CategoryModel category) async {
    try {
      // remove the confirmation dialog
      AFullScreenLoader.stopLoading();

      // start the loader
      AFullScreenLoader.popUpCircular();

      // delete firestore data
      await _categoryRepository.deleteCategory(category.id);

      removeItemFromList(category);
      AFullScreenLoader.stopLoading();
      ALoaders.successSnackBar(
          title: 'Item Deleted', message: 'Your item has been deleted');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oopsie Doopsie!!', message: e.toString());
    }
  }

  // method for removing an item from the lists
  void removeItemFromList(CategoryModel item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(
        allItems.length, (index) => false)); // initialize slsected rows
  }
}
