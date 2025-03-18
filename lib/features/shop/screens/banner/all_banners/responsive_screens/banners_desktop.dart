import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../table/datatable.dart';

class BannersDesktopScreen extends StatelessWidget {
  const BannersDesktopScreen({super.key});

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
                        ATableHeader(
                          buttonText: 'Create Banner',
                          onPressed: () => Get.toNamed(ARoutes.createBanner),
                          searchEnabled: false,
                        ),
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
