import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brands/all_brands/responsive_screen/brands_desktop.dart';
import 'package:flutter/material.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(desktop: BrandsDesktopScreen(),tablet: BrandsTabletScreen(),mobile: BrandsMobileScreen());
  }
}