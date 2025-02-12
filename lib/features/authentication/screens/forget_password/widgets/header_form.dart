import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../utils/validators/validation.dart';
import '../../../controllers/forget_password_controller.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

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
          key: controller.forgetPasswordFormKey,
          child: TextFormField(
            controller: controller.email,
            validator: AValidator.validateEmail,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: ATexts.email,
            ),
          ),
        ),

        SizedBox(height: ASizes.spaceBtwSections),

        /// Submit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => controller.sendPasswordResetEmail(),
            child: Text(ATexts.submit),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwItems * 2),
      ],
    );
  }
}
