import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    // Fetch categories if not already fetched
    if (controller.allItems.isEmpty) {
      controller.fetchItems();
    }

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          Obx(
            () => controller.isLoading.value
                ? const AShimmerEffect(width: double.infinity, height: 50)
                : MultiSelectDialogField(
                    buttonText: const Text('Select Categories'),
                    title: const Text('Categories'),
                    items: controller.allItems
                        .map((category) =>
                            MultiSelectItem(category, category.name))
                        .toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) => CreateProductController
                        .instance.selectedCategories
                        .assignAll(values),
                  ),
          ),
        ],
      ),
    );
  }
}
