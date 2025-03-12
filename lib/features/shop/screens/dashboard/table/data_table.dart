import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/order/order_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/table/table_source.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      return APaginatedDataTable(
        minWidth: 700,
        tableHeight: 500,
        dataRowHeight: ASizes.xl * 1.2,
        columns: [
          DataColumn2(label: const Text('Order ID'), onSort: (columnIndex, ascending) => controller.sortById(columnIndex,ascending)),
          const DataColumn2(label: Text('Date')),
          const DataColumn2(label: Text('Items')),
          DataColumn2(label: const Text('Status') , fixedWidth: ADeviceUtils.isMobileScreen(context) ? 120 : null),
          DataColumn2(label: Text('Amount')),
        ],
        source: OrderRows(),
      );
    });
  }
}
