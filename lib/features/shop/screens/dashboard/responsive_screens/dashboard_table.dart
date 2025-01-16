import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/widgets/dashboard_card.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
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
                      subTitle: '\$365',
                      stats: 25,
                    ),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                      title: 'Average order value',
                      subTitle: '\$25',
                      stats: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ASizes.spaceBtwItems),
              Row(
                children: [
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
              /// Bar Graph
              AWeekklySaleGraph(),
              const SizedBox(height: ASizes.spaceBtwSections),

              /// Orders
              /// Orders
              ARoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent orders',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: ASizes.spaceBtwSections,
                    ),
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
