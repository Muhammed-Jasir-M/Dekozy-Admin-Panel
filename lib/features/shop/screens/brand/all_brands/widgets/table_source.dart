import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class BrandRows extends DataTableSource {
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
                padding: ASizes.sm,
                image: AImages.darkAppLogo,
                imageType: ImageType.asset,
                borderRadius: ASizes.borderRadiusMd,
                backgroundColor: AColors.primaryBackground,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              Expanded(
                child: Text(
                  'Adidas',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .bodyLarge!
                      .apply(color: AColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: ASizes.sm),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: ASizes.xs,
                direction: ADeviceUtils.isMobileScreen(Get.context!)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: ADeviceUtils.isMobileScreen(Get.context!)
                          ? 0
                          : ASizes.xs,
                    ),
                    child: const Chip(
                        label: Text('Shoes'),
                        padding: EdgeInsets.all(ASizes.xs)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: ADeviceUtils.isMobileScreen(Get.context!)
                          ? 0
                          : ASizes.xs,
                    ),
                    child: const Chip(
                        label: Text('TrackSuits'),
                        padding: EdgeInsets.all(ASizes.xs)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: ADeviceUtils.isMobileScreen(Get.context!)
                          ? 0
                          : ASizes.xs,
                    ),
                    child: const Chip(
                        label: Text('Joggers'),
                        padding: EdgeInsets.all(ASizes.xs)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const DataCell(Icon(Iconsax.heart5, color: AColors.primary)),
        DataCell(Text(DateTime.now().toString())),
        DataCell(ATableActionButtons(
          onEditPressed: () => Get.toNamed(ARoutes.editBrand, arguments: ''),
          onDeletePressed: () {},
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 20;

  @override
  int get selectedRowCount => 0;
}
