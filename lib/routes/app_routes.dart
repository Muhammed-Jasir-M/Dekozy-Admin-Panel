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

import '../features/shop/screens/banner/all_banners/banners.dart';
import '../features/shop/screens/banner/create_banner/create_banner.dart';
import '../features/shop/screens/banner/edit_banner/edit_banner.dart';

class AAppRoutes {
  static final List<GetPage> pages = [
    // Login
    GetPage(name: ARoutes.login, page: () => const LoginScreen()),
    // ForgetPassword
    GetPage(
        name: ARoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    // ResetPassword
    GetPage(
        name: ARoutes.resetPassword, page: () => const ResetPasswordScreen()),

    // Dashboard
    GetPage(
        name: ARoutes.dashboard,
        page: () => const DashboardScreen(),
        middlewares: [ARoutesMiddleware()]),

    // Media
    GetPage(
        name: ARoutes.media,
        page: () => const MediaScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(name: ARoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: ARoutes.resetPassword, page: () => const ResetPasswordScreen()),
        
    GetPage(name: ARoutes.dashboard,page: () => const DashboardScreen(),middlewares: [ARoutesMiddleware()]),
    GetPage(name: ARoutes.media,page: () => const MediaScreen(),middlewares: [ARoutesMiddleware()]),

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

    // Banners
    GetPage(
        name: ARoutes.banners,
        page: () => const BannersScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.createBanner,
        page: () => const CreateBannerScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.editBanner,
        page: () => const EditBannerScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(name: ARoutes.banners,page: () => const DashboardScreen(),middlewares: [ARoutesMiddleware()]),
    GetPage(name: ARoutes.createBanner,page: () => const DashboardScreen(),middlewares: [ARoutesMiddleware()]),
    GetPage(name: ARoutes.editBanner,page: () => const MediaScreen(),middlewares: [ARoutesMiddleware()]),
  ];
}
