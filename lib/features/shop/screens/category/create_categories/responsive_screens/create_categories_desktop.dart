import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/create_categories/widgets/create_category_form.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateCategoryDesktopScreen extends StatelessWidget {
  const CreateCategoryDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              ABreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Create Category',
                  breadcrumbItems: [ARoutes.categories, 'Create Category']),
              SizedBox(height: ASizes.spaceBtwSections),
              //Form
              CreateCategoryForm(),
            ],
          ),
        ),
      ),
    );
  }
}
