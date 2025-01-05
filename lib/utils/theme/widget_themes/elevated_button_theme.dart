import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AElevatedButtonTheme {
  AElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.light,
      backgroundColor: AColors.primary,
      disabledForegroundColor: AColors.darkGrey,
      disabledBackgroundColor: AColors.buttonDisabled,
      side: const BorderSide(color: AColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ASizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
      textStyle: const TextStyle(fontSize: 16, color: AColors.textWhite, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.light,
      backgroundColor: AColors.primary,
      disabledForegroundColor: AColors.darkGrey,
      disabledBackgroundColor: AColors.darkerGrey,
      side: const BorderSide(color: AColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ASizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
      textStyle: const TextStyle(fontSize: 16, color: AColors.textWhite, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    ),
  );
}
