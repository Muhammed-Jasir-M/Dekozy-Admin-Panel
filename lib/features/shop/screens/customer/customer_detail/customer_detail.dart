import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/responsive_screens/customer_detail_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/responsive_screens/customer_detail_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/responsive_screens/customer_detail_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailScreen extends StatelessWidget {
  const CustomerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customer = Get.arguments;
    final customerId = Get.parameters['customerId'];

    return ASiteTemplate(
      desktop: CustomerDetailDesktopScreen(
          customer: customer, customerId: customerId ?? ''),
      tablet: CustomerDetailTabletScreen(
          customer: customer, customerId: customerId ?? ''),
      mobile: CustomerDetailMobileScreen(
          customer: customer, customerId: customerId ?? ''),
    );
  }
}
