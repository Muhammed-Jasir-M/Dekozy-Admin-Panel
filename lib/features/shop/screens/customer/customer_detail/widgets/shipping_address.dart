import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/personalisation/models/address_model.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerAddresses();

    return Obx(() {
      if (controller.addressesLoading.value) return const ALoaderAnimation();

      AddressModel selectedAddress = AddressModel.empty();

      if (controller.customer.value.addresses != null) {
        if (controller.customer.value.addresses!.isNotEmpty) {
          selectedAddress = controller.customer.value.addresses!
              .where((e) => e.selectedAddress)
              .single;
        }
      }

      return ARoundedContainer(
        padding: EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwSections),

            // Meta Data
            Row(
              children: [
                const SizedBox(width: 120, child: Text('Name')),
                const Text(':'),
                const SizedBox(width: ASizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(selectedAddress.name,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwItems),

            Row(
              children: [
                const SizedBox(width: 120, child: Text('Country')),
                const Text(':'),
                const SizedBox(width: ASizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(selectedAddress.country,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwItems),

            Row(
              children: [
                const SizedBox(width: 120, child: Text('Phone Number')),
                const Text(':'),
                const SizedBox(width: ASizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(selectedAddress.phoneNumber,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwItems),

            Row(
              children: [
                const SizedBox(width: 120, child: Text('Address')),
                const Text(':'),
                const SizedBox(width: ASizes.spaceBtwItems / 2),
                Expanded(
                  child: Text(selectedAddress.toString(),
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwItems),
          ],
        ),
      );
    });
  }
}
