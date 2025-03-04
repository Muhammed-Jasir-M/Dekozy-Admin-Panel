import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/all_customers/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      // table
      return APaginatedDataTable(
        minWidth: 700,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(
              label: const Text('Customer'),
              onSort: (columnIndex, ascending) =>
                  controller.sortbyName(columnIndex, ascending)),
          const DataColumn2(label: Text('Email')),
          const DataColumn2(label: Text('Phone Number')),
          const DataColumn2(label: Text('Registered')),
          const DataColumn2(label: Text('Action'), fixedWidth: 100),
        ],
        source: CustomerRows(),
      );
    });
  }
}
