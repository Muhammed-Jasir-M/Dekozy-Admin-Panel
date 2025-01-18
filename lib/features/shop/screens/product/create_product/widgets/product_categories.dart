import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories label
          Text('Categories', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // MultiSelectDialogField for selecting categories
          MultiSelectDialogField(
            buttonText: const Text('Select Categories'),
            title: const Text('Categories'),
            items: [
              MultiSelectItem(
                CategoryModel(id: 'id', name: 'Shoes', image: 'image'),
                'Shoes',
              ),
              MultiSelectItem(
                CategoryModel(id: 'id', name: 'Shirts', image: 'image'),
                'Shirts',
              )
            ],
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {},
          ),
        ],
      ),
    );
  }
}
