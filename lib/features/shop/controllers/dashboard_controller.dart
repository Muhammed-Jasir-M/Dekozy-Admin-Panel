import 'package:aura_kart_admin_panel/features/authentication/models/order_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  /// order
  static final List<OrderModel> orders = [
    OrderModel(
        id: 'CWT0012',
        status: OrderStatus.processing,
        totalAmount: 265,
        orderDate: DateTime(2024, 5, 20),
        deliveryDate: DateTime(2024, 5, 20)),
    OrderModel(
        id: 'CWT0012',
        status: OrderStatus.processing,
        totalAmount: 265,
        orderDate: DateTime(2024, 5, 20),
        deliveryDate: DateTime(2024, 5, 20)),
    OrderModel(
        id: 'CWT0012',
        status: OrderStatus.shipped,
        totalAmount: 265,
        orderDate: DateTime(2024, 5, 20),
        deliveryDate: DateTime(2024, 5, 20)),
    OrderModel(
        id: 'CWT0012',
        status: OrderStatus.delivered,
        totalAmount: 265,
        orderDate: DateTime(2024, 5, 20),
        deliveryDate: DateTime(2024, 5, 20)),
    OrderModel(
        id: 'CWT0012',
        status: OrderStatus.delivered,
        totalAmount: 265,
        orderDate: DateTime(2024, 5, 20),
        deliveryDate: DateTime(2024, 5, 20)),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  // claculate weekly sales
  void _calculateWeeklySales() {
    //reset weekly sales to zeros
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      final DateTime orderWeekStart =
          AHelperFunctions.getStartOfWeek(order.orderDate);

      //check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        //ensure the index is non negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;

        print(
            'OrderDate : ${order.orderDate}, CurrentWeekDay: $orderWeekStart, Index: $index');
      }
    }

    print('Weekly Sales : $weeklySales');
  }

  // Call this function to calculate Order Status counts
  void _calculateOrderStatusData() {
    // Resets Status data
    orderStatusData.clear();

    // Map to store total amounts for each status
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orders) {
      // Count Orders
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // Calculate total amounts for each status
      totalAmounts[status] = (totalAmounts[status] ?? 0) + 1;
    }
  }

   String getOrderStatusName(OrderStatus status) {
    switch(status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delevered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
