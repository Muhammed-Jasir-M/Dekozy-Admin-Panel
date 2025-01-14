import 'package:flutter/material.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: DataTable(

            columns: const [
            DataColumn(label: Text('Column 1')),
            DataColumn(label: Text('Column 2')),
            ], 
            rows: const [
              DataRow(cells: [
                DataCell(Text('Cell 1')),
                DataCell(Text('Cell 2')),
               ]),
              DataRow(cells: [
                DataCell(Text('Cell 3')),
                DataCell(Text('Cell 4')),
               ]),
            ] 
            ),
          ),
        ),
    );
  }
}
