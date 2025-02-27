import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility Header
          Text('Visibility', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Radio buttons for Product Visibility
          Obx(
            () => Column(
              children: [
                _buildVisibilityRadioButton(
                    ProductVisibility.published, 'Published', controller),
                _buildVisibilityRadioButton(
                    ProductVisibility.hidden, 'Hidden', controller),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper method to build a radio button for product visibility
  Widget _buildVisibilityRadioButton(ProductVisibility value, String label,
      CreateProductController controller) {
    return RadioMenuButton(
      value: value,
      groupValue: controller.productVisibility.value,
      onChanged: (value) {
        // Update the selected product visibility in the controller
        controller.productVisibility.value =
            value ?? ProductVisibility.published;
      },
      child: Text(label),
    );
  }
}
