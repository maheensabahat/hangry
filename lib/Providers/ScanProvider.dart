import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Entities/OrderItem.dart';
import 'package:project/Views/User/Cart_Widgets/Order.dart';

class Scanned {
  final String qr_id;
  final String user_id;
  final bool order_status;
  List<OrderItem> orders = [];

  Scanned(
      {required this.qr_id, required this.user_id, required this.order_status});
}

class ScanProvider extends ChangeNotifier {
  List selectedItems = [];

  late Scanned scanned;

  Scanned createScannedInstance(
      {required String qr_id,
      required String user_id,
      required bool order_status}) {
    scanned =
        Scanned(qr_id: qr_id, user_id: user_id, order_status: order_status);
    scanned.orders = [];
    return scanned;
  }

  String getQRID() {
    return scanned.qr_id;
  }

  void addToOrder({required OrderItem order}) {
    scanned.orders.add(order);
    notifyListeners();
  }

  List OrderItemstoJson(List<OrderItem> Orders) {
    List jsonOrders = [];
    for (var order in Orders) {
      jsonOrders.add({
        "user_id": order.user_id,
        "name": order.name,
        "desc": order.desc,
        "price": order.price,
        "quantity": order.quantity,
      });
    }
    return jsonOrders;
  }

  Future addToOrderFirebase(
      {required String email, required String qr_id}) async {
    FirebaseFirestore.instance
        .collection('Scanned')
        .where("email", isEqualTo: email)
        .where("qr_id", isEqualTo: qr_id)
        .where("status", isEqualTo: true)
        .get()
        .then((value) => value.docs.map((e) => FirebaseFirestore.instance
            .collection("Scanned")
            .doc(e.id)
            .update({"selected_dishes": OrderItemstoJson(scanned.orders)})));
  }

  List getOrderList() {
    return scanned.orders;
  }

  Future addInstanceToFirebase(Scanned scanned) async {
    await FirebaseFirestore.instance.collection("Scanned").add({
      "qr_id": scanned.qr_id,
      "user_email": scanned.user_id,
      "status": scanned.order_status,
      "selected_dishes": scanned.orders,
    });
  }
}
