import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/theme/widget_themes/appbar_theme.dart';
import 'package:aura_kart_admin_panel/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:aura_kart_admin_panel/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:aura_kart_admin_panel/utils/theme/widget_themes/chip_theme.dart';
import 'package:aura_kart_admin_panel/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:aura_kart_admin_panel/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:aura_kart_admin_panel/utils/theme/widget_themes/text_field_theme.dart';
import 'package:aura_kart_admin_panel/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AAppTheme {
  AAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AColors.grey,
    brightness: Brightness.light,
    primaryColor: AColors.primary,
    textTheme: ATextTheme.lightTextTheme,
    chipTheme: AChipTheme.lightChipTheme,
    appBarTheme: AAppBarTheme.lightAppBarTheme,
    checkboxTheme: ACheckboxTheme.lightCheckboxTheme,
    scaffoldBackgroundColor: AColors.primaryBackground,
    bottomSheetTheme: ABottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: AOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: ATextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: AColors.grey,
    brightness: Brightness.dark,
    primaryColor: AColors.primary,
    textTheme: ATextTheme.darkTextTheme,
    chipTheme: AChipTheme.darkChipTheme,
    appBarTheme: AAppBarTheme.darkAppBarTheme,
    checkboxTheme: ACheckboxTheme.darkCheckboxTheme,
    scaffoldBackgroundColor: AColors.primary.withValues(alpha: 0.1),
    bottomSheetTheme: ABottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: AOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: ATextFormFieldTheme.darkInputDecorationTheme,
  );
}
