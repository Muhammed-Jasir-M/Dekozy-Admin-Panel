import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/create_category_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CreateCategoryForm extends StatelessWidget {
  const CreateCategoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createController = Get.put(CreateCategoryController());
    final categoryController = Get.put(CategoryController());

    return ARoundedContainer(
      width: 500,
      padding: EdgeInsets.all(ASizes.defaultSpace),
      child: Form(
        key: createController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            const SizedBox(height: ASizes.sm),
            Text('Create New Catogory',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Name Text Field
            TextFormField(
              controller: createController.name,
              validator: (value) => AValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                labelText: 'Category Name',
                prefixIcon: Icon(Iconsax.category),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Category Dropdown
            Obx(
              () => categoryController.isLoading.value
                  ? AShimmerEffect(width: double.infinity, height: 55)
                  : DropdownButtonFormField(
                      decoration: const InputDecoration(
                        hintText: 'Parent Category',
                        labelText: 'Parent Category',
                        prefixIcon: Icon(Iconsax.bezier),
                      ),
                      onChanged: (newValue) =>
                          createController.selectedParent.value = newValue!,
                      items: categoryController.allItems
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(item.name),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),

            const SizedBox(height: ASizes.spaceBtwInputFields * 2),

            // Image
            Obx(
              () => AImageUploader(
                width: 80,
                height: 80,
                image: createController.imageURL.value.isNotEmpty
                    ? createController.imageURL.value
                    : AImages.defaultImage,
                imageType: createController.imageURL.value.isNotEmpty
                    ? ImageType.network
                    : ImageType.asset,
                onIconButtonPressed: () => createController.pickImage(),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Featured checkbox
            Obx(
              () => CheckboxMenuButton(
                value: createController.isFeatured.value,
                onChanged: (value) =>
                    createController.isFeatured.value = value ?? false,
                child: const Text('Featured'),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),

            // Create Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => createController.createcategory(),
                child: const Text('Create'),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
