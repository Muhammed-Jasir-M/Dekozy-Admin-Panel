import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductTitleAndDescription extends StatelessWidget {
  const ProductTitleAndDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;

    return ARoundedContainer(
      child: Form(
        key: controller.titleDescriptionFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Information Text
            Text('Basic Information',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwItems),

            // Product Title Input Field
            TextFormField(
              controller: controller.title,
              validator: (value) =>
                  AValidator.validateEmptyText('Product Title', value),
              decoration: const InputDecoration(labelText: 'Product Title'),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Product Description Input Field
            SizedBox(
              height: 300,
              child: TextFormField(
                controller: controller.description,
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) =>
                    AValidator.validateEmptyText('Product Description', value),
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  hintText: 'Add your Product Description here...',
                  alignLabelWithHint: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
