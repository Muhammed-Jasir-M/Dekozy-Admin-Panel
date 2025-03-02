import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/routes/routes.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerOrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = OrderModel(
      id: 'id',
      status: OrderStatus.shipped,
      totalAmount: 234,
      shippingCost: 50,
      taxCost: 18,
      orderDate: DateTime.now(),
      items: [],
    );

    const totalAmount = '2453';

    // Safe context retrieval
    final context = Get.context;
    if (context == null) return const DataRow(cells: []);

    return DataRow2(
      selected: false,
      onTap: () => Get.toNamed(ARoutes.orderDetails, arguments: order),
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .apply(color: AColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text('${5} Items')),
        DataCell(
          ARoundedContainer(
            radius: ASizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
                vertical: ASizes.sm, horizontal: ASizes.md),
            backgroundColor: AHelperFunctions.getOrderStatusColor(order.status)
                .withValues(alpha: 0.1),
            child: Text(
              order.status.name.capitalizeFirst ?? '',
              style: TextStyle(
                  color: AHelperFunctions.getOrderStatusColor(order.status)),
            ),
          ),
        ),
        DataCell(Text('\u{20B9}$totalAmount')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
