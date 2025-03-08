import 'package:aura_kart_admin_panel/features/media/controller/media_controller.dart';
import 'package:aura_kart_admin_panel/features/media/models/image_model.dart';
import 'package:aura_kart_admin_panel/features/personalisation/models/user_model.dart';
import 'package:aura_kart_admin_panel/data/repositories/user/user_repository.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:aura_kart_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // observation variables
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final formKey = GlobalKey<FormState>();
  final fisrtNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  // dependenciues
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  /// Fetch user details from the repository
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      ALoaders.errorSnackBar(
        title: 'oopsie doopsie !! Something went wrong.',
        message: e.toString(),
      );
      return UserModel.empty();
    }
  }

  // pick thumbnail image from media
  void updateProfilePicture() async {
    try {
      loading.value = true;
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImagesFromMedia();

      // handles the selected images
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // set the selected image to the main or perform any other ction
        ImageModel selectedImage = selectedImages.first;

        // update profile in firestore
        await userRepository
            .updateSingleField({'ProfilePicture': selectedImage.url});

        // update the main image using the slectedimage
        user.value.profilePicture = selectedImage.url;
        user.refresh();
        ALoaders.successSnackBar(
            title: 'Congratulatons',
            message: 'Your profile picture has beeen updated');
      }
      loading.value = false;
    } catch (e) {
      loading.value = false;
      ALoaders.errorSnackBar(title: 'Uh Oh', message: e.toString());
    }
  }

  void updateUserInformation() async {
    try {
      loading.value = true;

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!formKey.currentState!.validate()) {
        AFullScreenLoader.stopLoading();
        return;
      }
      user.value.firstName = fisrtNameController.text.trim();
      user.value.lastName = lastNameController.text.trim();
      user.value.phoneNumber = phoneController.text.trim();

      await userRepository.updateUserDetails(user.value);
      user.refresh();

      loading.value = false;
      ALoaders.successSnackBar(
          title: 'Congratulatons', message: 'Your profile has been updated');
    } catch (e) {
      loading.value = false;
      ALoaders.errorSnackBar(title: 'Uh Oh', message: e.toString());
    }
  }
}
