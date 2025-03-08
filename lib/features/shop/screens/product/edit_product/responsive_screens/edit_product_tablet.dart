import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_image_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/product_model.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/create_product/widgets/product_ar_model.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../utils/constants/sizes.dart';

import '../widgets/product_additional_images.dart';
import '../widgets/product_attributes.dart';
import '../widgets/product_bottom_navigation_buttons.dart';
import '../widgets/product_brand.dart';
import '../widgets/product_categories.dart';
import '../widgets/product_stock_and_pricing.dart';
import '../widgets/product_thumbnail_image.dart';
import '../widgets/product_title_description.dart';
import '../widgets/product_type_widget.dart';
import '../widgets/product_variations.dart';
import '../widgets/product_visibility_widget.dart';

class EditProductTabletScreen extends StatelessWidget {
  const EditProductTabletScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());

    return Scaffold(
      bottomNavigationBar: ProductBottomNavigationButtons(product: product),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              ABreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Edit Product',
                breadcrumbItems: [ARoutes.products, 'Edit Product'],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Edit Product
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: ADeviceUtils.isTabletScreen(context) ? 2 : 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Basic Information
                        const ProductTitleAndDescription(),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        // Stock & Pricing
                        ARoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Heading
                              Text(
                                'Stock & Pricing',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: ASizes.spaceBtwItems),

                              // Product Type
                              const ProductTypeWidget(),
                              const SizedBox(
                                  height: ASizes.spaceBtwInputFields),

                              // Stock
                              const ProductStockAndPricing(),
                              const SizedBox(height: ASizes.spaceBtwSections),

                              // Attributes
                              const ProductAttributes(),
                              const SizedBox(height: ASizes.spaceBtwSections),
                            ],
                          ),
                        ),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        // Variations
                        const ProductVariations(),
                      ],
                    ),
                  ),
                  const SizedBox(width: ASizes.defaultSpace),

                  // Sidebar
                  Expanded(
                    child: Column(
                      children: [
                        // Product Thumnail
                        const ProductThumbnailImage(),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        // Product Images
                        ARoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'All Product Images',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: ASizes.spaceBtwItems),
                              ProductAdditionalImages(
                                additionalProductImagesURLs:
                                    controller.additionalProductImageUrls,
                                onTapToAddImages: () =>
                                    controller.selectMultipleProductImages(),
                                onTapToRemoveImage: (index) =>
                                    controller.removeImage(index),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        const ProductArModel(),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        // Product Brand
                        const ProductBrand(),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        // Product Categories
                        ProductCategories(product: product),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        // Product Visibility
                        const ProductVisibilityWidget(),
                        const SizedBox(height: ASizes.spaceBtwSections),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
