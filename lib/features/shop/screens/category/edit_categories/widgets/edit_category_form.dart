import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      width: 500,
      padding: EdgeInsets.all(ASizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            const SizedBox(height: ASizes.sm),
            Text('Update Catogory',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
            //Name Text Field
            TextFormField(
              validator: (value) => AValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                  labelText: 'Category Name',
                  prefixIcon: Icon(Iconsax.category)),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  hintText: 'Parent Category',
                  labelText: 'Parent Category',
                  prefixIcon: Icon(Iconsax.bezier)),
              onChanged: (newValue) {},
              items: [
                DropdownMenuItem(
                  value: '',
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [Text('item.name')]),
                )
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
            AImageUploader(
              width: 80,
              height: 80,
              image: AImages.defaultImage,
              imageType: ImageType.asset,
              onIconButtonPressed: () {},
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
            CheckboxMenuButton(
              value: true,
              onChanged: (value) {},
              child: const Text('Featured'),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Create')),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
