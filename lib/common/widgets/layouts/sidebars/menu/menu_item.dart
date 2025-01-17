 import 'package:aura_kart_admin_panel/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AMenuItem extends StatelessWidget {
  const AMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });

  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());

    return InkWell(
      onTap: () => menuController.menuOnTap(route),
      onHover: (hovering) => hovering
          ? menuController.changeHoverItems(route)
          : menuController.changeHoverItems(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: ASizes.xs),
          child: Container(
            decoration: BoxDecoration(
              color: menuController.isHovering(route) ||
                      menuController.isActive(route)
                  ? AColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(ASizes.cardRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Padding(
                  padding: EdgeInsets.only(
                    left: ASizes.lg,
                    top: ASizes.md,
                    bottom: ASizes.md,
                    right: ASizes.md,
                  ),
                  child: menuController.isActive(route)
                      ? Icon(icon, size: 22, color: AColors.white)
                      : Icon(
                          icon,
                          size: 22,
                          color: menuController.isHovering(route)
                              ? AColors.white
                              : AColors.darkGrey,
                        ),
                ),

                // Text
                if (menuController.isHovering(route) ||
                    menuController.isActive(route))
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: AColors.white),
                    ),
                  )
                else
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: AColors.darkGrey),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
