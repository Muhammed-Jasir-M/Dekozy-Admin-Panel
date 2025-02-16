import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/routes.dart';

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

class CreateProductMobileScreen extends StatelessWidget {
  const CreateProductMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const ProductBottomNavigationButtons(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              ABreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Product',
                breadcrumbItems: [ARoutes.products, 'Create Product'],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Create Product
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: ASizes.spaceBtwItems),

                        // Product Type
                        const ProductTypeWidget(),
                        const SizedBox(height: ASizes.spaceBtwInputFields),

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
                  const SizedBox(width: ASizes.defaultSpace),

                  // Product Thumbnail Image
                  const ProductThumbnailImage(),
                  const SizedBox(height: ASizes.spaceBtwSections),

                  // Product Images
                  ARoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('All Product Images',
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: ASizes.spaceBtwItems),
                        ProductAdditionalImages(
                          additionalProductImagesURLs: RxList<String>.empty(),
                          onTapToAddImages: () {},
                          onTapToRemoveImage: (index) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: ASizes.spaceBtwSections),

                  // Product Brand
                  const ProductBrand(),
                  const SizedBox(height: ASizes.spaceBtwSections),

                  // Product Categories
                  const ProductCategories(),
                  const SizedBox(height: ASizes.spaceBtwSections),

                  // Product Visibility
                  const ProductVisibilityWidget(),
                  const SizedBox(height: ASizes.spaceBtwSections),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
