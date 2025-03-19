import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/personalisation/controllers/settings_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsController.instance;
    final isMobileScreen = ADeviceUtils.isMobileScreen(context);

    return Column(
      children: [
        // App Settings
        ARoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: ASizes.lg, horizontal: ASizes.md),
          child: Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Settings',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: ASizes.spaceBtwSections),

                // App Name
                TextFormField(
                  controller: controller.appNameController,
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    label: Text('App Name'),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: ASizes.spaceBtwInputFields),

                if (!isMobileScreen)
                  Row(
                    children: [
                      // Tax Rate
                      Expanded(
                        child: TextFormField(
                          controller: controller.taxController,
                          decoration: const InputDecoration(
                            hintText: 'Tax %',
                            label: Text('Tax Rate (%)'),
                            prefixIcon: Icon(Iconsax.tag),
                          ),
                        ),
                      ),
                      const SizedBox(width: ASizes.spaceBtwItems),
                      // Shipping Cost
                      Expanded(
                        child: TextFormField(
                          controller: controller.shippingController,
                          decoration: const InputDecoration(
                            hintText: 'Shipping Cost',
                            label: Text('Shipping Cost (\u{20B9})'),
                            prefixIcon: Icon(Iconsax.ship),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!isMobileScreen)
                  const SizedBox(height: ASizes.spaceBtwInputFields),

                if (isMobileScreen)
                  Column(
                    children: [
                      // Tax Rate
                      TextFormField(
                        controller: controller.taxController,
                        decoration: const InputDecoration(
                          hintText: 'Tax %',
                          label: Text('Tax Rate (%)'),
                          prefixIcon: Icon(Iconsax.tag),
                        ),
                      ),
                      const SizedBox(height: ASizes.spaceBtwItems),
                      // Shipping Cost
                      TextFormField(
                        controller: controller.shippingController,
                        decoration: const InputDecoration(
                          hintText: 'Shipping Cost',
                          label: Text('Shipping Cost (\u{20B9})'),
                          prefixIcon: Icon(Iconsax.ship),
                        ),
                      ),
                    ],
                  ),
                if (isMobileScreen)
                  const SizedBox(height: ASizes.spaceBtwInputFields),

                // Free Shipping Cost
                TextFormField(
                  controller: controller.freeShippingThresholdController,
                  decoration: const InputDecoration(
                    hintText: 'Free Shipping After (\u{20B9})',
                    label: Text('Free Shipping Threshold (\u{20B9})'),
                    prefixIcon: Icon(Iconsax.ship),
                  ),
                ),

                const SizedBox(height: ASizes.spaceBtwInputFields * 2),

                // Update Button
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: () => controller.loading.value
                          ? () {}
                          : controller.updateSettingInformation(),
                      child: controller.loading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : const Text('Update App Settings'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
