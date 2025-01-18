import 'package:aura_kart_admin_panel/common/widgets/images/circular_image.dart';
import 'package:aura_kart_admin_panel/common/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
              ACircularImage(
                width: 100,
                height: 100,
                image: AImages.darkAppLogo,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: ASizes.spaceBtwSections),

              Padding(
                padding: EdgeInsets.all(ASizes.md),
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
