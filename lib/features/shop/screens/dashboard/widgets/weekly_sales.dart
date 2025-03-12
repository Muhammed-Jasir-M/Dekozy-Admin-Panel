import 'package:aura_kart_admin_panel/common/widgets/containers/circular_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/common/widgets/icons/circular_icon.dart';
import 'package:aura_kart_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AWeekklySaleGraph extends StatelessWidget {
  const AWeekklySaleGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return ARoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ACircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withOpacity(0.1),
                color: Colors.brown,
                size: ASizes.md,
              )
            
          const SizedBox(width: ASizes.spaceBtwItems),
          Text('Weekly Sales',style: Theme.of(context).textTheme.headlineSmall),
          ],
          ),
          const SizedBox(height: ASizes.spaceBtwSections),

          // Graph
          Obx(
            () => controller.weeklySales.isNotEmpty ?
             SizedBox(
              height: 400,
              child: BarChart(
                BarChartData(
                  titlesData: buildFlTitleData(controller.weeklySales),
                  borderData: FlBorderData(show: true,border: const Border(top: BorderSide.none, right: BorderSide.none),),
                  gridData: const FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval: 200,
                  ),
                  barGroups: controller.weeklySales
                      .asMap()
                      .entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              width: 30,
                              toY: entry.value,
                              color: AColors.primary,
                              borderRadius: BorderRadius.circular(ASizes.sm),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  groupsSpace: ASizes.spaceBtwItems,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(getTooltipColor: (_) => AColors.secondary,),
                    touchCallback: ADeviceUtils.isDesktopScreen(context)? (barTouchEvent, barTouchResponse) {} : null,
                  ),
                ),
              ),
            ) 
            : const SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [ALoaderAnimation()])),
          ),
        ],
      ),
    );
  }

  FlTitlesData buildFlTitleData(List<double> weeklySales) {
    // calculate step height fot the left ricing
    double maxOrder = weeklySales.reduce((a, b) => a > b ? a : b).toDouble();
    double stepHeight = (maxOrder / 10).ceilToDouble();

    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            // Map index to desired day of week
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

            // Calculate the index and ensure it wraps around for the correct day
            final index = value.toInt() % days.length;

            // Get the day corresponding to the calculated index
            final day = days[index];

            return SideTitleWidget(
              space: 0,
              axisSide: AxisSide.bottom,
              child: Text(day),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,interval: stepHeight <= 0 ? 500 : stepHeight ,reservedSize: 50,),),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
