import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return ASiteTemplate(
      desktop: OrderDetailDesktopScreen(order: order),
      tablet: OrderDetailTabletScreen(order: order),
      mobile: OrderDetailMobileScreen(order: order),
    );
  }
}
