import 'package:aura_kart_admin_panel/app.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:get/get.dart';

class AAppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: ARoutes.firstScreen, page: () => const FirstScreen()),
    GetPage(name: ARoutes.secondScreen, page: () => const SecondScreen()),
    GetPage(name: ARoutes.responsiveDesignScreen, page: () => const ResponsiveDesignScreen()),
  ];
}
