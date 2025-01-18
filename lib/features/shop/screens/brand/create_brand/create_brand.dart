import 'package:aura_kart_admin_panel/features/shop/screens/brand/create_brand/responsive_screen/create_brand_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/create_brand/responsive_screen/create_brand_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/create_brand/responsive_screen/create_brand_tablet.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class CreateBrandScreen extends StatelessWidget {
  const CreateBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ASiteTemplate(
      desktop: CreateBrandDesktopScreen(),
      tablet: CreateBrandTabletScreen(),
      mobile: CreateBrandMobileScreen(),
    );
  }
}