import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final brandController = Get.put(BrandController());

    // Fetch alll brands if empty
    if (brandController.allItems.isEmpty) {
      brandController.fetchItems();
    }

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand label
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Type Ahead Field for brand Selection
          Obx(
            () => brandController.isLoading.value
                ? const AShimmerEffect(width: double.infinity, height: 50)
                : TypeAheadField(
                    builder: (context, ctr, focusNode) {
                      return TextFormField(
                        focusNode: focusNode,
                        controller: controller.brandTextField = ctr,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select Brand',
                          suffixIcon: Icon(Iconsax.box),
                        ),
                      );
                    },
                    onSelected: (suggestion) {
                      controller.selectedBrand.value = suggestion;
                      controller.brandTextField.text = suggestion.name;
                    },
                    suggestionsCallback: (pattern) {
                      // Return filtered brand suggestions based on the search pattern
                      return brandController.allItems
                          .where((brand) => brand.name.contains(pattern))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) =>
                        ListTile(title: Text(suggestion.name)),
                  ),
          ),
        ],
      ),
    );
  }
}
