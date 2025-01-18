import 'package:aura_kart_admin_panel/features/shop/screens/brand/all_brands/widgets/data_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';

class BrandsMobileScreen extends StatelessWidget {
  const BrandsMobileScreen({super.key});

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
              const ABreadcrumbsWithHeading(
                  heading: 'Brands', breadcrumbItems: ['Brands']),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Table body
              ARoundedContainer(
                child: Column(
                  children: [
                    // Table header
                    ATableHeader(
                        buttonText: 'Create a new word',
                        onPressed: () => Get.toNamed(ARoutes.createBrand)),
                    const SizedBox(height: ASizes.spaceBtwItems),

                    // Table
                    const BrandsTable(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}