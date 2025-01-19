import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/profile/responsive_screen/profile_desktop.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/profile/responsive_screen/profile_mobile.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/profile/responsive_screen/profile_tablet.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: ProfileDesktopScreen(),
      tablet: ProfileTabletScreen(),
      mobile: ProfileMobileScreen(),
    );
  }
}