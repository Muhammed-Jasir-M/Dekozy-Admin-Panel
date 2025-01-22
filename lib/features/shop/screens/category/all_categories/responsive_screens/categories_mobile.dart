import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/all_categories/table/data_table.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../controllers/category/category_controller.dart';

class CategoriesMobileScreen extends StatelessWidget {
  const CategoriesMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const ABreadcrumbsWithHeading(
                  heading: 'Catogories', breadcrumbItems: ['Catogories']),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Table Body
              // Show Loader
              ARoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    ATableHeader(
                        buttonText: 'Create New Category',
                        onPressed: () => Get.toNamed(ARoutes.createCategory),
                        searchController: controller.searchTextController,
                        searchOnChanged: (query) => controller.searchQuery(query),
                        ),
                    const SizedBox(height: ASizes.spaceBtwItems),
                    
                    // Table
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const ALoaderAnimation();
                      }
                      return const CategoryTable();
                    }),
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
