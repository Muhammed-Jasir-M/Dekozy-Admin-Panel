import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // app settings
        ARoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: ASizes.lg, horizontal: ASizes.md),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App settings', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: ASizes.spaceBtwSections),

                //app name
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    label: Text('App Name'),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: ASizes.spaceBtwInputFields),

                // email and phone

                Row(
                  children: [
                    //first name
                    Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Tax %',
                              label: Text('Tax Rate %'),
                              prefixIcon: Icon(Iconsax.forward),
                              enabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: ASizes.spaceBtwItems),
                        // last name
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Shipping Cost',
                              label: Text('Shipping cost (\$)'),
                              prefixIcon: Icon(Iconsax.ship),
                            ),
                          ),
                      ),
                      const SizedBox(width: ASizes.spaceBtwItems),
                      // last name
                      Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Free shipping cost after (\$)',
                              label: Text('Free Shipping threshold (\$)'),
                              prefixIcon: Icon(Iconsax.ship),
                            ),
                          ),
                      ),
                  ],
                ),
                const SizedBox(height: ASizes.spaceBtwInputFields * 2),
                

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: const Text('Update App Settings')),
                ),
              ],
            )),
        )
      ],
    );
  }
}