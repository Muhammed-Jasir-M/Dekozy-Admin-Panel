import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/personalisation/controllers/user_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    controller.firstNameController.text = controller.user.value.firstName;
    controller.lastNameController.text = controller.user.value.lastName;
    controller.phoneController.text = controller.user.value.phoneNumber;

    return Column(
      children: [
        ARoundedContainer(
          padding: const EdgeInsets.symmetric(
              vertical: ASizes.lg, horizontal: ASizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile Details',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: ASizes.spaceBtwSections),

              // First & Last Name
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // First Name
                        Expanded(
                          child: TextFormField(
                            controller: controller.firstNameController,
                            decoration: const InputDecoration(
                              hintText: 'First Name',
                              label: Text('First Name'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => AValidator.validateEmptyText(
                                'First Name', value),
                          ),
                        ),
                        const SizedBox(width: ASizes.spaceBtwInputFields),

                        // Last Nanme
                        Expanded(
                          child: TextFormField(
                            controller: controller.lastNameController,
                            decoration: const InputDecoration(
                              hintText: 'Last Name',
                              label: Text('Last Name'),
                              prefixIcon: Icon(Iconsax.user),
                            ),
                            validator: (value) => AValidator.validateEmptyText(
                                'Last Name', value),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: ASizes.spaceBtwInputFields),

                    // Email & Phone
                    Row(
                      children: [
                        // Email
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
                        // Phone
                        Expanded(
                          child: TextFormField(
                            controller: controller.phoneController,
                            decoration: const InputDecoration(
                              hintText: 'Phone',
                              label: Text('Phone'),
                              prefixIcon: Icon(Iconsax.mobile),
                            ),
                            validator: (value) =>
                                AValidator.validateEmptyText('Phone', value),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: ASizes.spaceBtwSections),

              // Update Button
              SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: () => controller.loading.value
                        ? () {}
                        : controller.updateUserInformation(),
                    child: controller.loading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text('Update Profile'),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
