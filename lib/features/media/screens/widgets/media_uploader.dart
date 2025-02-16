import 'dart:typed_data';

import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/screens/widgets/folder_dropdown.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/image_model.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;

    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
              children: [
                // Drag & Drop Area
                ARoundedContainer(
                  height: 250,
                  showBorder: true,
                  borderColor: AColors.borderPrimary,
                  backgroundColor: AColors.primaryBackground,
                  padding: const EdgeInsets.all(ASizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DropzoneView(
                              mime: const [
                                'image/jpeg',
                                'image/png',
                                'image/webp',
                                'model/gltf+json',
                                'model/gltf-binary',
                              ],
                              cursor: CursorType.Default,
                              operation: DragOperation.copy,
                              onCreated: (ctrl) =>
                                  controller.dropzoneController = ctrl,
                              onDropFile: (DropzoneFileInterface file) async {
                                final size = await controller.dropzoneController
                                    .getFileSize(file);

                                const maxSize = 10 * 1024 * 1024; // 10MB
                                if (size > maxSize) {
                                  ALoaders.warningSnackBar(
                                    title: 'File Too Large',
                                    message: 'Please select files under 10MB',
                                  );
                                } else {
                                  // Retrieve file data as Uint8List
                                  final bytes = await controller
                                      .dropzoneController
                                      .getFileData(file);

                                  // Extract file metadata
                                  final filename = await controller
                                      .dropzoneController
                                      .getFilename(file);
                                  final mimeType = await controller
                                      .dropzoneController
                                      .getFileMIME(file);

                                  final image = ImageModel(
                                    url: '',
                                    folder: '',
                                    filename: filename,
                                    contentType: mimeType,
                                    localImageToDisplay:
                                        Uint8List.fromList(bytes),
                                  );

                                  controller.selectedImagesToUpload.add(image);
                                }
                              },
                              onError: (ev) => print('Zone error: $ev'),
                              onLoaded: () => print('Zone Loaded'),
                              onHover: () => print('Zone hovered'),
                              onLeave: () => print('Zone left'),
                              onDropInvalid: (ev) =>
                                  print('Zone invalid MIME : $ev'),
                              onDropFiles: (files) =>
                                  print('Zone drop multiple files: $files'),
                            ),

                            // Drop Zone Content
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AImages.defaultMultiImageIcon,
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(height: ASizes.spaceBtwItems),
                                const Text('Drag and Drop Images here'),
                                const SizedBox(height: ASizes.spaceBtwItems),
                                OutlinedButton(
                                  onPressed: () =>
                                      controller.selectLocalImages(),
                                  child: const Text('Select Images'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: ASizes.spaceBtwItems),

                /// Heading & Locally selected images
                if (controller.selectedImagesToUpload.isNotEmpty)
                  ARoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Folders Dropdown
                            Row(
                              children: [
                                Text(
                                  'Select Folder',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(width: ASizes.spaceBtwItems),
                                MediaFolderDropdown(
                                  onChanged: (MediaCategory? newValue) {
                                    if (newValue != null) {
                                      controller.selectedPath.value = newValue;
                                    }
                                  },
                                ),
                              ],
                            ),

                            /// Upload & Remove All buttons
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () =>
                                      controller.selectedImagesToUpload.clear(),
                                  child: const Text('Remove All'),
                                ),
                                const SizedBox(width: ASizes.spaceBtwItems),
                                ADeviceUtils.isMobileScreen(context)
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: ASizes.buttonWidth,
                                        child: ElevatedButton(
                                          onPressed: () => controller
                                              .uploadImagesConfirmation(),
                                          child: const Text('Upload'),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        /// Locally Selected Images
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: ASizes.spaceBtwItems / 2,
                          runSpacing: ASizes.spaceBtwItems / 2,
                          children: controller.selectedImagesToUpload.map(
                            (element) {
                              if (element.contentType!.startsWith('image/')) {
                                return ARoundedImage(
                                  width: 90,
                                  height: 90,
                                  padding: ASizes.sm,
                                  imageType: ImageType.memory,
                                  memoryImage: element.localImageToDisplay,
                                  backgroundColor: AColors.primaryBackground,
                                );
                              } else {
                                return ARoundedContainer(
                                  width: 90,
                                  height: 90,
                                  backgroundColor: AColors.primaryBackground,
                                  padding: const EdgeInsets.all(ASizes.sm),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.threed_rotation,
                                          size: 30, color: AColors.darkGrey),
                                      const SizedBox(
                                          height: ASizes.spaceBtwItems / 2),
                                      Text(
                                        element.filename,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ).toList(),
                        ),

                        const SizedBox(height: ASizes.spaceBtwSections),

                        /// Upload Button for Mobile
                        ADeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      controller.uploadImagesConfirmation(),
                                  child: const Text('Upload'),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                const SizedBox(height: ASizes.spaceBtwSections),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
