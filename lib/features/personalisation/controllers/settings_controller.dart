import 'package:aura_kart_admin_panel/data/repositories/settings/setting_repository.dart';
import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/features/personalisation/models/setting_model.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  /// Variable
  RxBool loading = false.obs;
  Rx<SettingsModel> settings = SettingsModel().obs;

  final formkey = GlobalKey<FormState>();

  final appNameController = TextEditingController();
  final taxController = TextEditingController();
  final shippingController = TextEditingController();
  final freeShippingThresholdController = TextEditingController();

  final settingsRepository = Get.put(SettingsRepository());

  @override
  void onInit() {
    // Fetch setting details on controller initialization
    fetchSettingDetails();
    super.onInit();
  }

  // Fetch settings details from the repository
  Future<SettingsModel> fetchSettingDetails() async {
    try {
      loading.value = true;
      final settings = await settingsRepository.getSettings();
      this.settings.value = settings;

      appNameController.text = settings.appName;
      taxController.text = settings.taxRate.toString();
      shippingController.text = settings.shippingCost.toString();
      freeShippingThresholdController.text =
          settings.freeShippingThreshold == null
              ? ''
              : settings.freeShippingThreshold.toString();

      loading.value = false;

      return settings;
    } catch (e) {
      ALoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return SettingsModel();
    }
  }

  // Pick Thumbnail mage from media
  void updateAppLogo() async {
    try {
      loading.value = true;

      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFromMedia();

      // Handle the selected images
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Set the selected image to main image or perform any other action
        ImageModel selectedImage = selectedImages.first;

        // Update profile in Firestore
        await settingsRepository
            .updateSingleField({'appLogo': selectedImage.url});

        // Update the main image using selectedImage
        settings.value.appLogo = selectedImage.url;
        settings.refresh();

        ALoaders.errorSnackBar(
            title: 'Congratulations', message: 'App Logo has been updated.');
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void updateSettingInformation() async {
    try {
      loading.value = true;

      // Check Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!formkey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }

      settings.value.appName = appNameController.text.trim();
      settings.value.taxRate =
          double.tryParse(taxController.text.trim()) ?? 0.0;
      settings.value.shippingCost =
          double.tryParse(shippingController.text.trim()) ?? 0.0;
      settings.value.freeShippingThreshold =
          double.tryParse(freeShippingThresholdController.text.trim()) ?? 0.0;

      await settingsRepository.updateSettingsDetails(settings.value);
      settings.refresh();

      loading.value = false;

      ALoaders.successSnackBar(
          title: 'Congratulations', message: 'App settings has been updated');
    } catch (e) {
      loading.value = false;
      ALoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
