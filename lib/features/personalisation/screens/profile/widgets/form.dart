import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ARoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: ASizes.lg, horizontal: ASizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile Details', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: ASizes.spaceBtwSections),

              // first and last name
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                          
                          // first name

                          Expanded(
                            child:TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'First Name',
                                label: Text('first Name'),
                                prefixIcon: Icon(Iconsax.user),
                              ) ,
                              validator: (value)=> AValidator.validateEmptyText('first Name', value),
                            ),
                          ),
                          const SizedBox(width: ASizes.spaceBtwInputFields),

                          // last nanme
                          Expanded(
                            child:TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Last Name',
                                label: Text('Last Name'),
                                prefixIcon: Icon(Iconsax.user),
                              ) ,
                              validator: (value)=> AValidator.validateEmptyText('Last Name', value),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: ASizes.spaceBtwInputFields),

                    //email and phone
                    Row(
                      children: [
                        //first name
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              label: Text('Email'),
                              prefixIcon: Icon(Iconsax.forward),
                              enabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(height: ASizes.spaceBtwItems),
                        //last name
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Phone Number',
                              label: Text('Phone Number'),
                              prefixIcon: Icon(Iconsax.mobile),
                            ),
                            validator: (value) => AValidator.validateEmptyText('Phone Number', value),
                          ),
                         ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: const Text('Update Profile')),
              ),
            ],
          ),
        )
      ],
    );
  }
}