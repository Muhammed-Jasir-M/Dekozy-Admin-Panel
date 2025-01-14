import 'package:aura_kart_admin_panel/common/widgets/layouts/templates/login_template.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const ALoginTemplate(
      child: Column(
        children: [
          // Header
          ALoginHeader(),
          //Form
          ALoginForm()
        ],
      ),
    );
  }
}
