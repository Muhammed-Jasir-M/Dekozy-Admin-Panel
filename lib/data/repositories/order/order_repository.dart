import 'package:aura_kart_admin_panel/features/shop/models/order_model.dart';
import 'package:aura_kart_admin_panel/utils/exceptions/firebase_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  //  single item instance of the orderrepository
  static OrderRepository get instance => Get.find();

  // firebase firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // functions--------------------------

  // get all orders related tro the current ussr
  Future<List<OrderModel>> getAllOrders() async {
    try {
      final await = _db.collection('Orders').orderBy('OrderDate', descending: true).get();
      return result.docs.map((DocumentSnapshot) => OrderModel.fromSnapshot(DocumentSnapshot)).toList();
    } on FirebaseException catch (e) {
      throw AFirebaseException(e.code).message;
    } 
  }
}
