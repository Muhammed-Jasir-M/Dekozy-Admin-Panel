import 'package:flutter/material.dart';

import '../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../profile/widgets/image_meta.dart';
import '../widgets/settings_form.dart';

class SetttingsMobileScreen extends StatelessWidget {
  const SetttingsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              ABreadcrumbsWithHeading(
                  heading: 'Settings', breadcrumbItems: ['Settings']),
              SizedBox(height: ASizes.spaceBtwSections),

              // Body
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic & Meta
                  ImageAndMeta(),
                  SizedBox(width: ASizes.spaceBtwSections),

                  // Form
                  SettingsForm(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}