import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({super.key});
  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      padding: EdgeInsets.all(ASizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shipping Address',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: ASizes.spaceBtwSections),
          //Meta Table
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Name')),
              const Text(':'),
              const SizedBox(width: ASizes.spaceBtwItems / 2),
              Expanded(
                child: Text('Nihal',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(
            height: ASizes.spaceBtwItems,
          ),

          Row(
            children: [
              const SizedBox(width: 120, child: Text('Country')),
              const Text(':'),
              const SizedBox(width: ASizes.spaceBtwItems / 2),
              Expanded(
                child: Text('Karinchappadi',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(
            height: ASizes.spaceBtwItems,
          ),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number')),
              const Text(':'),
              const SizedBox(width: ASizes.spaceBtwItems / 2),
              Expanded(
                child: Text('2345654383',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(
            height: ASizes.spaceBtwItems,
          ),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Address')),
              const Text(':'),
              const SizedBox(width: ASizes.spaceBtwItems / 2),
              Expanded(
                child: Text('Karinchappadi,Newyork,United States',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(
            height: ASizes.spaceBtwItems,
          ),
        ],
      ),
    );
  }
}
