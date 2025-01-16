import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/screens/widgets/folder_dropdown.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({
    super.key
    });

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value ?  Column(
        children: [
          // drag and drop area
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
                        mime: const ['Image/jpeg', 'Image/png'],
                        cursor: CursorType.Default,
                        operation: DragOperation.copy,
                        onLoaded: () => print('Zone Loaded'),
                        onError: (ev) => print('Zone error: $ev'),
                        onHover: () => print('Zone hovered'),
                        onLeave: () => print('Zone left'),
                        onCreated: (ctrl) => controller.dropzoneController = ctrl,
                        onDrop: (file) => print(file.name),
                        onDropInvalid: (ev) => print('Zone invalid MIME : $ev'),
                        onDropMultiple: (ev) print('Zone drop multiple: $ev'),
                      ),
      
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AImages.defaultMultiImageIcon, width: 50, height: 50),
                          const SizedBox(height: ASizes.spaceBtwItems),
                          const Text('Drag and  drop image here'),
                          const SizedBox(height: ASizes.spaceBtwItems),
                          OutlinedButton(onPressed: () {},  child: const Text('Select Images')),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: ASizes.spaceBtwItems),
          // locally selected images
          ARoundedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
      
                    // folder dropdown
      
                    Row(
                      children: [
                        Text('Select Folder', style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(width:  ASizes.spaceBtwItems),
                         MediaFolderDropdown(onChanged: (MediaCategory? newValue) {
                          if(newValue != null) {
                            controller.selectedPath.value = newValue;
                    
                          }
                        }),
                      ],
                    ),
      
      
                     // upload and remove buttons
                    Row(
                      children: [
                        TextButton(onPressed: () {}, child: const Text('Remove All')),
                        const SizedBox(width: ASizes.spaceBtwItems),
                        ADeviceUtils.isMobileScreen(context)
                        ? const SizedBox.shrink()
                        : SizedBox(width: ASizes.buttonWidth, child:  ElevatedButton(onPressed: () {}, child: const Text('Upload'))),
                      ],
                    ),
                  ],
                ),
      
                const SizedBox(height: ASizes.spaceBtwSections),
      
                        const Wrap(
      
                        alignment: WrapAlignment.start,
                        spacing: ASizes.spaceBtwItems / 2,
                        runSpacing: ASizes.spaceBtwItems / 2,
                        children: [
                          ARoundedContainer(
                            width: 90,
                            height: 90,
                            padding: ASizes.sm,
                            imageType: ImageType.asset,
                            image: AImages.darkAppLogo,
                            backgroundColor: AColors.primaryBackground,
                          ),
                          
                          ARoundedContainer(
                            width: 90,
                            height: 90,
                            padding: ASizes.sm,
                            imageType: ImageType.asset,
                            image: AImages.darkAppLogo,
                            backgroundColor: AColors.primaryBackground,
                          ),
                          
                          ARoundedContainer(
                            width: 90,
                            height: 90,
                            padding: ASizes.sm,
                            imageType: ImageType.asset,
                            image: AImages.darkAppLogo,
                            backgroundColor: AColors.primaryBackground,
                          ),
                          
                          ARoundedContainer(
                            width: 90,
                            height: 90,
                            padding: ASizes.sm,
                            imageType: ImageType.asset,
                            image: AImages.darkAppLogo,
                            backgroundColor: AColors.primaryBackground,
                          ),
                          
                          ARoundedContainer(
                            width: 90,
                            height: 90,
                            padding: ASizes.sm,
                            imageType: ImageType.asset,
                            image: AImages.darkAppLogo,
                            backgroundColor: AColors.primaryBackground,
                          ),
                        ],
                      ),
                       const SizedBox(height: ASizes.spaceBtwSections),
          ADeviceUtils.isMobileScreen(context)
          ? SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {}, child: const Text('Upload')))
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
