import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AHeader extends StatelessWidget implements PreferredSizeWidget {
  const AHeader({super.key, this.scaffoldKey});

  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
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
              const ARoundedImage(
                  width: 40,
                  Padding: 2,
                  height: 40,
                  imageType: ImageType.asset,
                  image: AImages.user),
              const SizedBox(width: ASizes.sm),

              //name and email
              if (!ADeviceUtils.isMobileScreen(context))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AURAKART',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text('support@aurakart.com',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
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
