import 'package:aura_kart_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/brand/edit_brand_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/brand_model.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class EditBrandForm extends StatelessWidget {
  const EditBrandForm({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBrandController());
    controller.init(brand);

    return ARoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(ASizes.defaultSpace),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: ASizes.sm),
            Text('Update Brand',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              controller: controller.name,
              validator: (value) => AValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Categories
            Text('Select Categories',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: ASizes.spaceBtwInputFields / 2),
            Obx(
              () => Wrap(
                spacing: ASizes.sm,
                children: CategoryController.instance.allItems
                    .map(
                      (element) => Padding(
                        padding: const EdgeInsets.only(bottom: ASizes.sm),
                        child: AChoiceChip(
                          text: element.name,
                          selected:
                              controller.selectedCategories.contains(element),
                          onSelected: (value) =>
                              controller.toggleSelection(element),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),

            // Image Uploader
            Obx(
              () => AImageUploader(
                width: 80,
                height: 80,
                image: AImages.defaultImage,
                imageType: ImageType.asset,
                onIconButtonPressed: () => controller.pickImage(),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Checkbox
            Obx(
              () => CheckboxMenuButton(
                value: controller.isFeatured.value,
                onChanged: (value) =>
                    controller.isFeatured.value = value ?? false,
                child: const Text('Featured'),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),

            // Update Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateBrand(brand),
                child: const Text('Update'),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
