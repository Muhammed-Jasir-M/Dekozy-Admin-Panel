import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/all_products/table/products_table.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsDesktopScreen extends StatelessWidget {
  const ProductsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              ABreadcrumbsWithHeading(
                  heading: 'Products', breadcrumbItems: ['Products']),
              SizedBox(height: ASizes.spaceBtwSections),

              // Table Body
              ARoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    ATableHeader(
                      buttonText: 'Add Product',
                      onPressed: () => Get.toNamed(ARoutes.createProduct),
                    ),

                    SizedBox(height: ASizes.spaceBtwItems),

                    // Table
                    const ProductsTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
