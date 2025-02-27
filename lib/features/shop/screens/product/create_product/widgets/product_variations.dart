import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_image_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/product_variation_model.dart';
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
    final variationController = ProductVariationController.instance;

    return Obx(
      () => CreateProductController.instance.productType.value ==
              ProductType.variable
          ? ARoundedContainer(
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
                        onPressed: () =>
                            variationController.removeVariations(context),
                        child: const Text('Remove Variations'),
                      ),
                    ],
                  ),
                  const SizedBox(height: ASizes.spaceBtwItems),

                  // Variations List
                  if (variationController.productVariations.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: variationController.productVariations.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: ASizes.spaceBtwItems),
                      itemBuilder: (_, index) {
                        final variation =
                            variationController.productVariations[index];

                        return _buildVariationTile(
                          context,
                          index,
                          variation,
                          variationController,
                        );
                      },
                    )
                  else
                    // No variation Message
                    _buildNoVaraiationsMessage(),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // Helper method to build a variation tile
  Widget _buildVariationTile(
    BuildContext contextBuildContext,
    int index,
    ProductVariationModel variation,
    ProductVariationController controller,
  ) {
    return ExpansionTile(
      backgroundColor: AColors.lightGrey,
      collapsedBackgroundColor: AColors.lightGrey,
      childrenPadding: const EdgeInsets.all(ASizes.md),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
      ),
      title: Text(
        variation.attributeValues.entries
            .map((e) => '${e.key} : ${e.value}')
            .join(', '),
      ),
      children: [
        // Upload Variation Image
        Obx(
          () => AImageUploader(
            right: 0,
            left: null,
            imageType: variation.image.value.isNotEmpty
                ? ImageType.network
                : ImageType.asset,
            image: variation.image.value.isNotEmpty
                ? variation.image.value
                : AImages.defaultImage,
            onIconButtonPressed: () =>
                ProductImagesController.instance.selectVariationImage(variation),
          ),
        ),
        const SizedBox(height: ASizes.spaceBtwInputFields),

        // Variation Stock & Pricing
        Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => variation.stock = int.parse(value),
                controller: controller.stockControllersList[index][variation],
                keyboardType: TextInputType.number,
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
                onChanged: (value) => variation.price = double.parse(value),
                controller: controller.priceControllersList[index][variation],
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
                onChanged: (value) => variation.salePrice = double.parse(value),
                controller: controller.salePriceControllersList[index]
                    [variation],
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
          onChanged: (value) => variation.description = value,
          controller: controller.descriptionControllersList[index][variation],
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
