import 'package:aura_kart_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:aura_kart_admin_panel/data/repositories/order/order_repository.dart';
import 'package:aura_kart_admin_panel/features/authentication/models/user_model.dart';
import 'package:get/get.dart';

class CustomerController extends ABaseController<UserModel> {
  static CustomerController get instance => Get.find();

  final _customerRepository = Get.put(OrderRepository());

  @override
  Future<List<UserModel>> fetchItems() async {
    return await _customerRepository.getAllUsers();
  }

  void sortbyName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (UserModel o) => o.fullName.toString().toLowerCase());
  }

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await _customerRepository.deleteUser(item.id ?? '');
  }
}
