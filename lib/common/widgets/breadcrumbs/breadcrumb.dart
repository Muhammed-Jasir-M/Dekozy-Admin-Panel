import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../utils/constants/sizes.dart';

class ABreadcrumbs extends StatelessWidget {
  const ABreadcrumbs({super.key, required this.breadcrumbItems});

  // List of Breadcrumb items representing the Navigation path
  final List<String> breadcrumbItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // DashBoard Link
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
              const Text('/'), // Separator
              InkWell(
                // Last item should not be clickable
                onTap: i == breadcrumbItems.length - 1
                    ? null
                    : () => Get.toNamed(breadcrumbItems[i]),
                child: Padding(
                  padding: const EdgeInsets.all(ASizes.xs),
                  // Format breadcrumb item: capitalize and remove leading '/'
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
              ),
            ],
          ),
      ],
    );
  }

  // Function to capitalize the first letter of a string
  String capitalize(String s) {
    return s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1);
  }
}
