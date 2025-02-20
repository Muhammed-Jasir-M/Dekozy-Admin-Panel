import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ABaseController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  // abstract method to be implemented by subclass for fetching items
  Future<List<T>> fetchItems();

  //abstract method to be implemented by subclass for deleting on item
  Future<void>  deleteItem(T item);

  // abstract method to be implemented by subclass for checking if the items contqains the search query
  bool containsSearchQuery(T item, String query);

  // common method for fetching data
  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (index) => false));
    } catch (e) {
      isLoading.value = false;
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Uh Oh', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

// commmon method for searching based on aa query
  void searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where((item) => containsSearchQuery(item, query)),
    );
  }

  // common methods for sorting a property
  void sortByProperty(
      int sortColumIndex, bool ascending, Function(T) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumIndex;

    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(b).compareTo(property(a));
      }
    });
  }

  //method for adding an item to list
  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  // method for updating an item to lists
  void updateItemforLists(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[itemIndex] = item;
  }

  // method for removing an item from the list
  void removeItemFromList(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  // common method for confirming deletion and performing the deletion
  Future<void> confrimAndDeleteItem(T item) async {
    // show a confirguration dialog
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: () async => deleteOnConfirm(item),
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: ASizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ASizes.buttonRadius * 5)),
          ),
          child: const Text('Ok'),
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

  //method to implement by subclasses for handling confirmation before deleteing an item
  Future<void> deleteOnConfirm(T item) async {
    try {
      //remove the configuration dialog
      AFullScreenLoader.stopLoading();

      //start the loader
      AFullScreenLoader.popUpCircular();

      //delete firestore data
      await deleteItem(item);

      removeItemFromList(item);

      AFullScreenLoader.stopLoading();
      ALoaders.successSnackBar(
          title: 'Item Deleted', message: 'Your item has been deleted');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Uh Oh!', message: e.toString());
    }
  }
}
