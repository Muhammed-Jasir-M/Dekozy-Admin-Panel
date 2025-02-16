import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/create_brand/widgets/create_brand_form.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBrandTabletScreen extends StatelessWidget {
  const CreateBrandTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              ABreadcrumbsWithHeading(
                heading: 'Create Brand',
                returnToPreviousScreen: true,
                breadcrumbItems: [ARoutes.brands, 'Create Brand'],
              ),

              SizedBox(height: ASizes.spaceBtwSections),

              // Form
              CreateBrandForm(),
            ],
          ),
        ),
      ),
    );
  }
}
