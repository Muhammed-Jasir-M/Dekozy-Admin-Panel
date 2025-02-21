import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/banner/edit_banner_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/models/banner_model.dart';
import 'package:aura_kart_admin_panel/routes/app_screens.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../utils/constants/colors.dart';

class EditBannerForm extends StatelessWidget {
  const EditBannerForm({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditBannerController());
    controller.init(banner);

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
            Text('Update Banner',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: ASizes.spaceBtwSections),

            // Image Uploader & Featured Checkbox
            Column(
              children: [
                Obx(
                  () => ARoundedImage(
                    width: 400,
                    height: 200,
                    backgroundColor: AColors.primaryBackground,
                    image: controller.imageURL.value.isNotEmpty
                        ? controller.imageURL.value
                        : AImages.defaultImage,
                    imageType: controller.imageURL.value.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                  ),
                ),
                const SizedBox(height: ASizes.spaceBtwItems),
                TextButton(
                  onPressed: () => controller.pickImage(),
                  child: Text('Select Image'),
                ),
              ],
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            Text('Make your Banner Active or InActive',
                style: Theme.of(context).textTheme.bodyMedium),
            Obx(
              () => CheckboxMenuButton(
                value: controller.isActive.value,
                onChanged: (value) =>
                    controller.isActive.value = value ?? false,
                child: const Text('Active'),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields),

            // Dropdown Menu Screens
            Obx(
              () {
                return DropdownButton<String>(
                  value: controller.targetScreen.value,
                  onChanged: (String? newValue) =>
                      controller.targetScreen.value = newValue!,
                  items: AppScreens.allAppScreenItems
                      .map<DropdownMenuItem<String>>(
                    (value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                );
              },
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateBanner(banner),
                child: Text('Update'),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
