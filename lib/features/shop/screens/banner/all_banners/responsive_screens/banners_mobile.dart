import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/banner/banner_controller.dart';
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
    final controller = Get.put(BannerController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const ABreadcrumbsWithHeading(
                  heading: 'Banners', breadcrumbItems: ['Banners']),
              const SizedBox(height: ASizes.spaceBtwSections),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(ARoutes.createBanner),
                      child: Text('Create Banner'),
                    ),
                  ),
                ],
              ),

              // Table Body
              Obx(
                () {
                  // Show Loader
                  if (controller.isLoading.value) {
                    return const ALoaderAnimation();
                  }

                  return ARoundedContainer(
                    child: Column(
                      children: [
                        // Table Header
                        ATableHeader(searchEnabled: false, showLeftWidget: false),
                        const SizedBox(height: ASizes.spaceBtwItems),

                        // Table
                        const BannersTable(),
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
