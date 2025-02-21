import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class BannersRows extends DataTableSource {
  final controller = BannerController.instance;

  @override
  DataRow? getRow(int index) {
    final banner = controller.filteredItems[index];

    return DataRow2(
      selected: controller.selectedRows[index],
      onTap: () => Get.toNamed(ARoutes.editBanner, arguments: banner),
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          ARoundedImage(
            width: 180,
            height: 100,
            padding: ASizes.sm,
            image: banner.imageUrl,
            imageType: ImageType.network,
            borderRadius: ASizes.borderRadiusMd,
            backgroundColor: AColors.primaryBackground,
          ),
        ),
        DataCell(Text(controller.formatRoute(banner.targetScreen))),
        DataCell(
          banner.active
              ? const Icon(Iconsax.eye, color: AColors.primary)
              : const Icon(Iconsax.eye_slash_copy),
        ),
        DataCell(
          ATableActionButtons(
            onEditPressed: () =>
                Get.toNamed(ARoutes.editBanner, arguments: banner),
            onDeletePressed: () => controller.confrimAndDeleteItem(banner),
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
