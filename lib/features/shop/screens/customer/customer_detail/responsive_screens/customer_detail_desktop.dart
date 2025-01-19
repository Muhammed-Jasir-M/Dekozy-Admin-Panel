import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/authentication/models/user_model.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/widgets/customer_info.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/widgets/customer_orders.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/widgets/shipping_address.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CustomerDetailDesktopScreen extends StatelessWidget {
  const CustomerDetailDesktopScreen({super.key, required this.customer});
  final UserModel customer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              const ABreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Nihal',
                breadcrumbItems: [ARoutes.customers, 'Details'],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),
              //Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Customer Information on Left side
                  Expanded(
                    child: Column(
                      children: [
                        //Customer  Info
                        CustomerInfo(customer: customer),
                        const SizedBox(height: ASizes.spaceBtwSections),
                        //Shipping Adress
                        const ShippingAddress(),
                      ],
                    ),
                  ),
                  SizedBox(width: ASizes.spaceBtwSections),
                  //Right Side Customer Orders
                  const Expanded(flex: 2, child: CustomerOrders())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
