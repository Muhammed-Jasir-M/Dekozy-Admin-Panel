import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/profile/widgets/profile_form.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/profile/widgets/image_meta.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileDesktopScreen extends StatelessWidget {
  const ProfileDesktopScreen({super.key});

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
                  heading: 'Profile', breadcrumbItems: ['Profile']),
              SizedBox(height: ASizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic & Meta
                  Expanded(child: ImageAndMeta()),
                  SizedBox(width: ASizes.spaceBtwSections),

                  // Form
                  Expanded(flex: 2, child: ProfileForm()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
