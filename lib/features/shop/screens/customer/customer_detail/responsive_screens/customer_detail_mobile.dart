import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/personalisation/models/user_model.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/widgets/customer_info.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/widgets/customer_orders.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/widgets/shipping_address.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({
    super.key,
    required this.customer,
    required this.customerId,
  });

  final UserModel customer;
  final String customerId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerDetailController());
    controller.customer.value = customer;

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
                heading: customer.fullName,
                breadcrumbItems: [ARoutes.customers, 'Details'],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Customer Info
              CustomerInfo(customer: customer),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Shipping Adress
              const ShippingAddress(),
              SizedBox(width: ASizes.spaceBtwSections),

              // Customer Orders
              const CustomerOrders(),
            ],
          ),
        ),
      ),
    );
  }
}
