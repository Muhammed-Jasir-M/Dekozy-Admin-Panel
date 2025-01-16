import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';
import 'responsive_screens/create_banner_desktop.dart';
import 'responsive_screens/create_banner_mobile.dart';
import 'responsive_screens/create_banner_tablet.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      desktop: CreateBannerDesktopScreen(),
      tablet: CreateBannerTabletScreen(),
      mobile: CreateBannerMobileScreen(),
    );
  }
}
