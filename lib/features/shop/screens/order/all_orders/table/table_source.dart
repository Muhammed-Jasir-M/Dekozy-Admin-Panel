import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';

import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];

    return DataRow2(
        onTap: () => Get.toNamed(ARoutes.orderDetails, arguments: order),
        selected: false,
        onSelectChanged: (value) {},
        cells: [
          DataCell(
            Text(
              order.id,
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .apply(color: AColors.primary),
            ),
          ),
          DataCell(Text(order.formattedOrderDate)),
          DataCell(Text('${order.items!.length} Items')),
          DataCell(
            ARoundedContainer(
              radius: ASizes.cardRadiusSm,
              padding: EdgeInsets.symmetric(
                  vertical: ASizes.sm, horizontal: ASizes.md),
              backgroundColor:
                  AHelperFunctions.getOrderStatusColor(order.status)
                      .withValues(alpha: 0.1),
              child: Text(
                order.status.name.capitalize.toString(),
                style: TextStyle(
                    color: AHelperFunctions.getOrderStatusColor(order.status)),
              ),
            ),
          ),
          DataCell(Text('\u{20B9}${order.totalAmount}')),
          DataCell(ATableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(
              ARoutes.orderDetails,
              arguments: order,
              parameters: {'orderId': order.id},
            ),
            onDeletePressed: () {},
          ))
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
