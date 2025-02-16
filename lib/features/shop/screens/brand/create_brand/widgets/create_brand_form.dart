import 'package:aura_kart_admin_panel/common/widgets/chips/rounded_choice_chips.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/brand/create_brand_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class CreateBrandForm extends StatelessWidget {
  const CreateBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateBrandController());

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
            Text('Create New Brand',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwSections),

            // Name Text Field
            TextFormField(
              controller: controller.name,
              validator: (value) => AValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                prefixIcon: Icon(Iconsax.box),
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
                      (category) => Padding(
                        padding: const EdgeInsets.only(bottom: ASizes.sm),
                        child: AChoiceChip(
                          text: category.name,
                          selected:
                              controller.selectedCategories.contains(category),
                          onSelected: (value) =>
                              controller.toggleSelection(category),
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
                image: controller.imageURL.value.isNotEmpty
                    ? controller.imageURL.value
                    : AImages.defaultImage,
                imageType: controller.imageURL.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
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

            // Create Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.createBrand(),
                child: Text('Create'),
              ),
            ),
            SizedBox(height: ASizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
