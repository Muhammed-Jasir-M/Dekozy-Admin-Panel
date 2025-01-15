import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/table/table_source.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DashboardOrderTable extends StatelessWidget {
  const DashboardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return APaginatedDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: ASizes.xl * 1.2,
      columns: [
        DataColumn2(label: Text('Order ID')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Items')),
        DataColumn2(label: Text('Status')),
        DataColumn2(label: Text('Amount')),
      ],
      source: OrderRows(),
    );
  }
}
