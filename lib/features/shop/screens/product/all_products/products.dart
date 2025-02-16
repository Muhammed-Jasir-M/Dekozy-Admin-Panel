import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/all_products/responsive_screens/products_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/all_products/responsive_screens/products_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/all_products/responsive_screens/products_tablet.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: ProductsDesktopScreen(),
      tablet: ProductsTabletScreen(),
      mobile: ProductsMobileScreen(),
    );
  }
}
