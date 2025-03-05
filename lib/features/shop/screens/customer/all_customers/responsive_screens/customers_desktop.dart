import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/data_table/table_header.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/authentication/models/user_model.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/all_customers/table/data_table.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.customer.value = customer;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumbs
              const ABreadcrumbsWithHeading(
                  returnToPreviousScreen: true ,heading: 'Customer', breadcrumbItems: const [ARoutes.customers, 'Details']),
              const SizedBox(height: ASizes.spaceBtwSections),

              ARoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    ATableHeader(
                      showLeftWidget: false,
                      searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                    ),
                    const SizedBox(height: ASizes.spaceBtwItems),

                    // Table
                    Obx(() {
                      // show loader
                      if (controller.isLoading.value)
                        return const ALoaderAnimation();
                      return const CustomerTable();
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
