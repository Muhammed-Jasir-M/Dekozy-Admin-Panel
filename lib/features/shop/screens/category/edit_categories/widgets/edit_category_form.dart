import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/category_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/category/edit_category_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditCategoryForm extends StatelessWidget {
  const EditCategoryForm({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final editController = Get.put(EditCategoryController());
    editController.init(category);
    final categoryController =Get.put(CategoryController());
    return ARoundedContainer(
      width: 500,
      padding: EdgeInsets.all(ASizes.defaultSpace),
      child: Form(
       key: editController.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Heading
            const SizedBox(height: ASizes.sm),
            Text('Update Catogory',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwSections),
            //Name Text Field
            TextFormField(
              controller: editController.name,
              validator: (value) => AValidator.validateEmptyText('Name', value),
              decoration: const InputDecoration(
                  labelText: 'Category Name',
                  prefixIcon: Icon(Iconsax.category)),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),
            Obx(
            ()=>
             DropdownButtonFormField<CategoryModel>(
                decoration: const InputDecoration(
                    hintText: 'Parent Category',
                    labelText: 'Parent Category',
                    prefixIcon: Icon(Iconsax.bezier)),
                    value: editController.selectedParent.value.id.isNotEmpty?editController.selectedParent.value:null,
                onChanged: (newValue)=> editController.selectedParent.value=newValue!,
                items: categoryController.allItems
                .map((item)=>
                  DropdownMenuItem(
                    value: item,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [Text(item.name)]),
                  )
                ) .toList()
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
            Obx(
             ()=> AImageUploader(
                width: 80,
                height: 80,
                image: editController.imageURL.value.isNotEmpty?editController.imageURL.value:AImages.defaultImage,
                imageType:  editController.imageURL.value.isNotEmpty? ImageType.network:ImageType.asset,
                onIconButtonPressed: () => editController.pickImage(),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),
            CheckboxMenuButton(
              value:editController.isFeatured.value,
              onChanged: (value) => editController.isFeatured.value=value??false,
              child: const Text('Featured'),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
            SizedBox(
                width: double.infinity,
                child:
                    ElevatedButton(onPressed: () =>editController.updateCategory(category), child: const Text('Update')),
              ),
   
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
