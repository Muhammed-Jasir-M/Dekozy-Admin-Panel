// ignore_for_file: avoid_print

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
                              // mime: const ['Image/jpeg', 'Image/png'],
                              cursor: CursorType.Default,
                              operation: DragOperation.copy,
                              onCreated: (ctrl) =>
                                  controller.dropzoneController = ctrl,
                              onLoaded: () => print('Zone Loaded'),
                              onError: (ev) => print('Zone error: $ev'),
                              onHover: () => print('Zone hovered'),
                              onLeave: () => print('Zone left'),
                              onDropInvalid: (ev) =>
                                  print('Zone invalid MIME : $ev'),
                              onDropFile: (DropzoneFileInterface ev) async {
                                // Retrieve file data as Uint8List
                                final bytes = await controller
                                    .dropzoneController
                                    .getFileData(ev);

                                // Extract file metadata
                                final filename = await controller
                                    .dropzoneController
                                    .getFilename(ev);
                                final mimeType = await controller
                                    .dropzoneController
                                    .getFileMIME(ev);

                                final image = ImageModel(
                                  url: '',
                                  folder: '',
                                  filename: filename,
                                  localImageToDisplay:
                                      Uint8List.fromList(bytes),
                                  contentType: mimeType,
                                );

                                controller.selectedImagesToUpload.add(image);
                              },
                              onDropString: (String s) => print('Drop: $s'),
                              onDropFiles: (files) =>
                                  print('Zone drop multiple files: $files'),
                              onDropStrings: (strings) =>
                                  print('Zone drop strings multiple: $strings'),
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

                            /// Upload & Remove buttons
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
                          children: controller.selectedImagesToUpload
                              .where(
                                  (image) => image.localImageToDisplay != null)
                              .map(
                                (element) => ARoundedImage(
                                  width: 90,
                                  height: 90,
                                  padding: ASizes.sm,
                                  memoryImage: element.localImageToDisplay,
                                  backgroundColor: AColors.primaryBackground,
                                  imageType: ImageType.memory,
                                ),
                              )
                              .toList(),
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
