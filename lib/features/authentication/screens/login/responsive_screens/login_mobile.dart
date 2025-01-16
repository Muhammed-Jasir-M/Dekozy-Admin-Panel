import 'package:aura_kart_admin_panel/features/authentication/screens/login/widgets/login_form.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/login/widgets/login_header.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: Column(
            children: [
              // Header
              ALoginHeader(),

              // Form
              ALoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
