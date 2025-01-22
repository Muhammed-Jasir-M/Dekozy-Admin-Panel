import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model%20copy.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTransaction extends StatelessWidget {
  const OrderTransaction({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      padding: EdgeInsets.all(ASizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transactions',
              style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(
            height: ASizes.spaceBtwSections,
          ),

          // Adjust as per your needs
          Row(
            children: [
              Expanded(
                flex: ADeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                    ARoundedImage(
                      imageType: ImageType.asset,
                      image: AImages.paypal,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Payment via ${order.paymentMethod.capitalize}',
                              style: Theme.of(context).textTheme.titleLarge),
                          //Adjust your Payment Method Fee if any
                          Text('${order.paymentMethod.capitalize} fee \$25',
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date', style: Theme.of(context).textTheme.labelMedium),
                  Text('April 21, 2025', style: Theme.of(context).textTheme.bodyLarge),
                ],
              )),
              Expanded(child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total', style: Theme.of(context).textTheme.labelMedium),
                  Text('\$${order.totalAmount}', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
