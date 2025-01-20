import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
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
    return DataRow2(cells: [
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
      const DataCell(
        Text('5 Items'),
      ),
      DataCell(ARoundedContainer(
        radius: ASizes.cardRadiusSm,
        padding:
            EdgeInsets.symmetric(vertical: ASizes.xs, horizontal: ASizes.md),
        backgroundColor:
            AHelperFunctions.getOrderStatusColor(order.status).withValues(alpha: 0.1),
        child: Text(
          order.status.name.capitalize.toString(),
          style: TextStyle(
              color: AHelperFunctions.getOrderStatusColor(order.status)),
        ),
      )),
      DataCell(Text('\$${order.totalAmount}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
