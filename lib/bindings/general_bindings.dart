import 'package:aura_kart_admin_panel/features/authentication/controllers/user_controller.dart';
import 'package:aura_kart_admin_panel/utils/helpers/network_manager.dart';
import 'package:get/get.dart';


class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    /// -- core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);
  }
}
