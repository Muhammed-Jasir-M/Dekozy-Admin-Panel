import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class ALoginHeader extends StatelessWidget {
  const ALoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            width: 100,
            height: 100,
            image: AssetImage(AImages.darkAppLogo),
          ),
          const SizedBox(height: ASizes.spaceBtwSections),
          Text(ATexts.loginTitle,
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: ASizes.sm),
          Text(ATexts.loginSubTitle,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
