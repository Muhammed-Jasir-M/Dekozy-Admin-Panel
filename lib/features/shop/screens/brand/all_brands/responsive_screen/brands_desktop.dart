import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../widgets/data_table.dart';

class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
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
                        onPressed: () => Get.toNamed(ARoutes.createBrand), 
                        searchOnChanged: (query) => controller.searchQuery(query),
                        ),
                    const SizedBox(height: ASizes.spaceBtwItems),

                    // Table
                    Obx(() {
                      //show loader
                      if (controller.isLoading.value)
                        return const ALoaderAnimation();
                      return const BrandTable();
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
