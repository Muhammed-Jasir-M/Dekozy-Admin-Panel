import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Breadcrumbs
                  ABreadcrumbsWithHeading(
                    heading: 'Media',
                    breadcrumbItems: [
                      ARoutes.login,
                      ARoutes.forgetPassword,
                      'Media Screen'
                    ],
                    returnToPreviousScreen: true,
                  )
                ],
              ),
              SizedBox(height: ASizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
