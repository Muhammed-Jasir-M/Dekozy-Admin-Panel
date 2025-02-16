import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../table/datatable.dart';

class BannersMobileScreen extends StatelessWidget {
  const BannersMobileScreen({super.key});

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
                heading: 'Banners',
                breadcrumbItems: ['Banners'],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Table Body
              ARoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    ATableHeader(
                      buttonText: 'Create New Banner',
                      onPressed: () => Get.toNamed(ARoutes.createBanner),
                    ),
                    
                    const SizedBox(height: ASizes.spaceBtwItems),

                    // Table
                    const BannersTable(),
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
