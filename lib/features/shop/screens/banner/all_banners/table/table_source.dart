import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../models/banner_model.dart';

class BannersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
      cells: [
        DataCell(
          ARoundedImage(
            width: 180,
            height: 100,
            padding: ASizes.sm,
            image: AImages.darkAppLogo,
            imageType: ImageType.asset,
            borderRadius: ASizes.borderRadiusMd,
            backgroundColor: AColors.primaryBackground,
          ),
        ),
        DataCell(Text('Shop')),
        DataCell(Icon(Iconsax.eye, color: AColors.primary)),
        DataCell(
          ATableActionButtons(
            onEditPressed: () => Get.toNamed(
              ARoutes.editBanner,
              arguments:
                  BannerModel(imageUrl: '', targetScreen: '', active: false),
            ),
            onDeletePressed: (){},
          ),
        )
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
