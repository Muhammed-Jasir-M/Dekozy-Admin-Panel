import 'package:aura_kart_admin_panel/common/widgets/data_table/paginated_data_table.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/product/all_products/table/table_source.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ProductsTable extends StatelessWidget {
  const ProductsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return APaginatedDataTable(
      minWidth: 1000,
      columns: [
        DataColumn2(
          label: Text('Product'),
          fixedWidth: !ADeviceUtils.isDesktopScreen(context) ? 300 : 400,
        ),
        DataColumn2(label: Text('Stock')),
        DataColumn2(label: Text('Brand')),
        DataColumn2(label: Text('Price')),
        DataColumn2(label: Text('Date')),
        DataColumn2(label: Text('Action'), fixedWidth: 100),
      ],
      source: ProductsRows(),
    );
  }
}
