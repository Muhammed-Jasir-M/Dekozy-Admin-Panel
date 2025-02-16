import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/image_uploader.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class ProductAdditionalImages extends StatelessWidget {
  const ProductAdditionalImages({
    super.key,
    required this.additionalProductImagesURLs,
    this.onTapToAddImages,
    this.onTapToRemoveImage,
  });

  final RxList<String> additionalProductImagesURLs;
  final void Function()? onTapToAddImages;
  final void Function(int index)? onTapToRemoveImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          // Section to add additional Product Images
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTapToAddImages,
              child: ARoundedContainer(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AImages.defaultMultiImageIcon,
                        width: 50,
                        height: 50,
                      ),
                      const Text('Add Additional Product Images'),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Section to Display Uploaded Images
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 80,
                    child: _uploadedImagesOrEmptyList(),
                  ),
                ),
                const SizedBox(width: ASizes.spaceBtwItems / 2),

                // Add More Images Button
                ARoundedContainer(
                  width: 80,
                  height: 80,
                  showBorder: true,
                  borderColor: AColors.grey,
                  backgroundColor: AColors.white,
                  onTap: onTapToAddImages,
                  child: const Center(child: Icon(Iconsax.add)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to Display Either Uploaded Images or Empty List
  Widget _uploadedImagesOrEmptyList() {
    return emptyList();
  }

  // Widget to Display Empty List Placeholder
  Widget emptyList() {
    return ListView.separated(
      itemCount: 6,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => const ARoundedContainer(
        backgroundColor: AColors.primaryBackground,
        width: 80,
        height: 80,
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(width: ASizes.spaceBtwItems / 2),
    );
  }

  // Widget to Display Uploaded Images
  Widget uploadedImages() {
    return ListView.separated(
      itemCount: additionalProductImagesURLs.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final image = additionalProductImagesURLs[index];
        return AImageUploader(
          top: 0,
          right: 0,
          width: 80,
          height: 80,
          left: null,
          bottom: null,
          imageType: ImageType.network,
          image: image,
          icon: Iconsax.trash,
          onIconButtonPressed: () => onTapToRemoveImage!(index),
        );
      },
      separatorBuilder: (context, index) =>
          const SizedBox(width: ASizes.spaceBtwItems / 2),
    );
  }
}
