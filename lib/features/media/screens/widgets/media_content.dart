import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/screens/widgets/folder_dropdown.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // media images header
          Row(
            children: [
              Text('Select Folder',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(width: ASizes.spaceBtwItems),
              MediaFolderDropdown(onChanged: (MediaCategory? newValue) {
                if (newValue != null) {
                  controller.selectedPath.value = newValue;
                }
              }),
            ],
          ),

          SizedBox(height: ASizes.spaceBtwSections),

          // show media

          const Wrap(
            alignment: WrapAlignment.start,
            spacing: ASizes.spaceBtwItems / 2,
            runSpacing: ASizes.spaceBtwItems / 2,
            children: [
              ARoundedImage(
                width: 90,
                height: 90,
                padding: ASizes.sm,
                imageType: ImageType.asset,
                image: AImages.darkAppLogo,
                backgroundColor: AColors.primaryBackground,
              ),
              ARoundedImage(
                width: 90,
                height: 90,
                padding: ASizes.sm,
                imageType: ImageType.asset,
                image: AImages.darkAppLogo,
                backgroundColor: AColors.primaryBackground,
              ),
              ARoundedImage(
                width: 90,
                height: 90,
                padding: ASizes.sm,
                imageType: ImageType.asset,
                image: AImages.darkAppLogo,
                backgroundColor: AColors.primaryBackground,
              ),
              ARoundedImage(
                width: 90,
                height: 90,
                padding: ASizes.sm,
                imageType: ImageType.asset,
                image: AImages.darkAppLogo,
                backgroundColor: AColors.primaryBackground,
              ),
              ARoundedImage(
                width: 90,
                height: 90,
                padding: ASizes.sm,
                imageType: ImageType.asset,
                image: AImages.darkAppLogo,
                backgroundColor: AColors.primaryBackground,
              ),
            ],
          ),

          // load more media button
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: ASizes.spaceBtwSections),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: ASizes.buttonWidth,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text('Load More'),
                    icon: const Icon(Iconsax.arrow_down),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
