import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductArModel extends StatelessWidget {
  const ProductArModel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductImagesController());

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product AR Text
          Text('Product AR Model',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: ASizes.spaceBtwItems),

          // Container for Product AR Model
          ARoundedContainer(
            height: 300,
            backgroundColor: AColors.primaryBackground,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // AR Model
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Obx(
                          () {
                            final arModelUrl =
                                controller.selectedArModelUrl.value;

                            if (arModelUrl == null || arModelUrl.isEmpty) {
                              return ARoundedImage(
                                width: 220,
                                height: 220,
                                image: AImages.defaultSingleImageIcon,
                                imageType: ImageType.asset,
                              );
                            }

                            return SizedBox(
                              width: 220,
                              height: 220,
                              child: ModelViewer(
                                src: arModelUrl,
                                alt: 'AR Model',
                                ar: false,
                                autoRotate: true,
                                cameraControls: false,
                                backgroundColor: AColors.primaryBackground,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  // Add Thumbnail Button
                  SizedBox(
                    width: 220,
                    child: OutlinedButton(
                      onPressed: () => controller.selectArModel(),
                      child: const Text('Add Ar Model'),
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
