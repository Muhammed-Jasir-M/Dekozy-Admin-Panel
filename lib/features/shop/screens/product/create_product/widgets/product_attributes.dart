import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/create_product_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_attributes_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_variations_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = CreateProductController.instance;
    final attributeController = Get.put(ProductAttributesController());
    final variationController = Get.put(ProductVariationController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Divider based on Product Type
        Obx(() {
          return productController.productType.value == ProductType.single
              ? Column(
                  children: [
                    const Divider(color: AColors.primaryBackground),
                    const SizedBox(height: ASizes.spaceBtwSections),
                  ],
                )
              : const SizedBox.shrink();
        }),

        Text('Add Product Attributes',
            style: Theme.of(context).textTheme.headlineSmall),

        const SizedBox(height: ASizes.spaceBtwItems),

        // Form to add new attribute
        Form(
          key: attributeController.attributesFormKey,
          child: ADeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildAttributeName(attributeController)),
                    const SizedBox(width: ASizes.spaceBtwItems),
                    Expanded(
                      flex: 2,
                      child: _buildAttributeTextField(attributeController),
                    ),
                    const SizedBox(width: ASizes.spaceBtwItems),
                    _buildAddAttributeButton(attributeController),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(attributeController),
                    const SizedBox(height: ASizes.spaceBtwItems),
                    _buildAttributeTextField(attributeController),
                    const SizedBox(height: ASizes.spaceBtwItems),
                    _buildAddAttributeButton(attributeController),
                  ],
                ),
        ),
        const SizedBox(height: ASizes.spaceBtwSections),

        // List of added Attributes
        Text('All Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: ASizes.spaceBtwItems),

        // Display added attributes in a rounded container
        ARoundedContainer(
          backgroundColor: AColors.primaryBackground,
          child: Obx(
            () => attributeController.productAttributes.isNotEmpty
                ? buildAttributesList(context, attributeController)
                : buildEmptyAttributes(),
          ),
        ),

        const SizedBox(height: ASizes.spaceBtwSections),

        // Generate Variations Button
        Obx(
          () => productController.productType.value == ProductType.variable &&
                  variationController.productVariations.isEmpty
              ? Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      onPressed: () => variationController
                          .generateVariationsConfirmation(context),
                      icon: const Icon(Iconsax.activity),
                      label: const Text('Generate Variations'),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Column buildEmptyAttributes() {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ARoundedImage(
              imageType: ImageType.asset,
              width: 150,
              height: 80,
              image: AImages.defaultAttributeColorsImageIcon,
            ),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        Text('There are no attributes added for this product'),
      ],
    );
  }

  // Build button to add a new attribute
  SizedBox _buildAddAttributeButton(ProductAttributesController controller) {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () => controller.addNewAttribute(),
        icon: const Icon(Iconsax.add),
        style: ElevatedButton.styleFrom(
          foregroundColor: AColors.black,
          backgroundColor: AColors.secondary,
          side: const BorderSide(color: AColors.secondary),
        ),
        label: const Text('Add'),
      ),
    );
  }

  ListView buildAttributesList(
    BuildContext context,
    ProductAttributesController controller,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: controller.productAttributes.length,
      separatorBuilder: (_, __) => const SizedBox(height: ASizes.spaceBtwItems),
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            color: AColors.white,
            borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
          ),
          child: ListTile(
            title: Text(
              controller.productAttributes[index].name ?? '',
            ),
            subtitle: Text(
              controller.productAttributes[index].values!
                  .map((e) => e.trim())
                  .toString(),
            ),
            trailing: IconButton(
              onPressed: () => controller.removeAttribute(index, context),
              icon: const Icon(Iconsax.trash, color: AColors.error),
            ),
          ),
        );
      },
    );
  }

  // Build text form fiels for attribute name
  TextFormField _buildAttributeName(ProductAttributesController controller) {
    return TextFormField(
      controller: controller.attributeName,
      validator: (value) =>
          AValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
        labelText: 'Attribute Name',
        hintText: 'Colors, Sizes, Material',
      ),
    );
  }

  // Build text form field for attribute values
  SizedBox _buildAttributeTextField(ProductAttributesController controller) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller.attributes,
        expands: true,
        maxLength: null,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.multiline,
        textAlignVertical: TextAlignVertical.top,
        validator: (value) =>
            AValidator.validateEmptyText('Attribute Field', value),
        decoration: const InputDecoration(
          labelText: 'Attributes',
          hintText:
              'Add attributes separated by | Example: Green | Blue | Yellow',
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
