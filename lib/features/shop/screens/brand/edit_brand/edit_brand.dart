import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/edit_brand/responsive_screen/edit_brand_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/edit_brand/responsive_screen/edit_brand_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/edit_brand/responsive_screen/edit_brand_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brand = Get.arguments;
    return ASiteTemplate(
      desktop: EditBrandDesktopScreen(brand: brand),
      tablet: EditBrandTabletScreen(brand: brand),
      mobile: EditBrandMobileScreen(brand: brand),
    );
  }
}
