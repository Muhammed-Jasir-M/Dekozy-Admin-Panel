import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/table/table_source.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return APaginatedDataTable(
      minWidth: 700,
      columns: [
        DataColumn2(label: Text('Order ID')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Items')),
        DataColumn2(
          label: Text('Status'),
          fixedWidth: ADeviceUtils.isMobileScreen(context) ? 120 : null,
        ),
        DataColumn2(label: Text('Amount')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: OrderRows(),
    );
  }
}
