import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/edit_categories/responsive_screens/edit_categories_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/edit_categories/responsive_screens/edit_categories_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/edit_categories/responsive_screens/edit_categories_tablet.dart';
import 'package:aura_kart_admin_panel/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.arguments;
    return ASiteTemplate(
      desktop: EditCategoryDesktopScreen(category: category),
      tablet: EditCategoryTabletScreen(category: category),
      mobile: EditCategoryMobileScreen(category: category),
    );
  }
}
