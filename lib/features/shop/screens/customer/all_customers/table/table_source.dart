import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/authentication/models/user_model.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/image_strings.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              const ARoundedImage(
                width: 50,
                height: 50,
                padding: ASizes.sm,
                image: AImages.applePay,
                imageType: ImageType.network,
                borderRadius: ASizes.borderRadiusMd,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              Expanded(
                child: Text(
                  'Nihal',
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: AColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const DataCell(Text('aurakart@gmail.com')),
        const DataCell(Text('+91 95862-58425')),
        DataCell(Text(DateTime.now().toString())),
        DataCell(
          ATableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(ARoutes.customerDetails,
                arguments: UserModel.empty()),
            onDeletePressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;
  
  @override
  int get selectedRowCount => 0;
}
