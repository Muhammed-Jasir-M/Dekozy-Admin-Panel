import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/banner/edit_banner/responsive_screens/edit_banner_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = Get.arguments;
    return ASiteTemplate(
      desktop: EditBannerDesktopScreen(banner: banner),
      tablet: EditBannerTabletScreen(banner: banner),
      mobile: EditBannerMobileScreen(banner: banner),
    );
  }
}