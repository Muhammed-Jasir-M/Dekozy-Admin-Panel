import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:aura_kart_admin_panel/features/personalisation/controllers/user_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AHeader extends StatelessWidget implements PreferredSizeWidget {
  const AHeader({super.key, this.scaffoldKey});

  // Global Key to access the Scaffold state
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Container(
      decoration: BoxDecoration(
        color: AColors.white,
        border: Border(bottom: BorderSide(color: AColors.grey, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: ASizes.md, vertical: ASizes.sm),
      child: AppBar(
        // Menu Icon for Tablet & Mobile Screen
        leading: !ADeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu),
              )
            : null,

        // Search Bar (Only visible in Desktop)
        title: ADeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.search_normal_1),
                    hintText: 'Search anything...',
                  ),
                ),
              )
            : null,

        // Actions
        actions: [
          // Search Icon For Mobile & Tablet
          if (!ADeviceUtils.isDesktopScreen(context))
            IconButton(
                icon: const Icon(Iconsax.search_normal), onPressed: () {}),

          // Notification Icon
          IconButton(icon: const Icon(Iconsax.notification), onPressed: () {}),
          const SizedBox(width: ASizes.spaceBtwItems / 2),

          // User Data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image
              Obx(
                () => ARoundedImage(
                  width: 40,
                  padding: 2,
                  height: 40,
                  imageType: controller.user.value.profilePicture.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
                  image: controller.user.value.profilePicture.isNotEmpty
                      ? controller.user.value.profilePicture
                      : AImages.user,
                ),
              ),
              const SizedBox(width: ASizes.sm),

              // Name & Email
              if (!ADeviceUtils.isMobileScreen(context))
                Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.loading.value
                          ? const AShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.fullName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                      controller.loading.value
                          ? const AShimmerEffect(width: 50, height: 13)
                          : Text(
                              controller.user.value.email,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                    ],
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(ADeviceUtils.getAppBarHeight() + 15);
}
