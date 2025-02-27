import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/product_model.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final productController = EditProductController.instance;

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          FutureBuilder(
            future: productController.loadSelectedCategories(product.id),
            builder: (context, snapshot) {
              final widget = ACloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot);

              if (widget != null) return widget;

              return MultiSelectDialogField(
                buttonText: const Text('Select Categories'),
                title: const Text('Categories'),
                initialValue: List<CategoryModel>.from(
                    productController.selectedCategories),
                items: CategoryController.instance.allItems
                    .map((category) => MultiSelectItem(category, category.name))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                onConfirm: (values) {
                  productController.selectedCategories.assignAll(values);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
