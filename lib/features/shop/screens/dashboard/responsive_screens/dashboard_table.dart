import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Heading
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: ASizes.spaceBtwSections),
              //Cards
              const Row(
                children: [
                  Expanded(
                    child: ADashboardCard(
                        title: 'Sales Total', subTitle: '\$365', stats: 25),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                        title: 'Average order value',
                        subTitle: '\$25',
                        stats: 15),
                  ),
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwItems),
              const Row(
                children: [
                  Expanded(
                    child: ADashboardCard(
                        title: 'Total Orders', subTitle: '36', stats: 44),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                        title: 'Visitors', subTitle: '25353', stats: 3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
