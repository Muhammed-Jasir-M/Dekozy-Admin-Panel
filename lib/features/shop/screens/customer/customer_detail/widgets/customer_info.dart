import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/authentication/models/user_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});
  final UserModel customer;
  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      padding: const EdgeInsets.all(ASizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer Information',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: ASizes.spaceBtwSections),
          //Personal Info Card
          Row(
            children: [
              const ARoundedImage(
                padding: 0,
                backgroundColor: AColors.primaryBackground,
                image: AImages.user,
                imageType: ImageType.asset,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Nihal',
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                    const Text('support@aurakart.com',
                        overflow: TextOverflow.ellipsis, maxLines: 1),
                  ],
                ),
              ),
            ],
          ),
          //Meta Data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('UserName')),
              const Text(':'),
              const SizedBox(width: ASizes.spaceBtwItems / 2),
              Expanded(
                  child: Text('nihal',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Country')),
              const Text(':'),
              const SizedBox(width: ASizes.spaceBtwItems / 2),
              Expanded(
                  child: Text('Karinchappadi',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number')),
              const Text(':'),
              const SizedBox(width: ASizes.spaceBtwItems / 2),
              Expanded(
                  child: Text('7327293893',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('UserName')),
              const Text(':'),
              const SizedBox(width: ASizes.spaceBtwItems / 2),
              Expanded(
                  child: Text('Karinchappadi',
                      style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          //Divider
          const Divider(),
          const SizedBox(height: ASizes.spaceBtwItems),
          //Additional details
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Last Order',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('7 Days ago #[64d82]'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Average Order Value',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('\$465'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          //Additional details continuation
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Registerd',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('17/5/2020 at 12:35'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email Marketing',
                        style: Theme.of(context).textTheme.titleLarge),
                    const Text('Subscribed'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
