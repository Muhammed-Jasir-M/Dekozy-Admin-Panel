import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password email
  sendPasswordResetEmail() async {
    try {
      /// Start Loader
      AFullScreenLoader.openLoadingDialog(
          'Processing Your Request', AImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// Send Reset Password Link to Email
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      /// Remove Loader
      AFullScreenLoader.stopLoading();

      /// Show Success Screen
      ALoaders.successSnackBar(
          title: 'Email Sent Succesfully',
          message: 'Email has been sent to Reset your password');

      /// Redirect
      Get.toNamed(
        ARoutes.resetPassword,
        parameters: {'email': email.text.trim()},
      );
    } catch (e) {
      /// Remove loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      /// Start Loader
      AFullScreenLoader.openLoadingDialog(
          'Processing Your Request', AImages.docerAnimation);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      /// Send Reset Password Link to Email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      /// Remove Loader
      AFullScreenLoader.stopLoading();

      /// Show Success Screen
      ALoaders.successSnackBar(
          title: 'Email Sent Successfully',
          message: 'Email has been sent to Reset your password');
    } catch (e) {
      /// Remove Loader
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
