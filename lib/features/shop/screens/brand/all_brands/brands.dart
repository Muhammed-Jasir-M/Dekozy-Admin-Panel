import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/all_brands/responsive_screens/brands_desktop.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/brands_mobile.dart';
import 'responsive_screens/brands_tablet.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: BrandsDesktopScreen(),
      tablet: BrandsTabletScreen(),
      mobile: BrandsMobileScreen(),
    );
  }
}
