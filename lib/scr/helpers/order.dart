import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/scr/models/order.dart';

class OrderServices {
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  Future<List<OrderModel>> getUserOrders({String userId}) async => _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.documents) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}
