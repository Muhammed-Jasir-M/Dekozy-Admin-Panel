import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.parameters['email'] ?? '';

    return Column(
      children: [
        /// Header
        Row(
          children: [
            IconButton(
              onPressed: () => Get.offAllNamed(ARoutes.login),
              icon: const Icon(CupertinoIcons.clear),
            ),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems),

        /// Image
        Image(
          image: AssetImage(AImages.deliveredEmailIllustration),
          width: 300,
          height: 300,
        ),
        SizedBox(height: ASizes.spaceBtwItems),

        /// Title & SubTitle
        Text(
          ATexts.changeYourPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        Text(
          email,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        Text(
          ATexts.changeYourPasswordSubTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(height: ASizes.spaceBtwSections),

        /// Buttons
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.offAllNamed(ARoutes.login),
            child: Text(ATexts.done),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {},
            child: Text(ATexts.resendEmail),
          ),
        ),
      ],
    );
  }
}
