import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/data_table/paginated_data_table.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: controller.searchTextController,
                onChanged: (query) => controller.searchQuery(query),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Iconsax.search_normal),
                ),
              ),
              const SizedBox(height: ASizes.spaceBtwSections),
              Obx(
                () {
                  // Ordeers & Selected Rows are Hidden => Just to update the UI => Obx => [ProductRows]
                  Visibility(
                      visible: false,
                      child:
                          Text(controller.filteredDataList.length.toString()));

                  return APaginatedDataTable(
                    sortAscending: controller.sortAscending.value,
                    sortColumnIndex: controller.sortColumnIndex.value,
                    columns: [
                      DataColumn2(label: Text('Column 1')),
                      DataColumn(
                        label: Text('Column 2'),
                        onSort: (colIndex, ascending) =>
                            controller.sortById(colIndex, ascending),
                      ),
                      DataColumn(label: Text('Column 3')),
                      DataColumn(
                        label: Text('Column 4'),
                        onSort: (colIndex, ascending) =>
                            controller.sortById(colIndex, ascending),
                      ),
                    ],
                    source: MyData(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyData extends DataTableSource {
  final DashboardController controller = Get.put(DashboardController());

  @override
  DataRow? getRow(int index) {
    final data = controller.dataList[index];

    return DataRow2(
      onTap: () {
        print('Row ${index + 1} is Clicked');
      },
      selected: controller.selectedRows[index],
      onSelectChanged: (value) =>
          controller.selectedRows[index] = value ?? false,
      cells: [
        DataCell(Text(data['Column1'] ?? '')),
        DataCell(Text(data['Column2'] ?? '')),
        DataCell(Text(data['Column3'] ?? '')),
        DataCell(Text(data['Column4'] ?? '')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.dataList.length;

  @override
  int get selectedRowCount => 0;
}

class DashboardController extends GetxController {
  var dataList = <Map<String, String>>[].obs;
  var filteredDataList = <Map<String, String>>[].obs;

  RxList<bool> selectedRows =
      <bool>[].obs; // Observable list to store selected Rows
  RxInt sortColumnIndex =
      1.obs; // Observable for tracking the index of the column for sorting
  RxBool sortAscending =
      true.obs; // Observable for tracking the sorting order (asc or dsc)

  final searchTextController =
      TextEditingController(); // Controller for handling search text input

  @override
  void onInit() {
    super.onInit();
    fetchDummyData();
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredDataList.sort((a, b) {
      if (ascending) {
        return filteredDataList[0]['column1']
            .toString()
            .toLowerCase()
            .compareTo(filteredDataList[0]['column1'].toString().toLowerCase());
      } else {
        return filteredDataList[0]['column1']
            .toString()
            .toLowerCase()
            .compareTo(filteredDataList[0]['column1'].toString().toLowerCase());
      }
    });

    this.sortColumnIndex.value = sortColumnIndex;
  }

  void searchQuery(String query) {
    filteredDataList.assignAll(dataList
        .where((item) => item['column1']!.contains(query.toLowerCase())));
  }

  void fetchDummyData() {
    selectedRows.assignAll(
        List.generate(36, (index) => false)); // Initialize selected rows

    dataList.addAll(
      List.generate(
        36,
        (index) => {
          'Column1': 'Data ${index + 1} -1',
          'Column2': 'Data ${index + 1} -2',
          'Column3': 'Data ${index + 1} -3',
          'Column4': 'Data ${index + 1} -4',
        },
      ),
    );

    filteredDataList.addAll(
      List.generate(
        36,
        (index) => {
          'Column1': 'Data ${index + 1} -1',
          'Column2': 'Data ${index + 1} -2',
          'Column3': 'Data ${index + 1} -3',
          'Column4': 'Data ${index + 1} -4',
        },
      ),
    );
  }
}
