import 'package:aura_kart_admin_panel/data/repositories/authentication/authentication_repository.dart';
import 'package:aura_kart_admin_panel/data/repositories/settings/setting_repository.dart';
import 'package:aura_kart_admin_panel/data/repositories/user/user_repository.dart';
import 'package:aura_kart_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:aura_kart_admin_panel/features/personalisation/models/setting_model.dart';
import 'package:aura_kart_admin_panel/features/personalisation/models/user_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/text_strings.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormkey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  /// Email and Password Signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        AImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormkey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user using Email & Password Authentication
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //fetch user details and assign to usercontroller
      final user = await UserController.instance.fetchUserDetails();

      // Remove Loader
      AFullScreenLoader.stopLoading();

      // if user is not admin , logout and return
      if (user.role != AppRole.admin) {
        await AuthenticationRepository.instance.logout();
        ALoaders.errorSnackBar(
            title: 'Not Authorized',
            message: 'You are not authorized or have acces...contat admin');
      } else {
        // Redirect
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // handle registration of admin user
  Future<void> registerAdmin() async {
    try {
      AFullScreenLoader.openLoadingDialog(
          'Registering admin account', AImages.docerAnimation);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // register user using email & passsword
      await AuthenticationRepository.instance.registerWithEmailAndPassword(
          ATexts.adminEmail, ATexts.adminPassword);

      // create admin record in the firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'Aurakart',
          lastName: 'Admin',
          email: ATexts.adminEmail,
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ),
      );

      // create settings record in firestore
      final settingsRepository = Get.put(SettingsRepository());
      await SettingsRepository.registerSettings(SettingsModel(
          appLogo: '', appName: 'AuraKart', taxRate: 0, shippingCost: 0));

      // remove loader
      AFullScreenLoader.stopLoading();

      // redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AFullScreenLoader.stopLoading();
      ALoaders.errorSnackBar(title: 'Uh Oh', message: e.toString());
    }
  }

  /// Google Sign In Authentication
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      AFullScreenLoader.openLoadingDialog(
        'Logging you in...',
        AImages.docerAnimation,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Google authentication
      final userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredential);

      //Remove Loader
      AFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      AFullScreenLoader.stopLoading();

      ALoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
