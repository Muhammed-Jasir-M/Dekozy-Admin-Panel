import 'package:aura_kart_admin_panel/common/widgets/images/circular_image.dart';
import 'package:aura_kart_admin_panel/common/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:aura_kart_admin_panel/features/personalisation/controllers/settings_controller.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ASidebar extends StatelessWidget {
  const ASidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: AColors.white,
          border: Border(right: BorderSide(color: AColors.grey, width: 1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image
               Row(
                children: [
                  Obx(
                  () => ACircularImage(
                  width: 60,
                 height: 60,
                 padding: 0,
                 margin: ASizes.sm,
                 backgroundColor: Colors.transparent,
                 imageType: SettingsController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                 image: SettingsController.instance.settings.value.appLogo.isNotEmpty
                 ? SettingsController.instance.settings.value.appLogo
                 : AImages.darkAppLogo,
                 ),
                 ),

                 Expanded(
                  child: Obx(
                    () => Text(
                      SettingsController.instance.settings.value.appName,
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ),
                    ),
                ],
               ),

               
               SizedBox(height: ASizes.spaceBtwSections),

              Padding(
                padding: const EdgeInsets.all(ASizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MENU',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),






                    const SizedBox(height: ASizes.sm),

                    // Menu Items
                    const AMenuItem(
                      route: ARoutes.dashboard,
                      icon: Iconsax.status,
                      itemName: 'Dashboard',
                    ),
                    const AMenuItem(
                      route: ARoutes.media,
                      icon: Iconsax.image,
                      itemName: 'Media',
                    ),
                    const AMenuItem(
                      route: ARoutes.categories,
                      icon: Iconsax.category_2,
                      itemName: 'Catogories',
                    ),
                    const AMenuItem(
                      route: ARoutes.brands,
                      icon: Iconsax.dcube,
                      itemName: 'Brands',
                    ),
                    const AMenuItem(
                      route: ARoutes.banners,
                      icon: Iconsax.picture_frame,
                      itemName: 'Banners',
                    ),
                    const AMenuItem(
                      route: ARoutes.products,
                      icon: Iconsax.shopping_bag,
                      itemName: 'Products',
                    ),
                    const AMenuItem(
                      route: ARoutes.customers,
                      icon: Iconsax.profile_2user,
                      itemName: 'Customers',
                    ),
                    const AMenuItem(
                      route: ARoutes.orders,
                      icon: Iconsax.box,
                      itemName: 'Orders',
                    ),
                    const SizedBox(height: ASizes.sm),

                    // Other Menu Items
                    Text(
                      'OTHERS',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),
                    const SizedBox(height: ASizes.sm),

                    const AMenuItem(
                      route: ARoutes.profile,
                      icon: Iconsax.user,
                      itemName: 'Profile',
                    ),
                    const AMenuItem(
                      route: ARoutes.settings,
                      icon: Iconsax.setting,
                      itemName: 'Settings',
                    ),

                    const AMenuItem(
                      route: 'logout',
                      icon: Iconsax.logout,
                      itemName: 'Logout',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
