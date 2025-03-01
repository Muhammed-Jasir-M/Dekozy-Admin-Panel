import 'package:aura_kart_admin_panel/data/repositories/user/user_repository.dart';
import 'package:aura_kart_admin_panel/features/authentication/models/user_model.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/utils/popups/loaders.dart';
import 'package:get/get.dart';

class OrderDetailController extends GetxController {
  static OrderDetailController get instance => Get.find();

  RxBool loading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  // load customer orders
  Future<void> getCUstomerOfCurrentOrder() async {
    try {
      // show loader while loading categories
      loading.value = true;

      // fetvh customer ordesr and address
      final user = await UserRepository.instance.fetchUserDetails(order.value.userId);
      
      customer.value = user;
    } catch (e) {
      ALoaders.errorSnackBar(title: 'Uh Oh!!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}
  