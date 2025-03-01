import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/utils/constants/enums.dart';
import 'package:aura_kart_admin_panel/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;

  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  /// Order
  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0012',
      status: OrderStatus.processing,
      totalAmount: 265,
      shippingCost: 50, // ✅ FIXED: Added required 'shippingCost' parameter
      taxCost: 18, // ✅ FIXED: Added required 'taxCost' parameter
      orderDate: DateTime(2024, 5, 20),
      deliveryDate: DateTime(2024, 5, 20),
      items: [], // ✅ FIXED: Added required 'items' parameter
    ),
    OrderModel(
      id: 'CWT0013',
      status: OrderStatus.processing,
      totalAmount: 300,
      shippingCost: 55,
      taxCost: 20,
      orderDate: DateTime(2024, 5, 21),
      deliveryDate: DateTime(2024, 5, 22),
      items: [],
    ),
    OrderModel(
      id: 'CWT0014',
      status: OrderStatus.shipped,
      totalAmount: 400,
      shippingCost: 60,
      taxCost: 25,
      orderDate: DateTime(2024, 5, 22),
      deliveryDate: DateTime(2024, 5, 23),
      items: [],
    ),
    OrderModel(
      id: 'CWT0015',
      status: OrderStatus.delivered,
      totalAmount: 500,
      shippingCost: 65,
      taxCost: 30,
      orderDate: DateTime(2024, 5, 23),
      deliveryDate: DateTime(2024, 5, 24),
      items: [],
    ),
    OrderModel(
      id: 'CWT0016',
      status: OrderStatus.delivered,
      totalAmount: 600,
      shippingCost: 70,
      taxCost: 35,
      orderDate: DateTime(2024, 5, 24),
      deliveryDate: DateTime(2024, 5, 25),
      items: [],
    ),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  // Calculate Weekly Sales
  void _calculateWeeklySales() {
    // Reset weekly sales to zeros
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      final DateTime orderWeekStart =
          AHelperFunctions.getStartOfWeek(order.orderDate);

      // Check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        // Ensure the index is non-negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
      }
    }
  }

  // Call this function to calculate Order Status counts
  void _calculateOrderStatusData() {
    // Reset Status data
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
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered'; // ✅ FIXED typo (previously "Delevered")
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
