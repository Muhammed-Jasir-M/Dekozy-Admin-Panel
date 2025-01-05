import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AChipTheme {
  AChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: AColors.white,
    selectedColor: AColors.primary,
    disabledColor: AColors.grey.withValues(alpha: 0.4),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(color: AColors.black, fontFamily: 'Poppins'),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: AColors.white,
    selectedColor: AColors.primary,
    disabledColor: AColors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: AColors.white, fontFamily: 'Poppins'),
  );
}
