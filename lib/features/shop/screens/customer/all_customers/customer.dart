import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customers_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customers_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/all_customers/responsive_screens/customers_tablet.dart';
import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: CustomersDesktopScreen(),
      tablet: CustomersTabletScreen(),
      mobile: CustomersMobileScreen(),
    );
  }
}
