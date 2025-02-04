import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
        SizedBox(height: ASizes.spaceBtwItems),

        Text(ATexts.forgetPasswordTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        SizedBox(height: ASizes.spaceBtwItems),

        Text(ATexts.forgetPasswordSubTitle,
            style: Theme.of(context).textTheme.labelMedium),
        SizedBox(height: ASizes.spaceBtwItems * 2),

        /// Form
        Form(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: ATexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwSections),

        /// Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.toNamed(
              ARoutes.resetPassword,
              parameters: {'email': 'some@gmail.com'},
            ),
            child: Text(ATexts.submit),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwItems * 2),
      ],
    );
  }
}
