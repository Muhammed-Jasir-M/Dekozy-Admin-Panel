import 'package:aura_kart_admin_panel/features/media/screens/media.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/profile/profile.dart';
import 'package:aura_kart_admin_panel/features/personalisation/screens/settings/settings.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/all_brands/brands.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/brand/edit_brand/edit_brand.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/create_categories/create_category.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/category/edit_categories/edit_catogory.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/all_customers/customers.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/customer.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/dashboard.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/forget_password/forget_password.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/login/login.dart';
import 'package:aura_kart_admin_panel/features/authentication/screens/reset_password/reset_password.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/all_orders/orders.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/order/orders_detail/order_detail.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/all_products/widgets/products.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/create_product/create_product.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/edit_product/edit_product.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/routes/routes_middleware.dart';
import 'package:get/get.dart';

import '../features/shop/screens/banner/all_banners/banners.dart';
import '../features/shop/screens/banner/create_banner/create_banner.dart';
import '../features/shop/screens/banner/edit_banner/edit_banner.dart';
import '../features/shop/screens/brand/create_brand/create_brand.dart';
import '../features/shop/screens/category/all_categories/widgets/categories.dart';

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

    // Categories
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

    // Brands
    GetPage(
        name: ARoutes.brands,
        page: () => const BrandsScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.createBrand,
        page: () => const CreateBrandScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.editBrand,
        page: () => const EditBrandScreen(),
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

    // Products
    GetPage(
        name: ARoutes.products,
        page: () => const ProductsScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.createProduct,
        page: () => const CreateProductScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.editProduct,
        page: () => const EditProductScreen(),
        middlewares: [ARoutesMiddleware()]),

    // Customers
    GetPage(
        name: ARoutes.customers,
        page: () => const CustomersScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.customerDetails,
        page: () => const CustomerDetailScreen(),
        middlewares: [ARoutesMiddleware()]),

    // Settings
    GetPage(
        name: ARoutes.settings,
        page: () => const SettingsScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.profile,
        page: () => const ProfileScreen(),
        middlewares: [ARoutesMiddleware()]),
        
    //Orders
    GetPage(
        name: ARoutes.orders,
        page: () => const OrdersScreen(),
        middlewares: [ARoutesMiddleware()]),
    GetPage(
        name: ARoutes.orderDetails,
        page: () => const OrderDetailScreen(),
        middlewares: [ARoutesMiddleware()]),
  ];
}
