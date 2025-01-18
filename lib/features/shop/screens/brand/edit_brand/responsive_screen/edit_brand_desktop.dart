import 'package:aura_kart_admin_panel/features/shop/models/brand_model.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/edit_brand_form.dart';

class EditBrandDesktopScreen extends StatelessWidget {
  const EditBrandDesktopScreen({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(ASizes.defaultSpace), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            const ABreadcrumbsWithHeading(heading: 'Update Brand',returnToPreviousScreen: true, breadcrumbItems: [ARoutes.categories, 'Update Brand']),
            const SizedBox(height: ASizes.spaceBtwSections),

            // Form 
            EditBrandForm(brand: brand),
          ],
        ),),
      ),
    );
  }
}