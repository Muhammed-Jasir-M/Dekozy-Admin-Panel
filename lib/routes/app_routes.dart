import 'package:aura_kart_admin_panel/features/media/screens/media.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/dashboard.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/forget_password/forget_password.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/login/login.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/reset_password/reset_password.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/routes/routes_middleware.dart';
import 'package:get/get.dart';

class AAppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: ARoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: ARoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(
        name: ARoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
      name: ARoutes.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [ARoutesMiddleware()],
    ),
    GetPage(
        name: ARoutes.media,
        page: () => const MediaScreen(),
        middlewares: [ARoutesMiddleware()]),
  ];
}
