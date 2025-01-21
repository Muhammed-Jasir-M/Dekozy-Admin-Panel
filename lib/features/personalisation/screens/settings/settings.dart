import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/settings/responsive_screens/settings_desktop.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/settings/responsive_screens/settings_tablet.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/settings/responsive_screens/setttings_mobile.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ASiteTemplate(
      desktop: SettingsDesktopScreen(),
      mobile: SetttingsMobileScreen(),
      tablet: SettingsTabletScreen(),
    );
  }
}
