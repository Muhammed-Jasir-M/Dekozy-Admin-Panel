import 'package:aura_kart_admin_panel/features/authentication/controllers/login_controller.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/constants/text_strings.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ALoginForm extends StatelessWidget {
  const ALoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ASizes.spaceBtwSections),
        child: Column(
          children: [
            /// Email
            TextFormField(
              controller: controller.email,
              validator: AValidator.validateEmail,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: ATexts.email),
            ),

            const SizedBox(height: ASizes.spaceBtwInputFields),

            /// Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) =>
                    AValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: ATexts.password,
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(
                      controller.hidePassword.value
                          ? Iconsax.eye_slash
                          : Iconsax.eye,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: ASizes.spaceBtwInputFields / 2),

            /// Remember Me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Remember Me
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) =>
                              controller.rememberMe.value = value!),
                    ),
                    const Text(ATexts.rememberMe),
                  ],
                ),

                /// Forget Password
                TextButton(
                  onPressed: () => Get.toNamed(ARoutes.forgetPassword),
                  child: const Text(ATexts.forgetPassword),
                ),
              ],
            ),

            SizedBox(height: ASizes.spaceBtwSections),

            /// Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(ATexts.signIn),
              ),
            ),

            SizedBox(height: ASizes.spaceBtwItems),

            /// Register Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.registerAdmin(),
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
