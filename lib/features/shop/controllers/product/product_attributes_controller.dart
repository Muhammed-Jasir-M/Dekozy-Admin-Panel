import 'package:aura_kart_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:aura_kart_admin_panel/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductAttributesController extends GetxController {
  static ProductAttributesController get instance => Get.find();

  // Observables for loading state, form key, and product attributes
  final isLoading = false.obs;
  final attributesFormKey = GlobalKey<FormState>();
  TextEditingController attributeName = TextEditingController();
  TextEditingController attributes = TextEditingController();
  final RxList<ProductAttributeModel> productAttributes =
      <ProductAttributeModel>[].obs;

  // Function to add a new attribute
  void addNewAttribute() {
    // Form Validation
    if (!attributesFormkey.currentState!.validate()) {
      return;
    }

    // Add Attributes to the List of Attributes
    productAttributes.add(ProductAttributeModel(
        name: attributeName.text.trim(),
        values: attributes.text.trim().split('|').toList()));
    // clear text field after adding
    attributeName.text = '';
    attributes.text = '';
  }

  // Function to remove an attribute
  void removeAttribute(int index, BuildContext context) {
    // Show confirmation dialog
    ADialogs.defaultDialog(
      context: context,
      onConfirm: () {
        // User confirmed, remove the attribute
        Navigator.of(context).pop();
        productAttributes.removeAt(index);

        // Reset productvariations when removing an attribute
        ProductVariationController.instance.productvariations.value = [];
      },
    );
  }

// function to reset productAttributes
  void resetProductAttributes() {
    productAttributes.clear();
  }
}
