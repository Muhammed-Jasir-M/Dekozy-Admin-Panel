import 'package:aura_kart_admin_panel/features/authentication/screens/login/login.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:get/get.dart';

class AAppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: ARoutes.login, page: () => const LoginScreen()),
  ];
}
