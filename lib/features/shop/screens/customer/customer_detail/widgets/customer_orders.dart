import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/table/data_table.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    controller.getCustomerOrders();

    return Obx(
      () {
        if (controller.ordersLoading.value) return const ALoaderAnimation();

        if (controller.allCustomerOrders.isEmpty) {
          return AAnimationLoaderWidget(
            text: 'No Orders Found',
            animation: AImages.pencilAnimation,
          );
        }

        final totalAmount = controller.allCustomerOrders
            .fold(0.0, (prevValue, element) => prevValue + element.totalAmount);

        return ARoundedContainer(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Orders',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(text: 'Total Spent'),
                        TextSpan(
                          text: '\u{20B9}${totalAmount.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: AColors.primary),
                        ),
                        TextSpan(
                          text:
                              ' on  ${controller.allCustomerOrders.length} Orders',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwItems),
              TextFormField(
                onChanged: (query) => controller.searchQuery(query),
                decoration: const InputDecoration(
                  hintText: 'Search Orders',
                  prefixIcon: Icon(Iconsax.search_normal),
                ),
                controller: controller.searchTextController,
              ),
              const SizedBox(height: ASizes.spaceBtwSections),
              const CustomerOrderTable(),
            ],
          ),
        );
      },
    );
  }
}
