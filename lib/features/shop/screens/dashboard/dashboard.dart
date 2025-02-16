import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/responsive_screens/dashboard_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/responsive_screens/dashboard_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/responsive_screens/dashboard_tablet.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: DashboardDesktopScreen(),
      tablet: DashboardTabletScreen(),
      mobile: DashboardMobileScreen(),
    );
  }
}
