import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/customer/all_customers/table/table_source.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return APaginatedDataTable(
      minWidth: 700,
      columns: const [
        DataColumn2(label: Text('Customer')),
        DataColumn2(label: Text('Email')),
        DataColumn2(label: Text('Phone Number')),
        DataColumn2(label: Text('Registered')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: CustomerRows(),
    );
  }
}
