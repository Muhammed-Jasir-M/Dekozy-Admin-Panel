import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility Header
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Radio buttons for Product Visibility
          Column(
            children: [
              _buildVisibilityRadioButton(
                  ProductVisibility.published, 'Published'),
              _buildVisibilityRadioButton(ProductVisibility.hidden, 'Hidden'),
            ],
          )
        ],
      ),
    );
  }

  // Helper method to build a radio button for product visibility
  Widget _buildVisibilityRadioButton(ProductVisibility value, String label) {
    return RadioMenuButton(
      value: value,
      groupValue: ProductVisibility.published,
      onChanged: (selecction) {},
      child: Text(label),
    );
  }
}
