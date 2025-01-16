import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/forget_password/widgets/header_form.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreenDesktopTablet extends StatelessWidget {
  const ForgetPasswordScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return ALoginTemplate(
      child: HeaderAndForm(),
    );
  }
}
