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

  // Abstract method to be implemented by subclass for fetching items.
  Future<List<T>> fetchItems();

  // Abstract method to be implemented by subclass for deleting an item.
  Future<void> deleteItem(T item);

  // Abstract method to be implemented by subclass for checking if an item contains the search query.
  bool containsSearchQuery(T item, String query);

  // Common Method for Fetching Data
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
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Common Method for Searching based on a Query
  void searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where((item) => containsSearchQuery(item, query)),
    );
  }

  // Common Method for Sorting items by a property
  void sortByProperty(
    int sortColumIndex,
    bool ascending,
    Function(T) property,
  ) {
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

  // Method for adding an item to the lists.
  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  // Method for updating an item in the lists
  void updateItemfromLists(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[itemIndex] = item;
  }

  // Method for removing an item from the lists.
  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  // Common Method for confirming deletion and performing the deletion.
  Future<void> confrimAndDeleteItem(T item) async {
    // Show a Confirmation Dialog
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
              borderRadius: BorderRadius.circular(ASizes.buttonRadius * 5),
            ),
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
              borderRadius: BorderRadius.circular(ASizes.buttonRadius * 5),
            ),
          ),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  // Method to be implemented by subclasses for handling confirmation before deleteing an item.
  Future<void> deleteOnConfirm(T item) async {
    try {
      // Remove the Confirmation Dialog
      AFullScreenLoader.stopLoading();

      // Start the Loader
      AFullScreenLoader.popUpCircular();

      // Delete Firestore Data
      await deleteItem(item);

      removeItemFromLists(item);

      AFullScreenLoader.stopLoading();

      ALoaders.successSnackBar(
          title: 'Item Deleted', message: 'Your Item has been Deleted');
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
