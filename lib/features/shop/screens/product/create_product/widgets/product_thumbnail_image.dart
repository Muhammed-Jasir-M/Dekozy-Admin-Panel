import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductThumbnailImage extends StatelessWidget {
  const ProductThumbnailImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Thumbnail Text
          Text('Product Thumbnail',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Container for Product Thumbnail
          ARoundedContainer(
            height: 300,
            backgroundColor: AColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnail Image
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ARoundedImage(
                          width: 220,
                          height: 220,
                          image: AImages.defaultSingleImageIcon,
                          imageType: ImageType.asset,
                        ),
                      ),
                    ],
                  ),

                  // Add Thumbnail Button
                  SizedBox(
                    width: 220,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Add Thumbnail'),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
