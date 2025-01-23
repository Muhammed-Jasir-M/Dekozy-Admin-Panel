import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ImageAndMeta extends StatelessWidget {
  const ImageAndMeta({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      padding: const EdgeInsets.symmetric(
          vertical: ASizes.lg, horizontal: ASizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              // User image
              AImageUploader(
                right: 10,
                bottom: 20,
                left: null,
                width: 200,
                height: 200,
                circular: true,
                icon: Iconsax.camera,
                imageType: ImageType.asset,
                image: AImages.user,
              ),
              const SizedBox(height: ASizes.spaceBtwItems),

              Text('AURAKART',
                  style: Theme.of(context).textTheme.headlineLarge),

              const SizedBox(height: ASizes.spaceBtwSections),
            ],
          )
        ],
      ),
    );
  }
}
