import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: PaginatedDataTable2(
              columnSpacing: 12,
              minWidth: 786,
              dividerThickness: 0,
              horizontalMargin: 12,
              dataRowHeight: 56,
              rowsPerPage: 12,
              headingTextStyle: Theme.of(context).textTheme.titleMedium,
              headingRowColor: WidgetStateProperty.resolveWith((states)=> AColors.primaryBackground),
              headingRowDecoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ASizes.borderRadiusMd),
                  topRight: Radius.circular(ASizes.borderRadiusMd), 
                ),
              ),
            showCheckboxColumn: true,
              columns: const [
                DataColumn2(label: Text('Column 1')),
                DataColumn(label: Text('Column 2')),
                DataColumn(label: Text('Column 3')),
                DataColumn(label: Text('Column 4')),
              ],
             source: MyData(),
        ),
      ),
    ),
    );
  }
}
class MyData extends DataTableSource{
  final DashboardController controller =Get.put(DashboardController());

  @override
  DataRow? getRow(int index) {
    final data = controller.dataList[index];

   return DataRow2(cells: [
    DataCell(Text(data['Column1'] ?? '')),
    DataCell(Text(data['Column2'] ?? '')),
    DataCell(Text(data['Column3'] ?? '')),
    DataCell(Text(data['Column4'] ?? '')),
   ]);
  }

  @override 
  bool get isRowCountApproximate => false;

  @override 
  int get rowCount =>controller.dataList.length;

  @override
  int get selectedRowCount => 0;

}
class DashboardController extends GetxController{
  var dataList = <Map<String,String>>[].obs;

  @override
  void onInit(){
    super.onInit();
    fetchDummyData();
  }
  
  void fetchDummyData() {
    dataList.addAll(List.generate(36,
    (index)=>{
      'Column1': 'Data ${index + 1} -1',
      'Column2': 'Data ${index + 1} -2',
      'Column3': 'Data ${index + 1} -3',
      'Column4': 'Data ${index + 1} -4',
    }));
  }
}