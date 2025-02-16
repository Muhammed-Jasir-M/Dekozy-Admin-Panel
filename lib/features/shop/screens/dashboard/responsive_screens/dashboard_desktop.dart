import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../widgets/order_status_graph.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const Row(
                children: [
                  Expanded(
                    child: ADashboardCard(
                      title: 'Sales Total',
                      subTitle: '\u{20B9}365',
                      stats: 25,
                    ),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                        title: 'Average Order Value',
                        subTitle: '\u{20B9}25',
                        stats: 15),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                      title: 'Total Orders',
                      subTitle: '36',
                      stats: 44,
                    ),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                      title: 'Visitors',
                      subTitle: '25353',
                      stats: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// Graphs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graph
                        AWeekklySaleGraph(),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        /// Orders
                        ARoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Orders',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: ASizes.spaceBtwSections),
                              const DashboardOrderTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: ASizes.spaceBtwSections),

                  /// Pie Chart
                  Expanded(child: AOrderStatusPieChart()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
