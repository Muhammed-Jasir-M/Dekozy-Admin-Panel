import 'package:flutter/material.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Product Type', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: ASizes.spaceBtwItems),

        // Radio button for Single Product Type
        RadioMenuButton(
          value: ProductType.single,
          groupValue: ProductType.single,
          onChanged: (value) {},
          child: const Text('Single'),
        ),

        // Radio button for Variable Product Type
        RadioMenuButton(
          value: ProductType.variable,
          groupValue: ProductType.single,
          onChanged: (value) {},
          child: const Text('Variable'),
        ),
      ],
    );
  }
}
