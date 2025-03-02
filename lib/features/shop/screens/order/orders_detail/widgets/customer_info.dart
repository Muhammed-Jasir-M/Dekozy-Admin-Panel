import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/order/order_detail_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        ARoundedContainer(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: ASizes.spaceBtwSections),
              Obx(
                () {
                  return Row(
                    children: [
                      ARoundedImage(
                        padding: 0,
                        backgroundColor: AColors.primaryBackground,
                        image:
                            controller.customer.value.profilePicture.isNotEmpty
                                ? controller.customer.value.profilePicture
                                : AImages.user,
                        imageType:
                            controller.customer.value.profilePicture.isNotEmpty
                                ? ImageType.network
                                : ImageType.asset,
                      ),
                      const SizedBox(width: ASizes.spaceBtwItems),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.customer.value.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              controller.customer.value.email,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: ASizes.spaceBtwSections),

        // Contact Info
        Obx(
          () => SizedBox(
            width: double.infinity,
            child: ARoundedContainer(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Person',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: ASizes.spaceBtwSections),
                  Text(
                    controller.customer.value.fullName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems / 2),
                  Text(
                    controller.customer.value.email,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems / 2),
                  Text(
                    controller.customer.value.formattedPhoneNo.isNotEmpty
                        ? controller.customer.value.formattedPhoneNo
                        : '(+91) ***** *****',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: ASizes.spaceBtwSections),

        // Shipping Info
        SizedBox(
          width: double.infinity,
          child: ARoundedContainer(
            padding: const EdgeInsets.all(ASizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: ASizes.spaceBtwSections),
                Text(
                  order.shippingAddress != null
                      ? order.shippingAddress!.name
                      : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: ASizes.spaceBtwItems / 2),
                Text(
                  order.shippingAddress != null
                      ? order.shippingAddress!.toString()
                      : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: ASizes.spaceBtwSections),

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
                  order.billingAddressSameAsShipping
                      ? order.shippingAddress!.name
                      : order.billingAddress!.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: ASizes.spaceBtwItems / 2),
                Text(
                  order.billingAddressSameAsShipping
                      ? order.shippingAddress!.toString()
                      : order.billingAddress!.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: ASizes.spaceBtwSections),
      ],
    );
  }
}
