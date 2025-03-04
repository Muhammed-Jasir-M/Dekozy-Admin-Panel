import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/common/widgets/images/rounded_image.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;

  @override
  DataRow? getRow(int index) {
    final customer = controller.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(ARoutes.customerDetails,
          arguments: customer, parameters: {'customerId': customer.id ?? ''}),
      selected: controller.selectedRows[index],
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(
          Row(
            children: [
              ARoundedImage(
                width: 50,
                height: 50,
                padding: ASizes.sm,
                image: customer.profilePicture,
                imageType: ImageType.network,
                borderRadius: ASizes.borderRadiusMd,
                backgroundColor: AColors.primaryBackground,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              Expanded(
                child: Text(
                  customer.fullName,
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
        DataCell(Text(customer.email)),
        DataCell(Text(customer.phoneNumber)),
        DataCell(
            Text(customer.createdAt == null ? '' : customer.formattedDate)),
        DataCell(
          ATableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(ARoutes.customerDetails,
                arguments: customer,
                parameters: {'customerId': customer.id ?? ''}),
            onDeletePressed: () => controller.confrimAndDeleteItem(customer),
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
