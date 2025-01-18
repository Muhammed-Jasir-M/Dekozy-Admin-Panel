import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/product_model.dart';

class ProductsRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              ARoundedImage(
                width: 50,
                height: 50,
                padding: ASizes.xs,
                image: AImages.applePay,
                imageType: ImageType.asset,
                borderRadius: ASizes.borderRadiusMd,
                backgroundColor: AColors.primaryBackground,
              ),
              const SizedBox(
                width: ASizes.spaceBtwItems,
              ),
              Flexible(
                child: Text(
                  'Product Title',
                  style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
                      color: AColors.primary, overflow: TextOverflow.ellipsis),
                ),
              )
            ],
          ),
        ),
        DataCell(Text('256')),
        // Brand
        DataCell(Row(
          children: [
            ARoundedImage(
              width: 35,
              height: 35,
              padding: ASizes.xs,
              image: AImages.applePay,
              imageType: ImageType.asset,
              borderRadius: ASizes.borderRadiusMd,
              backgroundColor: AColors.primaryBackground,
            ),
            const SizedBox(
              width: ASizes.spaceBtwItems,
            ),
            Flexible(
              child: Text(
                'Nike',
                style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(
                    color: AColors.primary, overflow: TextOverflow.ellipsis),
              ),
            )
          ],
        )),
        const DataCell(Text('\$99.9')),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          ATableActionButtons(
            onEditPressed: () => Get.toNamed(ARoutes.editProduct,
                arguments: ProductModel.empty()),
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 0;
}
