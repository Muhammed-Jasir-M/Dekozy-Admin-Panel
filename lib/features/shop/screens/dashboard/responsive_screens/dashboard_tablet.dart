import 'package:aura_kart_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Cards
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => ADashboardCard(
                        headingIcon: Iconsax.note,
                        headingIconColor: Colors.blue,
                        headingIconBgColor: Colors.blue.withValues(alpha: 0.1),
                        context: context,
                        title: 'Sales Total',
                        subTitle:
                            '₹${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                        stats: 25,
                      ),
                    ),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: Obx(
                      () => ADashboardCard(
                        headingIcon: Iconsax.external_drive,
                        headingIconColor: Colors.green,
                        headingIconBgColor: Colors.green.withValues(alpha: 0.1),
                        title: 'Average Order Value',
                        context: context,
                        subTitle:
                            '₹${controller.orderController.allItems.isNotEmpty ? (controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2) : '0.00'}',
                        stats: 15,
                        icon: Iconsax.arrow_down,
                        color: AColors.error,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ASizes.spaceBtwItems),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => ADashboardCard(
                        headingIcon: Iconsax.box,
                        headingIconColor: Colors.deepPurple,
                        headingIconBgColor:
                            Colors.deepPurple.withValues(alpha: 0.1),
                        title: 'Total Orders',
                        subTitle:
                            '${controller.orderController.allItems.length}',
                        context: context,
                        stats: 44,
                      ),
                    ),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: Obx(
                      () => ADashboardCard(
                        headingIcon: Iconsax.user,
                        headingIconColor: Colors.deepOrange,
                        headingIconBgColor:
                            Colors.deepOrange.withValues(alpha: 0.1),
                        context: context,
                        title: 'Visitors',
                        subTitle: controller.customerController.allItems.length
                            .toString(),
                        stats: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// Bar Graph
              AWeekklySaleGraph(),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// Orders
              ARoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent orders',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: ASizes.spaceBtwSections),
                    const DashboardOrderTable(),
                  ],
                ),
              ),
              const SizedBox(width: ASizes.spaceBtwSections),

              /// Pie Chart
              AOrderStatusPieChart()
            ],
          ),
        ),
      ),
    );
  }
}
