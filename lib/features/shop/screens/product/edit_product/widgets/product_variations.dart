import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/sizes.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Variations Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product Variations',
                  style: Theme.of(context).textTheme.headlineSmall),
              TextButton(
                  onPressed: () {}, child: const Text('Remove Variations')),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Variations List
          ListView.separated(
            shrinkWrap: true,
            itemCount: 2,
            itemBuilder: (_, index) => _buildVariationTile(),
            separatorBuilder: (_, __) =>
                const SizedBox(height: ASizes.spaceBtwItems),
          ),

          // No variation Message
          _buildNoVaraiationsMessage(),
        ],
      ),
    );
  }

  // Helper method to build a variation tile
  Widget _buildVariationTile() {
    return ExpansionTile(
      backgroundColor: AColors.lightGrey,
      collapsedBackgroundColor: AColors.lightGrey,
      childrenPadding: const EdgeInsets.all(ASizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ASizes.borderRadiusLg)),
      title: const Text('Color: Green, Size: Small'),
      children: [
        // Upload Variation Image
        Obx(
          () => AImageUploader(
            right: 0,
            left: null,
            imageType: ImageType.asset,
            image: AImages.defaultImage,
            onIconButtonPressed: () {},
          ),
        ),
        const SizedBox(height: ASizes.spaceBtwInputFields),

        // Variation Stock, Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  labelText: 'Stock',
                  hintText: 'Add Stock, only numbers are allowed',
                ),
              ),
            ),
            const SizedBox(width: ASizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
                ],
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
            const SizedBox(width: ASizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'))
                ],
                decoration: const InputDecoration(
                  labelText: 'Discounted Price',
                  hintText: 'Price with up-to 2 decimals',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: ASizes.spaceBtwInputFields),

        // Variation Description
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: 'Add description of this variation...',
          ),
        ),

        const SizedBox(height: ASizes.spaceBtwSections),
      ],
    );
  }

  // Helper method to build message when there are no variations
  Widget _buildNoVaraiationsMessage() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ARoundedImage(
              width: 200,
              height: 200,
              imageType: ImageType.asset,
              image: AImages.defaultVariationImageIcon,
            ),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        Text('There are no Variations added for this product')
      ],
    );
  }
}
