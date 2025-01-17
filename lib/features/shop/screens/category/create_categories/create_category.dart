import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/all_categories/responsive_screens/categories_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/all_categories/responsive_screens/categories_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/all_categories/responsive_screens/categories_tablet.dart';
import 'package:flutter/material.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: CategoriesDesktopScreen(),
      tablet: CategoriesTabletScreen(),
      mobile: CategoriesMobileScreen(),
    );
  }
}
