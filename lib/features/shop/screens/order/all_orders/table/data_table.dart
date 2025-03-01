import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/order/order_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/table/table_source.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Obx(
      () {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());
    
    // table
    return APaginatedDataTable(
      minWidth: 700,
      sortAscending: controller.sortAscending.value,
      sortColumnIndex: controller.sortColumnIndex.value,
      columns: [
        const DataColumn2(label: Text('Order ID')),
        DataColumn2(label: const Text('Date'), onSort: (columnIndex, ascending) => controller.sortByDate(columnIndex, ascending)),
        const DataColumn2(label: Text('Items')),
        DataColumn2(label: Text('Status'),fixedWidth: ADeviceUtils.isMobileScreen(context) ? 120 : null,),
        const DataColumn2(label: Text('Amount')),
        const DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: OrderRows(),
    );
    }
    );
  }
}
