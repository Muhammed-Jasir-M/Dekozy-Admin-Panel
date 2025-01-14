import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ALoginForm extends StatelessWidget {
  const ALoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: ASizes.spaceBtwSections),
      child: Column(
        children: [
          /// Email
          TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: ATexts.email,
            ),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields),

          ///Password
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: ATexts.password,
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Iconsax.eye_slash))),
          ),
          const SizedBox(height: ASizes.spaceBtwInputFields / 2),

          /// Remember me & Forget Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///Remember me
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  const Text(ATexts.rememberMe),
                ],
              ),

              ///Forget Password
              TextButton(
                  onPressed: () => Get.toNamed(ARoutes.forgetPassword), child: const Text(ATexts.forgetPassword)),
            ],
          ),

          ///Sign in Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {}, child: Text(ATexts.signIn)),
          )
        ],
      ),
    ));
  }
}
