import 'package:aura_kart_admin_panel/common/widgets/containers/circular_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:aura_kart_admin_panel/utils/helpers/helper_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../utils/constants/sizes.dart';

class AOrderStatusPieChart extends StatelessWidget {
  const AOrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;

    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ACircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withValues(alpha: 0.1),
                color: Colors.brown,
                size: ASizes.md,
              ),
              const SizedBox(width: ASizes.spaceBtwItems),
              Text('Order Status',
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(width: ASizes.spaceBtwSections),
          Obx(
            () => controller.orderStatusData.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius:
                            ADeviceUtils.isTabletScreen(context) ? 80 : 55,
                        startDegreeOffset: 180,
                        sections:
                            controller.orderStatusData.entries.map((entry) {
                          final status = entry.key;
                          final count = entry.value;

                          return PieChartSectionData(
                            showTitle: true,
                            title: count.toString(),
                            value: count.toDouble(),
                            radius:
                                ADeviceUtils.isTabletScreen(context) ? 80 : 100,
                            color: AHelperFunctions.getOrderStatusColor(status),
                            titleStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            // Handle touch events here if needed
                          },
                          enabled: true,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ALoaderAnimation()],
                    ),
                  ),
          ),

          // Show Status and Color Meta
          SizedBox(
            width: double.infinity,
            child: Obx(
              () => DataTable(
                columns: const [
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Orders')),
                  DataColumn(label: Text('Total'))
                ],
                rows: controller.orderStatusData.entries.map(
                  (entry) {
                    final OrderStatus status = entry.key;
                    final int count = entry.value;
                    final double totalAmount = controller.totalAmounts[status]!;
                    final String displayStatus =
                        controller.getOrderStatusName(status);

                    return DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              ACircularContainer(
                                width: 20,
                                height: 20,
                                backgroundColor:
                                    AHelperFunctions.getOrderStatusColor(
                                        status),
                              ),
                              Expanded(
                                child: Text(' $displayStatus)}'),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(count.toString())),
                        DataCell(
                            Text('\u{20B9}${totalAmount.toStringAsFixed(2)}')),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
