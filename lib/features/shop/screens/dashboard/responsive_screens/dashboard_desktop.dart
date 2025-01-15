import 'package:aura_kart_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:aura_kart_admin_panel/features/shop/controllers_dashboard/dashboard_controller.dart';
import 'package:aura_kart_admin_panel/features/shop/screens/dashboard/responsive_screens/widgets/dashboard_card.dart';
import 'package:aura_kart_admin_panel/utils/constants/colors.dart';
import 'package:aura_kart_admin_panel/utils/constants/sizes.dart';
import 'package:aura_kart_admin_panel/utils/device/device_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final crontroller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Headin
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: ASizes.spaceBtwSections),

              //Cards
              const Row(
                children: [
                  Expanded(
                    child: ADashboardCard(
                        title: 'Sales Total', subTitle: '\$365', stats: 25),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                        title: 'Average order value',
                        subTitle: '\$25',
                        stats: 15),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                        title: 'Total Orders', subTitle: '36', stats: 44),
                  ),
                  SizedBox(width: ASizes.spaceBtwItems),
                  Expanded(
                    child: ADashboardCard(
                        title: 'Visitors', subTitle: '25353', stats: 3),
                  ),
                ],
              ),

              const SizedBox(height: ASizes.spaceBtwSections),

              ///Graphs
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// bar graph
                        ARoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Weekly Sales',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(height: ASizes.spaceBtwSections),

                              //graph
                              SizedBox(
                                height: 400,
                                child: BarChart(
                                  BarChartData(
                                    titlesData: buildFlTitleData(),
                                    borderData: FlBorderData(
                                        show: true,
                                        border: const Border(
                                            top: BorderSide.none,
                                            right: BorderSide.none)),
                                    gridData: const FlGridData(
                                      show: true,
                                      drawHorizontalLine: true,
                                      drawVerticalLine: false,
                                      horizontalInterval: 200,
                                    ),
                                    barGroups: crontroller.weeklySales
                                        .asMap()
                                        .entries
                                        .map(
                                          (entry) => BarChartGroupData(
                                            x: entry.key,
                                            barRods: [
                                              BarChartRodData(
                                                width: 10,
                                                toY: entry.value,
                                                color: AColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ASizes.sm),
                                              ),
                                            ],
                                          ),
                                        )
                                        .toList(),
                                    groupsSpace: ASizes.spaceBtwItems,
                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                          getTooltipColor: (_) =>
                                              AColors.secondary),
                                      touchCallback:
                                          ADeviceUtils.isDesktopScreen(context)
                                              ? (barTouchEvent,
                                                  BarTouchResponse) {}
                                              : null,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: ASizes.spaceBtwSections),

                        /// orders
                        const ARoundedContainer(),
                      ],
                    ),
                  ),
                  const SizedBox(width: ASizes.spaceBtwSections),

                  /// pie chart
                  const Expanded(child: ARoundedContainer()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  FlTitlesData buildFlTitleData() {
    return FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // map index to desired day of week
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];

                  //calculate the index and ensure it wraps around for the correct day
                  final index = value.toInt() % days.length;

                  //get the day corresponding to the calculated index
                  final day = days[index];
                  return SideTitleWidget(
                      axisSide: AxisSide.bottom, space: 0, child: Text(day));
                }
                ),
                ),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 200, reservedSize: 50)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                );
  }
}
