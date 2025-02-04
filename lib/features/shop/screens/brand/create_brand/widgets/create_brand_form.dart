import 'package:aura_kart_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(ASizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: ASizes.sm),
            Text('Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
              ),
            ),

            // Categories
            Text('Select Categories',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: ASizes.spaceBtwInputFields / 2),

            Wrap(
              spacing: ASizes.sm,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: ASizes.sm),
                  child: AChoiceChip(
                      text: 'Shoes', selected: true, onSelected: (value) {}),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: ASizes.sm),
                  child: AChoiceChip(
                      text: 'Track Suits',
                      selected: true,
                      onSelected: (value) {}),
                ),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),

            // Image Uploader & Featured Checkbox
            AImageUploader(
              width: 80,
              height: 80,
              image: AImages.defaultImage,
              imageType: ImageType.asset,
              onIconButtonPressed: () {},
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Checkbox
            CheckboxMenuButton(
                value: true,
                onChanged: (value) {},
                child: const Text('Featured')),
            SizedBox(height: ASizes.spaceBtwInputFields * 2),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text('Create')),
            ),
            SizedBox(height: ASizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
