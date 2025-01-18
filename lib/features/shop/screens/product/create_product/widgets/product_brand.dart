import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/models/brand_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand label
          Text('Brand', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Type Ahead Field for brand Selection
          TypeAheadField(
            builder: (context, ctr, focusNode) {
              return TextFormField(
                focusNode: focusNode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Select Brand',
                  suffixIcon: Icon(Iconsax.box),
                ),
              );
            },
            onSelected: (suggestion) {},
            suggestionsCallback: (pattern) {
              // Return filtered brand suggestions based on the search pattern
              return [
                BrandModel(id: 'id', image: AImages.applePay, name: 'Adidas'),
                BrandModel(id: 'id', image: AImages.applePay, name: 'Nike'),
              ];
            },
            itemBuilder: (context, suggestion) =>
                ListTile(title: Text(suggestion.name)),
          ),
        ],
      ),
    );
  }
}
