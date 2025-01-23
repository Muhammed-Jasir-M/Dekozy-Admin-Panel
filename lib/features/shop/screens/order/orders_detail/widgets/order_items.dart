import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:aura_kart_admin_panel/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items?.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price * element.quantity));
    return ARoundedContainer(
      padding: const EdgeInsets.all(ASizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: ASizes.spaceBtwSections),

// Items

          ListView.separated(
            shrinkWrap: true,
            itemCount: order.items!.length,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (_, __) =>
                const SizedBox(height: ASizes.spaceBtwItems),
            itemBuilder: (_, index) {
              final item = order.items?[index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ARoundedImage(
                          backgroundColor: AColors.primaryBackground,
                          imageType: item?.image != null
                              ? ImageType.network
                              : ImageType.asset,
                          image: item?.image ?? AImages.defaultImage,
                        ),
                        SizedBox(width: ASizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item!.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (item.selectedVariation != null)
                                Text(item.selectedVariation!.entries
                                    .map((e) => ('${e.key}: ${e.value}'))
                                    .toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: ASizes.spaceBtwItems),
                  SizedBox(
                      width: ASizes.xl * 2,
                      child: Text('\$${item.price.toStringAsFixed(1)}',
                          style: Theme.of(context).textTheme.bodyLarge)),
                  SizedBox(
                    width: ADeviceUtils.isMobileScreen(context)
                        ? ASizes.xl * 1.4
                        : ASizes.xl * 2,
                    child: Text(item.quantity.toString(),
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  SizedBox(
                    width: ADeviceUtils.isMobileScreen(context)
                        ? ASizes.xl * 1.4
                        : ASizes.xl * 2,
                    child: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: ASizes.spaceBtwSections),

// Items Total

          ARoundedContainer(
            padding: const EdgeInsets.all(ASizes.defaultSpace),
            backgroundColor: AColors.primaryBackground,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('\$$subTotal',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                SizedBox(height: ASizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('\$0.00',
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                SizedBox(height: ASizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Shipping',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${APricingCalculator.calculateShippingCost(subTotal!, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: ASizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${APricingCalculator.calculateTax(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: ASizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: ASizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${APricingCalculator.calculateTotalPrice(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
