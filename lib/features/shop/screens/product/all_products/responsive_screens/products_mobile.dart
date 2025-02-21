import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/all_products/table/products_table.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/routes.dart';

class ProductsMobileScreen extends StatelessWidget {
  const ProductsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const ABreadcrumbsWithHeading(
                  heading: 'Products', breadcrumbItems: ['Products']),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Table Body
              Obx(
                () {
                  if (controller.isLoading.value) {
                    return const ALoaderAnimation();
                  }

                  return ARoundedContainer(
                    child: Column(
                      children: [
                        // Table Header
                        ATableHeader(
                          buttonText: 'Add Product',
                          onPressed: () => Get.toNamed(ARoutes.createProduct),
                          searchOnChanged: (query) =>
                              controller.searchQuery(query),
                        ),

                        const SizedBox(height: ASizes.spaceBtwItems),

                        // Table
                        const ProductsTable(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
