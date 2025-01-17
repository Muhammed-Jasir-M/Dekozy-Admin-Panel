import 'package:aura_kart_admin_panel/features/media/screens/media.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/all_categories/categories.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/create_categories/create_category.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/edit_categories/edit_catogory.dart';
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
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.media,
        page: () => const MediaScreen(),
        middlewares: [ARoutesMiddleware()]),
    //Categories
    GetPage(
        name: ARoutes.categories,
        page: () => const CategoriesScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.createCategory,
        page: () => const CreateCategoryScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.editCategory,
        page: () => const EditCategoryScreen(),
        middlewares: [ARoutesMiddleware()]),
  ];
}
