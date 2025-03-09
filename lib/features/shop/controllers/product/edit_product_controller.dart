import 'package:aura_kart_admin_panel/data/repositories/product/product_repository.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/category_controller.dart';
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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants/sizes.dart';
import '../../models/brand_model.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  // Observables for loading state and product details
  final isLoading = false.obs;
  final selectedCategoriesLoader = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.published.obs;

  // Controllers and keys
  final stockPriceFormKey = GlobalKey<FormState>();
  final titleDescriptionFormKey = GlobalKey<FormState>();

  final variationController = Get.put(ProductVariationController());
  final attributesController = Get.put(ProductAttributesController());
  final imagesController = Get.put(ProductImagesController());

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
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

  // Flags for tracing different tasks
  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  // Initialize Product Data
  void initProductData(ProductModel product) {
    try {
      isLoading.value = true;

      // Basic Information
      title.text = product.title;
      description.text = product.description ?? '';
      productType.value = product.productType == ProductType.single.toString()
          ? ProductType.single
          : ProductType.variable;

      // Stock & Pricing (assuming productType & productVisibility are handled else where)
      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      // Product Brand
      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? '';

      // Product Thumbnail & Images
      if (product.images != null) {
        // Set the first image as the thumbnail
        imagesController.selectedThumbnailImageUrl.value = product.thumbnail;

        // Add the images to additionalProductsImagesUrls
        imagesController.additionalProductImageUrls
            .assignAll(product.images ?? []);
      }

      // Set the ar model url as the armodel
      imagesController.selectedArModelUrl.value = product.armodel;

      // Product Attributes & Variations (assuming you have a method to fetch variations in ProductVariationController)
      attributesController.productAttributes
          .assignAll(product.productAttributes ?? []);
      variationController.productVariations
          .assignAll(product.productVariations ?? []);
      variationController
          .initializeVariationControllers(product.productVariations ?? []);

      isLoading.value = false;

      update();
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;

    // Product Categories
    final productCategories =
        await productRepository.getProductCategories(productId);
    final categoriesController = Get.put(CategoryController());
    if (categoriesController.allItems.isEmpty) {
      await categoriesController.fetchItems();
    }

    final categoriesIds = productCategories.map((e) => e.categoryId).toList();
    final categories = categoriesController.allItems
        .where((e) => categoriesIds.contains(e.id))
        .toList();
    selectedCategories.assignAll(categories);
    alreadyAddedCategories.assignAll(categories);
    selectedCategoriesLoader.value = false;
    return categories;
  }

  // Functions for Editing product
  Future<void> editProduct(ProductModel product) async {
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

      if (imagesController.selectedArModelUrl.value == null) {
        throw 'Select a Ar Model for the Product';
      }

      // Product Variation Images
      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        // If admin added variations & then changed the Product Type, remove all varaitions
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      // Map Product Data to ProductModel
      product.sku = '';
      product.productAttributes =
          ProductAttributesController.instance.productAttributes;
      product.date = DateTime.now();
      product.isFeatured = true;
      product.title = title.text.trim();
      product.brand = selectedBrand.value;
      product.productVariations = variations;
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.images = imagesController.additionalProductImageUrls;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.thumbnail =
          imagesController.selectedThumbnailImageUrl.value ?? '';
      product.armodel = imagesController.selectedArModelUrl.value ?? '';
      product.productType = productType.value.toString();
      product.description = description.text.trim();

      // Call repository to create new Product
      productDataUploader.value = true;
      await ProductRepository.instance.updateProduct(product);

      // Register product categories if any
      if (selectedCategories.isNotEmpty) {
        // Loop through selected categories and add them to the product
        categoriesRelationshipUploader.value = true;

        // Get the existing category Ids
        List<String> existingCategoryIds =
            alreadyAddedCategories.map((e) => e.id).toList();

        for (var category in selectedCategories) {
          // Check if the category is not already associated with product
          if (!existingCategoryIds.contains(category.id)) {
            // Map Data
            final productCategory = ProductCategoryModel(
                productId: product.id, categoryId: category.id);

            await ProductRepository.instance
                .createProductCategory(productCategory);
          }
        }

        // Remove categories not selected by user
        for (var existingCategoryId in existingCategoryIds) {
          // Check if the category is not present in selected categories
          if (!selectedCategories
              .any((category) => category.id == existingCategoryId)) {
            // Remove the association
            await ProductRepository.instance
                .removeProductCategory(product.id, existingCategoryId);
          }
        }
      }

      // Update Product List
      ProductController.instance.updateItemfromLists(product);

      // Reset Values
      resetValues();

      // Close the Loader
      AFullScreenLoader.stopLoading();

      // Show Success Message
      showCompletionDialog();
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

  // Function to show progress dialog
  void showProgressDialog() {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Updating Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(AImages.uploadingAnimation, height: 200, width: 200),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Checkboxes
              Obx(() => buildCheckbox('Thumbnail Image', thumbnailUploader)),
              const SizedBox(height: ASizes.spaceBtwItems),
              Obx(
                () => buildCheckbox(
                    'Additional Images', additionalImagesUploader),
              ),
              const SizedBox(height: ASizes.spaceBtwItems),
              Obx(
                () => buildCheckbox('Product Data, Attributes & Variations',
                    productDataUploader),
              ),
              const SizedBox(height: ASizes.spaceBtwItems),
              Obx(
                () => buildCheckbox(
                    'Product Categories', categoriesRelationshipUploader),
              ),

              const SizedBox(height: ASizes.spaceBtwItems),
              Text('Sit Tight, Your product is uploading'),
            ],
          ),
        ),
      ),
    );
  }

  // Build a checkbox widget
  Widget buildCheckbox(
    String label,
    RxBool value,
  ) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: value.value
              ? const Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  key: ValueKey('filled'),
                  color: Colors.green,
                  size: 24,
                )
              : const Icon(
                  CupertinoIcons.checkmark_alt_circle,
                  key: ValueKey('outlined'),
                  color: Colors.blue,
                  size: 24,
                ),
        ),
        const SizedBox(width: ASizes.spaceBtwItems),
        Expanded(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: value.value ? Colors.green : Colors.black,
              fontWeight: value.value ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(label),
          ),
        ),
      ],
    );
  }

  // Function to show completion dialog
  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations!'),
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
            Lottie.asset(AImages.uploadingCompletedAnimation,
                height: 200, width: 200),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text(
              'Congratulations!',
              style: Theme.of(Get.context!).textTheme.headlineSmall,
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
            Text('Your product has been successfully updated'),
          ],
        ),
      ),
    );
  }
}
