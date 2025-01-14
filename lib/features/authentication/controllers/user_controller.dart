import 'package:aura_kart_admin_panel/data/repositories/user/user_repository.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:web/web.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  ///Fetch user details from the repository
  Future<UserModel> fetchUserDetails() async {
    try {
      final users = await userRepository.fetchAdminDetails();
      return users;
    } catch (e) {
      ALoaders.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }
}
