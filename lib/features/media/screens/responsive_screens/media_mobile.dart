import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/screens/widgets/media_uploader.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../widgets/media_content.dart';

class MediaMobileScreen extends StatelessWidget {
  const MediaMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header

              // Breadcrumbs
              const ABreadcrumbsWithHeading(
                  heading: 'Media', breadcrumbItems: ['Media Screen']),

              const SizedBox(width: ASizes.spaceBtwItems),

              // Toggle  Images Section Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: ASizes.buttonWidth,
                    child: ElevatedButton.icon(
                      onPressed: () => controller.showImagesUploaderSection
                          .value = !controller.showImagesUploaderSection.value,
                      icon: const Icon(Iconsax.add),
                      label: const Text('Upload'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: ASizes.spaceBtwSections),

              /// Upload Area
              const MediaUploader(),

              /// Media Content
              MediaContent(
                allowSelection: false,
                allowMultipleSelection: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
