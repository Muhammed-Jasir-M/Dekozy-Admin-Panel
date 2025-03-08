import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import 'package:aura_kart_admin_panel/features/personalisation/screens/settings/widgets/settings_form.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../settings/widgets/image_meta.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic & Meta
                  Expanded(child: ImageAndMeta()),
                  SizedBox(width: ASizes.spaceBtwSections),

                  // Form
                  Expanded(flex: 2, child: SettingsForm()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
