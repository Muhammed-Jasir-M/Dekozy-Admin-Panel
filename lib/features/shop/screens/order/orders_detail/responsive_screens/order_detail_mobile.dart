import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/orders_detail/widgets/customer_info.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/orders_detail/widgets/order_info.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/orders_detail/widgets/order_items.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/orders_detail/widgets/order_transaction.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderDetailMobileScreen extends StatelessWidget {
  const OrderDetailMobileScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              ABreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: order.id,
                breadcrumbItems: [ARoutes.orders, 'Details'],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Order Info
              OrderInfo(order: order),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Items
              OrderItems(order: order),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Transaction
              OrderTransaction(order: order),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Order Customer
              OrderCustomer(order: order),
              const SizedBox(height: ASizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
