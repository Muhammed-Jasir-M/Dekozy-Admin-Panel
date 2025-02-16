import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/banner_model.dart';

class EditBannerDesktopScreen extends StatelessWidget {
  const EditBannerDesktopScreen({super.key, required this.banner});

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              // Breadcrumbs
              const ABreadcrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Update Banner',
                breadcrumbItems: [ARoutes.banners, 'Update Banner'],
              ),

              const SizedBox(height: ASizes.spaceBtwSections),

              // Form
              EditBannerForm(banner: banner),
            ],
          ),
        ),
      ),
    );
  }
}
