import 'package:aura_kart_admin_panel/common/widgets/containers/circular_container.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/dashboard_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';

class AOrderStatusPieChart extends StatelessWidget {
  const AOrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Orders Status', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: ASizes.spaceBtwSections),

        // Graph
        SizedBox(
          height: 400,
          child: PieChart(
            PieChartData(
              sections: controller.orderStatusData.entries.map((entry) {
                final status = entry.key;
                final count = entry.value;

                return PieChartSectionData(
                  title: count.toString(),
                  value: count.toDouble(),
                  radius: 100,
                  color: AHelperFunctions.getOrderStatusColor(status),
                  titleStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  // Handle touch events here if needed
                },
                enabled: true,
              ),
            ),
          ),
        ),

        // Show Status and Color Meta
        SizedBox(
          width: double.infinity,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Orders')),
              DataColumn(label: Text('Total'))
            ],
            rows: controller.orderStatusData.entries.map((entry) {
              final OrderStatus status = entry.key;
              final int count = entry.value;
              final totalAmount = controller.totalAmounts[status] ?? 0;
          
              return DataRow(
                cells: [
                  DataCell(
                    Row(
                      children: [
                        ACircularContainer(
                          width: 20,
                          height: 20,
                          backgroundColor:
                              AHelperFunctions.getOrderStatusColor(status),
                        ),
                        Expanded(child: Text(' ${controller.getOrderStatusName(status)}')),
                      ],
                    ),
                  ),
                  DataCell(Text(count.toString())),
                  DataCell(Text('\u{20B9} ${totalAmount.toStringAsFixed(2)}')),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
