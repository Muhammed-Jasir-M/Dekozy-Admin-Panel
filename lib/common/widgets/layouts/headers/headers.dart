import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/common/widgets/shimmers/shimmer.dart';
import 'package:aura_kart_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AHeader extends StatelessWidget implements PreferredSizeWidget {
  const AHeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Container(
      decoration: BoxDecoration(
          color: AColors.white,
          border: Border(bottom: BorderSide(color: AColors.grey, width: 1))),
      padding: const EdgeInsets.symmetric(
          horizontal: ASizes.md, vertical: ASizes.md),
      child: AppBar(
        // mobile
        leading: !ADeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu))
            : null,
        // search field
        title: ADeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.search_normal_1),
                      hintText: 'Search anything...'),
                ),
              )
            : null,

        //actions
        actions: [
          //search icon
          if (!ADeviceUtils.isDesktopScreen(context))
            IconButton(
                icon: const Icon(Iconsax.search_normal), onPressed: () {}),

          // notification icon
          IconButton(icon: const Icon(Iconsax.notification), onPressed: () {}),
          const SizedBox(width: ASizes.spaceBtwItems / 2),

          // user data
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Obx(
                 () =>  ARoundedImage(
                    width: 40,
                    Padding: 2,
                    height: 40,
                    imageType: controller.user.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                    image: controller.user.value.profilePicture.isNotEmpty ? controller.user.value.profilePicture : AImages.user),
               ),

              const SizedBox(width: ASizes.sm),

              //name and email
              if (!ADeviceUtils.isMobileScreen(context))
                Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.loading.value 
                      ? const AShimmerEffect(width: 50, height: 13)  
                      : Text(controller.user.value.fullName, style: Theme.of(context).textTheme.titleLarge),
                          controller.loading.value 
                      ? const AShimmerEffect(width: 50, height: 13)
                      : Text(controller.user.value.email, style: Theme.of(context).textTheme.labelMedium),
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
