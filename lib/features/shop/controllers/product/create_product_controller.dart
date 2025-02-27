import 'package:aura_kart_admin_panel/data/repositories/product/product_repositroy.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_image_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/product_category_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/product_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../models/brand_model.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  // Observables for loading state and product details
  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

  // Controllers and keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDescriptionFormKey = GlobalKey<FormState>();

  final productRepository = Get.put(ProductRepository());

  // Text editing controllers for input fields
  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  // Rx observables for selected brand and categories
  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  // Flags for traciing different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Function to show progress dialog
  void showProgressDialog() {
    // Implementation for showing progress dialog
    // This can be a simple Get.dialog or any other implementation
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  // Functions for creating a new product
  Future<void> createProduct() async {
    try {
      // Show Progress Dialog
      showProgressDialog();

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Validate title & description form
      if (!titleDescriptionFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Validate stock & price form if ProductType is Single
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Check if a brand is selected
      if (selectedBrand.value == null) throw 'Select Brand for this product';

      // Check variation data if ProductType = Variable
      if (productType.value == ProductType.variable &&
          ProductVariationController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the Product Type Variable. Create some variations or change the Product Type';
      }

      if (productType.value == ProductType.variable) {
        final variationCheckFailed =
            ProductVariationController.instance.productVariations.any((e) =>
                e.price.isNaN ||
                e.stock.isNaN ||
                e.price < 0 ||
                e.salePrice.isNaN ||
                e.salePrice < 0 ||
                e.stock < 0 ||
                e.image.value.isEmpty);

        if (variationCheckFailed) {
          throw 'Invalid Variation Data. Check the variation data and try again';
        }
      }

      // Upload Product Thumbnail Image
      thumbnailUploader.value = true;
      final imagesController = ProductImagesController.instance;
      if (imagesController.selectedThumbnailImageUrl.value == null) {
        throw 'Select a Thumbnail Image for the Product';
      }

      // Additional Product Images
      additionalImagesUploader.value = true;

      // Product Variation Images
      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // If admin added variations & then changed the Product Type, remove all varaitions
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      // Map Product Data to ProductModel
      final newRecord = ProductModel(
        id: '',
        sku: '',
        productAttributes:
            ProductAttributesController.instance.productAttributes,
        date: DateTime.now(),
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variations,
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imagesController.additionalProductImageUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
        thumbnail: imagesController.selectedThumbnailImageUrl.value ?? '',
        productType: productType.value.toString(),
        description: description.text.trim(),
      );

      // Call repository to create new Product
      productDataUploader.value = true;
      newRecord.id = await ProductRepository.instance.createProduct(newRecord);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) throw 'Error storing data. Try again';

        // Loop through selected categories and add them to the product
        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          // Map Data
          final productCategory = ProductCategoryModel(
              productId: newRecord.id, categoryId: category.id);

          await ProductRepository.instance
              .createProductCategory(productCategory);
        }

        // Update Product List
        ProductController.instance.addItemToLists(newRecord);

        // Close the Loader
        AFullScreenLoader.stopLoading();

        // Show Success Message
        showCompletionDialog();
      }
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Function to reset form values & flags
  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    description.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    selectedBrand.value = null;
    brandTextField.clear();
    selectedCategories.clear();
    ProductAttributesController.instance.resetProductAttributes();
    ProductVariationController.instance.resetAllValues();

    // Reset Upload Flags
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  // Build a checkbox widget
  Widget buildCheckbox(
    String label,
    RxBool value,
  ) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color: Colors.blue,
                )
              : const Icon(CupertinoIcons.checkmark_alt_circle),
        ),
        const SizedBox(width: ASizes.spaceBtwItems),
        Text(label),
      ],
    );
  }

  // Function to show completion dialog
  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congradulations!'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Go to Products'),
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AImages.productsIllustration, height: 200, width: 200),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              'Congradulations!',
              style: Theme.of(Get.context!).textTheme.headlineSmall,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text('Your product has been successfully created'),
          ],
        ),
      ),
    );
  }
}
