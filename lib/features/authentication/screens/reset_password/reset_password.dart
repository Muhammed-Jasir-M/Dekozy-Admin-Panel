import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/reset_password/responsive_screens/reset_password_desktop_tablet.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/reset_password/responsive_screens/reset_password_mobail.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ASiteTemplate(
      useLayout: false,
      desktop: ResetPasswordScreenDesktopTablet(),
      mobile: ResetPasswordScreenMobile(),
    );
  }
}