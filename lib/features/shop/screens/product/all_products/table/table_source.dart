import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/product/product_controller.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsRows extends DataTableSource {
  final controller = ProductController.instance;

  @override
  DataRow? getRow(int index) {
    final product = controller.filteredItems[index];

    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(ARoutes.editProduct, arguments: product),
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              ARoundedImage(
                width: 50,
                height: 50,
                padding: ASizes.xs,
                image: product.thumbnail,
                imageType: ImageType.network,
                borderRadius: ASizes.borderRadiusMd,
                backgroundColor: AColors.primaryBackground,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.title,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: AColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(controller.getProductStockTotal(product))),
        DataCell(Text(controller.getProductSoldQuantity(product))),
        DataCell(
          Row(
            children: [
              ARoundedImage(
                width: 35,
                height: 35,
                padding: ASizes.xs,
                image: product.brand != null
                    ? product.brand!.image
                    : AImages.defaultImage,
                imageType:
                    product.brand != null ? ImageType.network : ImageType.asset,
                borderRadius: ASizes.borderRadiusMd,
                backgroundColor: AColors.primaryBackground,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              Flexible(
                child: Text(
                  product.brand != null ? product.brand!.name : '',
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: AColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(Text('\u{20B9}${controller.getProductPrice(product)}')),
        DataCell(Text(product.formattedDate)),
        DataCell(
          ATableActionButtons(
            onEditPressed: () =>
                Get.toNamed(ARoutes.editProduct, arguments: product),
            onDeletePressed: () => controller.confrimAndDeleteItem(product),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount =>
      controller.selectedRows.where((selected) => selected).length;
}
