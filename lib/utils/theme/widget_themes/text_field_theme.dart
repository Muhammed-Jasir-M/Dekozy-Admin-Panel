import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ATextFormFieldTheme {
  ATextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AColors.darkGrey,
    suffixIconColor: AColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: ASizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: ASizes.fontSizeMd, color: AColors.textPrimary, fontFamily: 'Poppins'),
    hintStyle: const TextStyle().copyWith(fontSize: ASizes.fontSizeSm, color: AColors.textSecondary, fontFamily: 'Poppins'),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal, fontFamily: 'Poppins'),
    floatingLabelStyle: const TextStyle().copyWith(color: AColors.textSecondary, fontFamily: 'Poppins'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.borderPrimary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.borderPrimary),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.borderSecondary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AColors.error),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: AColors.darkGrey,
    suffixIconColor: AColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: ASizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: ASizes.fontSizeMd, color: AColors.white, fontFamily: 'Poppins'),
    hintStyle: const TextStyle().copyWith(fontSize: ASizes.fontSizeSm, color: AColors.white, fontFamily: 'Poppins'),
    floatingLabelStyle: const TextStyle().copyWith(color: AColors.white.withValues(alpha: 0.8), fontFamily: 'Poppins'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(ASizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AColors.error),
    ),
  );
}
