import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class BrandRows extends DataTableSource {
  final controller = BrandController.instance;

  @override
  DataRow? getRow(int index) {
    final brand = controller.filteredItems[index];

    return DataRow2(
      selected: controller.selectedRows[index],
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      onTap: () => Get.toNamed(ARoutes.editBrand, arguments: brand),
      cells: [
        DataCell(
          Row(
            children: [
              ARoundedImage(
                width: 50,
                height: 50,
                padding: ASizes.sm,
                image: brand.image,
                imageType: ImageType.network,
                borderRadius: ASizes.borderRadiusMd,
                backgroundColor: AColors.primaryBackground,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              Expanded(
                child: Text(
                  brand.name,
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
                children: brand.brandCategories != null
                    ? brand.brandCategories!
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(
                              bottom: ADeviceUtils.isMobileScreen(Get.context!)
                                  ? 0
                                  : ASizes.xs,
                            ),
                            child: Chip(
                              label: Text(e.name),
                              padding: EdgeInsets.all(ASizes.xs),
                            ),
                          ),
                        )
                        .toList()
                    : [const SizedBox()],
              ),
            ),
          ),
        ),
        DataCell(
          brand.isFeatured
              ? const Icon(Iconsax.heart, color: AColors.primary)
              : const Icon(Iconsax.heart, color: AColors.grey),
        ),
        DataCell(Text(brand.createdAt != null ? brand.formattedDate : '')),
        DataCell(
          ATableActionButtons(
            onEditPressed: () =>
                Get.toNamed(ARoutes.editBrand, arguments: brand),
            onDeletePressed: () => controller.confrimAndDeleteItem(brand),
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
