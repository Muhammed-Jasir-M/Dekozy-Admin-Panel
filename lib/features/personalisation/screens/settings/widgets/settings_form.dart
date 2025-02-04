import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Settings
        ARoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: ASizes.lg, horizontal: ASizes.md),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('App Settings',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: ASizes.spaceBtwSections),

              // App Name
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'App Name',
                  label: Text('App Name'),
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
              const SizedBox(height: ASizes.spaceBtwInputFields),

              Row(
                children: [
                  // Tax Rate
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Tax %',
                        label: Text('Tax Rate (%)'),
                        prefixIcon: Icon(Iconsax.forward),
                        enabled: false,
                      ),
                    ),
                  ),
                  const SizedBox(width: ASizes.spaceBtwItems),
                  // Shipping Cost
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Shipping Cost',
                        label: Text('Shipping Cost (\$)'),
                        prefixIcon: Icon(Iconsax.ship),
                      ),
                    ),
                  ),
                  const SizedBox(width: ASizes.spaceBtwItems),
                  // Free Shipping Cost 
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Free Shipping After (\$)',
                        label: Text('Free Shipping Threshold (\$)'),
                        prefixIcon: Icon(Iconsax.ship),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ASizes.spaceBtwInputFields * 2),

              // Update Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text('Update App Settings')),
              ),
            ],
          )),
        )
      ],
    );
  }
}
