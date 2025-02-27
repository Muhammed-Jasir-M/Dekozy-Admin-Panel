import 'package:aura_kart_admin_panel/features/shop/controllers/product/edit_product_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/edit_product/responsive_screens/edit_product_desktop.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/edit_product/responsive_screens/edit_product_mobile.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/edit_product/responsive_screens/edit_product_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProductController());
    final product = Get.arguments;
    controller.initProductData(product);
    
    return ASiteTemplate(
      desktop: EditProductDesktopScreen(product: product),
      tablet: EditProductTabletScreen(product: product),
      mobile: EditProductMobileScreen(product: product),
    );
  }
}
