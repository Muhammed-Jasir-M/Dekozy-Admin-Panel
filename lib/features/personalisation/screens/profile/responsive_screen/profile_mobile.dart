import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/profile/widgets/form.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/settings/widgets/image_meta.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProfileMobileScreen extends StatelessWidget {
  const ProfileMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //breadcrumbs
              ABreadcrumbsWithHeading(
                  heading: 'Profile', breadcrumbItems: ['Profile']),
                  SizedBox(height: ASizes.spaceBtwSections),

                  Column(
                    children: [
                      ImageAndMeta(),
                      SizedBox(height: ASizes.spaceBtwSections),


                      //forms
                      ProfileForm(),
                    ],
                  )
            ],
          ),
        ),
      ),
    );
  }
}
