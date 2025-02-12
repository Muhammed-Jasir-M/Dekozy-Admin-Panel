import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../../../utils/constants/colors.dart';

class ImagePopup extends StatelessWidget {
  const ImagePopup({super.key, required this.image});

  // Image Model to display detailed info about it.
  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        // Define the shape of the dialog.
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ASizes.borderRadiusLg)),
        child: ARoundedContainer(
          // Set the width of the rounded container based on the screen size.
          width: ADeviceUtils.isDesktopScreen(context)
              ? MediaQuery.of(context).size.width * 0.4
              : double.infinity,
          padding: const EdgeInsets.all(ASizes.spaceBtwItems),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image with an option to close the dialog.
              SizedBox(
                child: Stack(
                  children: [
                    ARoundedContainer(
                      backgroundColor: AColors.primaryBackground,
                      child: image.contentType == 'image'
                          ? ARoundedImage(
                              imageType: ImageType.network,
                              image: image.url,
                              applyImageRadius: true,
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: ADeviceUtils.isDesktopScreen(context)
                                  ? MediaQuery.of(context).size.width * 0.4
                                  : double.infinity,
                            )
                          : SizedBox(
                              width: ADeviceUtils.isDesktopScreen(context)
                                  ? MediaQuery.of(context).size.width * 0.4
                                  : double.infinity,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ModelViewer(
                                src: image.url,
                                alt: image.filename,
                                ar: true,
                                autoRotate: true,
                                cameraControls: true,
                              ),
                            ),
                    ),

                    // Close icon button positioned at the top-right corner
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Iconsax.close_circle),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: ASizes.spaceBtwItems),

              // Display various metadata about image.
              // Includes image name, path, types, size, creation & modification dates, & URL.
              // Also provides an option to copy the image URL.
              Row(
                children: [
                  Expanded(
                      child: Text('Image Name:',
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                      flex: 3,
                      child: Text(image.filename,
                          style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),

              // Display the image URL with an option to copy it.
              Row(
                children: [
                  Expanded(
                      child: Text('Image URL:',
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Expanded(
                    flex: 2,
                    child: Text(
                      image.url,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        FlutterClipboard.copy(image.url).then((value) =>
                            ALoaders.customToast(message: 'URL copied!'));
                      },
                      child: const Text('Copy URL'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Display a button to delete image
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: () => MediaController.instance
                          .removeCloudImageConfirmation(image),
                      child: const Text('Delete Image',
                          style: TextStyle(color: Colors.red)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
