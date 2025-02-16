import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: AColors.primaryBackground),
        const SizedBox(height: ASizes.spaceBtwSections),

        Text('Add Product Attributes',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: ASizes.spaceBtwItems),

        // Form to add new attribute
        Form(
          child: ADeviceUtils.isDesktopScreen(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildAttributeName()),
                    const SizedBox(width: ASizes.spaceBtwItems),
                    Expanded(flex: 2, child: _buildAttributeTextField()),
                    const SizedBox(width: ASizes.spaceBtwItems),
                    _buildAddAttributeButton(),
                  ],
                )
              : Column(
                  children: [
                    _buildAttributeName(),
                    const SizedBox(height: ASizes.spaceBtwItems),
                    _buildAttributeTextField(),
                    const SizedBox(height: ASizes.spaceBtwItems),
                    _buildAddAttributeButton(),
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
          child: Column(
            children: [
              buildAttributesList(context),
              buildEmptyAttributes(),
            ],
          ),
        ),
        const SizedBox(height: ASizes.spaceBtwSections),

        // Generate Variations Button
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Iconsax.activity),
              label: const Text('Generate Variations'),
            ),
          ),
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
  SizedBox _buildAddAttributeButton() {
    return SizedBox(
      width: 100,
      child: ElevatedButton.icon(
        onPressed: () {},
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

  ListView buildAttributesList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: ASizes.spaceBtwItems),
      itemBuilder: (_, index) => Container(
        decoration: BoxDecoration(
          color: AColors.white,
          borderRadius: BorderRadius.circular(ASizes.borderRadiusLg),
        ),
        child: ListTile(
          title: const Text('Color'),
          subtitle: const Text('Green, Orange, Pink'),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.trash, color: AColors.error),
          ),
        ),
      ),
    );
  }

  // Build text form fiels for attribute name
  TextFormField _buildAttributeName() {
    return TextFormField(
      validator: (value) =>
          AValidator.validateEmptyText('Attribute Name', value),
      decoration: const InputDecoration(
          labelText: 'Attribute Name', hintText: 'Colors, Sizes, Material'),
    );
  }

  // Build text form field for attribute values
  SizedBox _buildAttributeTextField() {
    return SizedBox(
      height: 80,
      child: TextFormField(
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
