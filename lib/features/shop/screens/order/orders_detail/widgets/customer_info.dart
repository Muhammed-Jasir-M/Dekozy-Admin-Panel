import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        ARoundedContainer(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer',
                  style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(
                height: ASizes.spaceBtwSections,
              ),
              Row(
                children: [
                  ARoundedImage(
                    padding: 0,
                    backgroundColor: AColors.primaryBackground,
                    image: AImages.user,
                    imageType: ImageType.asset,
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aurakart',
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          'support@aurakart.com',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: ASizes.spaceBtwSections),

        // Contact Info
        SizedBox(
          width: double.infinity,
          child: ARoundedContainer(
            padding: EdgeInsets.all(ASizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Person',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: ASizes.spaceBtwSections),
                Text(
                  'Aurakart',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                Text(
                  'support@aurakart.com',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                Text(
                  '(+91) 9587435987',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwSections),

        // Shipping Info
        SizedBox(
          width: double.infinity,
          child: ARoundedContainer(
            padding: EdgeInsets.all(ASizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: ASizes.spaceBtwSections),
                Text(
                  'Aura kart LTD',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                Text(
                  '61 Bridge Street, Kington, United Kingdom',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwSections),

        // Billing Info
        SizedBox(
          width: double.infinity,
          child: ARoundedContainer(
            padding: EdgeInsets.all(ASizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: ASizes.spaceBtwSections),
                Text(
                  'Aura kart LTD',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                Text(
                  '61 Bridge Street, Kington, United Kingdom',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwSections),
      ],
    );
  }
}
