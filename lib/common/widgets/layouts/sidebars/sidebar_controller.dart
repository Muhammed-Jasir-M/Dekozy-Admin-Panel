import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:get/get.dart';
 
import '../../../../data/repositories/authentication/authentication_repository.dart';

class SidebarController extends GetxController {
  final activeItem = ARoutes.dashboard.obs;
  final hoverItem = ''.obs;

  void changeActiveItems(String route) => activeItem.value = route;

  void changeHoverItems(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) async {
    if (!isActive(route)) {
      changeActiveItems(route);

      if (ADeviceUtils.isMobileScreen(Get.context!)) Get.back();

      if (route == 'logout') {
        await AuthenticationRepository.instance.logout();
      } else {
        Get.toNamed(route);
      }
    }
  }
}
