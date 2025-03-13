import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/icons/circular_icon.dart';
import 'package:aura_kart_admin_panel/common/widgets/texts/section_heading.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ADashboardCard extends StatelessWidget {
  const ADashboardCard({
    super.key,
    required this.title,
    required this.subTitle,
    this.icon = Iconsax.arrow_up_3,
    this.color = AColors.success,
    required this.stats,
    this.onTap,
    required this.headingIcon,
    required this.headingIconColor,
    required this.headingIconBgColor,
    required this.context,
  });

  final String title, subTitle;
  final BuildContext context;
  final IconData icon, headingIcon;
  final Color color, headingIconColor, headingIconBgColor;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ARoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(ASizes.lg),
      child: Column(
        children: [
          /// Heading
          Row(
            children: [
              ACircularIcon(
                icon: headingIcon,
                backgroundColor: headingIconBgColor,
                color: headingIconColor,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              ASectionHeading(title: title, textColor: AColors.textSecondary),
            ],
          ),
          const SizedBox(height: ASizes.spaceBtwSections),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subTitle, style: Theme.of(context).textTheme.headlineMedium),

              /// Right Side Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// Indicator
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(icon, color: color, size: ASizes.iconSm),
                        Text(
                          '$stats%',
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                                color: color,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 135,
                    child: Text(
                      'Compared to Dec 2023',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
