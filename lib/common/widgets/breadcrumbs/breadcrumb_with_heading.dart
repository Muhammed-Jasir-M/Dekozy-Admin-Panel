import 'package:aura_kart_admin_panel/common/widgets/texts/page_heading.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ABreadcrumbsWithHeading extends StatelessWidget {
  const ABreadcrumbsWithHeading({
    super.key,
    required this.heading,
    required this.breadcrumbItems,
    this.returnToPreviousScreen = false,
  });

// The Heading for the page
  final String heading;
//List of Breadcrumb items representing the Navigate path
  final List<String> breadcrumbItems;
//Flag indicating whether to include a button to return to the previous screen
  final bool returnToPreviousScreen;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Breadcrumb trail
        Row(
          children: [
            // DashBoard link
            InkWell(
              onTap: () => Get.offAllNamed(ARoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(ASizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(fontWeightDelta: -1),
                ),
              ),
            ),
            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'),
                  InkWell(
                    onTap: i == breadcrumbItems.length - 1
                        ? null
                        : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(ASizes.xs),
                      //Format breadcrumb item:capitalize and remove loading '/'
                      child: Text(
                        i == breadcrumbItems.length - 1
                            ? breadcrumbItems[i].capitalize.toString()
                            : capitalize(breadcrumbItems[i].substring(1)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontWeightDelta: -1),
                      ),
                    ),
                  ), //Seperator
                ],
              ),
          ],
        ),
        SizedBox(height: ASizes.sm),
        //Heading of the page
        Row(
          children: [
            if (returnToPreviousScreen)
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Iconsax.arrow_left)),
            if (returnToPreviousScreen)
              const SizedBox(
                width: ASizes.spaceBtwItems,
              ),
            APageHeading(heading: heading),
          ],
        )
      ],
    );
  }

  //Function to capitalize the first letter of a string
  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
