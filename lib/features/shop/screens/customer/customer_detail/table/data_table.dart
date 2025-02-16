import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/customer_detail/table/table_source.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return APaginatedDataTable(
      minWidth: 500,
      tableHeight: 640,
      dataRowHeight: kMinInteractiveDimension,
      columns: [
        const DataColumn2(label: Text('Order ID')),
        const DataColumn2(label: Text('Date')),
        const DataColumn2(label: Text('Items')),
        DataColumn2(
          label: Text('Status'),
          fixedWidth: ADeviceUtils.isMobileScreen(context) ? 100 : null,
        ),
        const DataColumn2(label: Text('Amount'), numeric: true),
      ],
      source: CustomerOrderRows(),
    );
  }
}
