class ARoutes {
  static const login = '/login';
  static const forgetPassword = '/fogot-password/';
  static const resetPassword = '/reset-password';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brands = '/brand';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const products = '/products';
  static const createProduct = '/createProducts';
  static const editProduct = '/editProduct';

  static const customers = '/customers';
  static const createCustomer = '/createCustomer';
  static const customerDetails = '/customerDetails';

  static const orders = '/orders';
  static const orderDetails = '/orderDetails';

  static const coupons = '/coupons';
  static const settings = '/settings';
  static const profile = '/profile';

  static List sidebarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    products,
    customers, 
    orders,
  ];
}
