import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/media/screens/responsive_screens/media_desktop.dart';
import 'package:aura_kart_admin_panel/features/media/screens/responsive_screens/media_mobile.dart';
import 'package:aura_kart_admin_panel/features/media/screens/responsive_screens/media_tablet.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: MediaDesktopScreen(),
      tablet: MediaTabletScreen(),
      mobile: MediaMobileScreen(),
    );
  }
}
