import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';

class CreateBannerForm extends StatelessWidget {
  const CreateBannerForm({super.key});

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
            Text('Create New Banner',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwSections),

            // Image Uploader & Featured Checkbox
            Column(
              children: [
                GestureDetector(
                  child: const ARoundedImage(
                    width: 400,
                    height: 200,
                    backgroundColor: AColors.primaryBackground,
                    image: AImages.defaultImage,
                    imageType: ImageType.asset,
                  ),
                ),
                const SizedBox(height: ASizes.spaceBtwItems),
                TextButton(onPressed: () {}, child: Text('Select Image')),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            Text('Make your Banner Active or InActive',
                style: Theme.of(context).textTheme.bodyMedium),
            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Active'),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Dropdown Menu Screens
            DropdownButton<String>(
              value: 'search',
              onChanged: (String? newValue) {},
              items: const [
                DropdownMenuItem<String>(value: 'home', child: Text('Home')),
                DropdownMenuItem<String>(
                    value: 'search', child: Text('Search')),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text('Create')),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
