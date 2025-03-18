import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'table_source.dart';

class BannersTable extends StatelessWidget {
  const BannersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(
      () {
        Text(controller.filteredItems.length.toString());
        Text(controller.selectedRows.length.toString());

        // Table
        return APaginatedDataTable(
          minWidth: 700,
          tableHeight: 900,
          dataRowHeight: 110,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: Text('Banner')),
            DataColumn2(label: Text('Redirect Screen')),
            DataColumn2(label: Text('Active')),
            DataColumn2(label: Text('Action'), fixedWidth: 100),
          ],
          source: BannerRows(),
        );
      },
    );
  }
}
