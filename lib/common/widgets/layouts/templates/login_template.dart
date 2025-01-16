import 'package:aura_kart_admin_panel/common/styles/spacing_styles.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class ALoginTemplate extends StatelessWidget {
  const ALoginTemplate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = AHelperFunctions.isDarkMode(context);

    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: ASpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ASizes.cardRadiusLg),
              color: isDark ? AColors.black : Colors.white,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
