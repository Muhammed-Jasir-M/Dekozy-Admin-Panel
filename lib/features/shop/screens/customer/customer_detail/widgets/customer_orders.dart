import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/table/data_table.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});
  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      padding: const EdgeInsets.all(ASizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Orders', style: Theme.of(context).textTheme.headlineMedium),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Total Spent'),
                    TextSpan(
                        text: '\$484',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: AColors.primary)),
                    TextSpan(
                        text: 'on  ${5}Orders',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          TextFormField(
            onChanged: (query) {},
            decoration: const InputDecoration(
                hintText: 'Search Orders',
                prefixIcon: Icon(Iconsax.search_normal)),
          ),
          const SizedBox(height: ASizes.spaceBtwSections),
          const CustomerOrderTable(),
        ],
      ),
    );
  }
}
