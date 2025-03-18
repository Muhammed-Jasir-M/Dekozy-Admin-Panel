import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/features/personalisation/controllers/user_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return ARoundedContainer(
      padding: const EdgeInsets.symmetric(
          vertical: ASizes.lg, horizontal: ASizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // User image
              Obx(
                () => AImageUploader(
                  right: 10,
                  bottom: 20,
                  left: null,
                  width: 200,
                  height: 200,
                  circular: true,
                  loading: controller.loading.value,
                  onIconButtonPressed: () => controller.updateProfilePicture(),
                  icon: CupertinoIcons.camera,
                  imageType: controller.user.value.profilePicture.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : AImages.user,
                ),
              ),
              const SizedBox(height: ASizes.spaceBtwItems),
              Obx(
                () => Text(controller.user.value.fullName,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
              Obx(() => Text(controller.user.value.email)),
              const SizedBox(height: ASizes.spaceBtwSections),
            ],
          )
        ],
      ),
    );
  }
}
