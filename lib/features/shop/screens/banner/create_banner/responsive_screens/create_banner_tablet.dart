import 'package:flutter/material.dart';
import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/create_banner_form.dart';

class CreateBannerTabletScreen extends StatelessWidget {
  const CreateBannerTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              // Breadcrumbs
              ABreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Create Banner',
                breadcrumbItems: [ARoutes.banners, 'Create Banner'],
              ),
              SizedBox(height: ASizes.spaceBtwSections),

              // Form
              CreateBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
