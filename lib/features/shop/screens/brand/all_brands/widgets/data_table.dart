import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/brand/brand_controller.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'table_source.dart';

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());

    return Obx(() {
      Text(controller.filteredItems.length.toString());
      Text(controller.selectedRows.length.toString());

      final lgTable = controller.filteredItems.any((element) =>
          element.brandCategories != null &&
          element.brandCategories!.length > 2);

      return APaginatedDataTable(
        minWidth: 700,
        tableHeight: lgTable ? 96 * 11.5 : 760,
        dataRowHeight: lgTable ? 96 : 64,
        sortAscending: controller.sortAscending.value,
        sortColumnIndex: controller.sortColumnIndex.value,
        columns: [
          DataColumn2(
            label: const Text('Brand'),
            fixedWidth: ADeviceUtils.isMobileScreen(Get.context!) ? null : 200,
          ),
          const DataColumn2(label: Text('Categories')),
          DataColumn2(
            label: const Text('Featured'),
            fixedWidth: ADeviceUtils.isMobileScreen(Get.context!) ? null : 100,
          ),
          DataColumn2(
            label: const Text('Date'),
            fixedWidth: ADeviceUtils.isMobileScreen(Get.context!) ? null : 200,
          ),
          DataColumn2(
            label: const Text('Action'),
            fixedWidth: ADeviceUtils.isMobileScreen(Get.context!) ? null : 100,
          ),
        ],
        source: BrandRows(),
      );
    });
  }
}
