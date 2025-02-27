import 'dart:core';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:aura_kart_admin_panel/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductVariationController extends GetxController {
  // Singleton instance
  static ProductVariationController get instance => Get.find();

  // Observables for loading state and product variations
  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

  // Lists to store controllers for each variation attribute
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
      salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>>
      descriptionControllersList = [];

  // Instance of ProductAttributesController
  final attributesController = Get.put(ProductAttributesController());

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // Clear existing lists
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

    // Initialize controllers for each variation
    for (var variation in variations) {
      // Stock Controllers
      Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] =
          TextEditingController(text: variation.stock.toString());
      stockControllersList.add(stockControllers);

      // Price Controllers
      Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] =
          TextEditingController(text: variation.price.toString());
      priceControllersList.add(priceControllers);

      // Sale Price Controllers
      Map<ProductVariationModel, TextEditingController> salePriceControllers =
          {};
      salePriceControllers[variation] =
          TextEditingController(text: variation.salePrice.toString());
      salePriceControllersList.add(salePriceControllers);

      // Description Controllers
      Map<ProductVariationModel, TextEditingController> descriptionControllers =
          {};
      descriptionControllers[variation] =
          TextEditingController(text: variation.description);
      descriptionControllersList.add(descriptionControllers);
    }
  }

  void removeVariations(BuildContext context) {
    ADialogs.defaultDialog(
      context: context,
      title: 'Remove Variation',
      onConfirm: () {
        productVariations.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  // Function to generate variations with a confirmation dialog
  void generateVariationsConfirmation(BuildContext context) {
    ADialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate Variations',
      content:
          'Once the variations are created, you cannot add more attributes. In order to add more variations, you have to delete any of the attributes.',
      onConfirm: () => generateVariationsFromAttributes(),
    );
  }

  // Function to generate variations from attributes
  void generateVariationsFromAttributes() {
    // Close the previous Popup
    Get.back();

    final List<ProductVariationModel> variations = [];

    // Check if there are attributes
    if (attributesController.productAttributes.isNotEmpty) {
      // Get all combinations of attribute values, [[Green, Blue], [Small, Large]]
      final List<List<String>> attributeCombinations = getCombinations(
        attributesController.productAttributes
            .map((attr) => attr.values ?? <String>[])
            .toList(),
      );

      // Generate ProductVariationModel for each combination
      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
          attributesController.productAttributes.map((attr) => attr.name ?? ''),
          combination,
        );

        // You can set default values for other properties if needed
        final ProductVariationModel variation = ProductVariationModel(
          id: UniqueKey().toString(),
          attributeValues: attributeValues,
        );
        variations.add(variation);

        // Create controllers
        final Map<ProductVariationModel, TextEditingController>
            stockControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            priceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            salePriceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            descriptionControllers = {};

        // Assuming variation is your current ProductVariationModel
        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();

        // Add the maps to their respective lists
        stockControllersList.add(stockControllers);
        priceControllersList.add(priceControllers);
        salePriceControllersList.add(salePriceControllers);
        descriptionControllersList.add(descriptionControllers);
      }
    }

    // Assign the generated variations to the productVariations list
    productVariations.assignAll(variations);
  }

  // Get all combinations of attribute values
  List<List<String>> getCombinations(List<List<String>> lists) {
    // The result list that will store all combinations
    final List<List<String>> result = [];

    // Start combining attributes from the first one
    combine(lists, 0, <String>[], result);

    // Return the final list of combinations
    return result;
  }

  // Helper function to recursively combine attribute values
  void combine(
    List<List<String>> lists,
    int index,
    List<String> current,
    List<List<String>> result,
  ) {
    // If we have reached the end of the lists, add the current combination to the result
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    // Iterate over the values of the current attribute
    for (final item in lists[index]) {
      // Create an updated list with the current value added
      final List<String> updated = List.from(current)..add(item);

      // Recursively combine with the next attribute
      combine(lists, index + 1, updated, result);
    }
  }

  // Function to reset all values
  void resetAllValues() {
    productVariations.clear();
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();
  }
}
