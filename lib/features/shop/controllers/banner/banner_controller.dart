import 'package:aura_kart_admin_panel/data/abstract/base_data_table_controlle.dart';
import 'package:aura_kart_admin_panel/data/repositories/banners/banner_repository.dart';
import 'package:aura_kart_admin_panel/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends ABaseController<BannerModel> {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannerRepository.deleteBanner(item.id ?? '');
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannerRepository.getAllBanners();
  }

  // method for formatting a route string
  String formatRoute(String route) {
    if (route.isEmpty) return '';

    // remove the loading '/'
    String formatted = route.substring(1);

    // capitalize the first character
    formatted = formatted[0].toUpperCase() + formatted.substring(1);

    return formatted;
  }

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }
}
