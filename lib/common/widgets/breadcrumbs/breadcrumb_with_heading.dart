import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb.dart';
import 'package:aura_kart_admin_panel/common/widgets/texts/page_heading.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ABreadcrumbsWithHeading extends StatelessWidget {
  const ABreadcrumbsWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbItems,
    this.returnToPreviousScreen = false,
  });

  // The Heading for the page
  final String heading;

  // List of Breadcrumb items representing the Navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb Trail
        ABreadcrumbs(breadcrumbItems: breadcrumbItems),
        SizedBox(height: ASizes.sm),

        // Heading of the page
        Row(
          children: [
            if (returnToPreviousScreen)
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Iconsax.arrow_left),
              ),
            if (returnToPreviousScreen)
              const SizedBox(width: ASizes.spaceBtwItems),
            APageHeading(heading: heading),
          ],
        )
      ],
    );
  }
}
