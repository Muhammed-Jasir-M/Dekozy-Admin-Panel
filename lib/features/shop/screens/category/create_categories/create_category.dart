import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/create_categories/responsive_screens/create_categories_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/create_categories/responsive_screens/create_categories_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/create_categories/responsive_screens/create_categories_tablet.dart';
import 'package:flutter/material.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: CreateCategoryDesktopScreen(),
      tablet: CreateCategoryTabletScreen(),
      mobile: CreateCategoryMobileScreen(),
    );
  }
}
