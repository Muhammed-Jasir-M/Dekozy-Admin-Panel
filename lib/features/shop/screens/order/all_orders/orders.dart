import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/all_orders/responsive_screens/orders_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/all_orders/responsive_screens/orders_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/all_orders/responsive_screens/orders_tablet.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ASiteTemplate(
      desktop: OrdersDesktopScreen(),
      tablet: OrdersTabletScreen(),
      mobile: OrdersMobileScreen(),
    );
  }
}
