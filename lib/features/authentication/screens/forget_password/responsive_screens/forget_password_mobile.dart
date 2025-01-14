import 'package:aura_kart_admin_panel/features/authentication/screens/forget_password/widgets/header_form.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreenMobile extends StatelessWidget {
  const ForgetPasswordScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: HeaderAndform(),
        ),
      ),
    );
  }
}
