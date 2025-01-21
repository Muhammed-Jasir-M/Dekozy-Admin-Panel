import 'package:aura_kart_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/edit_categories/widgets/edit_category_form.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditCategoryDesktopScreen extends StatelessWidget {
  const EditCategoryDesktopScreen({
    super.key,
    required this.category,
  });
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Breadcrumbs
              const ABreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: 'Update Category',
                  breadcrumbItems: [ARoutes.categories, 'Update Category']),
              const SizedBox(height: ASizes.spaceBtwSections),
              //Form
              EditCategoryForm(category: category),
            ],
          ),
        ),
      ),
    );
  }
}
