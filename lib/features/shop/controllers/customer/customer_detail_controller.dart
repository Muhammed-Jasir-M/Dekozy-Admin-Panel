import 'package:aura_kart_admin_panel/data/repositories/address/address_repository.dart';
import 'package:aura_kart_admin_panel/data/repositories/user/user_repository.dart';
import 'package:aura_kart_admin_panel/features/personalisation/models/user_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading = true.obs;
  RxBool addressesLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  final addressReppository = Get.put(AddressRepository());

  final searchTextController = TextEditingController();

  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrers = <OrderModel>[].obs;

  /// Load customer orders
  Future<void> getCustomerOrders() async {
    try {
      // Show loader while loading data
      ordersLoading.value = true;

      // Fetch customer orders & addreses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders =
            await UserRepository.instance.fetchUserOrders(customer.value.id!);
      }
      
      // Update the categories list
      allCustomerOrders.assignAll(customer.value.orders ?? []);

      // Filter featured categories
      filteredCustomerOrers.assignAll(customer.value.orders ?? []);

      // Add all rows as false [Not Selected] & Toggle when required
      selectedRows.assignAll(
        List.generate(
            customer.value.orders != null ? customer.value.orders!.length : 0,
            (index) => false),
      );
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  /// Load customer address
  Future<void> getCustomerAddresses() async {
    try {
      // Show loader while loading data
      addressesLoading.value = true;

      // fetch customer orders & addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses =
            await addressReppository.fecthUserAddresses(customer.value.id!);
      }
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      addressesLoading.value = false;
    }
  }

  /// Search query filter
  void searchQuery(String query) {
    filteredCustomerOrers.assignAll(
      allCustomerOrders.where(
        (customer) =>
            customer.id.toLowerCase().contains(query.toLowerCase()) ||
            customer.orderDate.toString().contains(query.toLowerCase()),
      ),
    );

    // notify listeners about the change
    update();
  }

  /// sorting related code
  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredCustomerOrers.sort(
      (a, b) {
        if (ascending) {
          return a.id.toLowerCase().compareTo(b.id.toLowerCase());
        } else {
          return b.id.toLowerCase().compareTo(a.id.toLowerCase());
        }
      },
    );
    this.sortColumnIndex.value = sortColumnIndex;

    update();
  }
}
