import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BrandsDesktopScreen extends StatelessWidget {
  const BrandsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // breadcrumbs
              const ABreadcrumbsWithHeading(
                  heading: 'Brands', breadcrumbItems: ['Brands']),
              const SizedBox(height: ASizes.spaceBtwSections),

              //table body
              ARoundedContainer(
                child: Column(
                  children: [
                    //table header
                    TTableHeader(buttonText: 'Create a new word', onPressed: () => Get.toNamed(ARoutes.createBrand)),
                    const SizedBox(height: ASizes.spaceBtwItems),

                    // table
                    const BrandTable(),
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
