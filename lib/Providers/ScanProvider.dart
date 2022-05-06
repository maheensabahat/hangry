import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Entities/OrderItem.dart';
import 'package:project/Views/User/Cart_Widgets/Order.dart';

class Scanned {
  final String qr_id;
  final String user_id;
  bool order_status;
  late List<OrderItem> orders;

  Scanned(
      {required this.qr_id, required this.user_id, required this.order_status});
}

class ScanProvider extends ChangeNotifier {
  late Scanned scanned;
  List jsonOrders = [];
  List id = [];

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

  bool getOrderStatus() {
    return scanned.order_status;
  }

  void setOrderStatusToFalse() {
    scanned.order_status = false;
    notifyListeners();
  }

  List OrderItemstoJson(List<OrderItem> orders) {
    jsonOrders.clear();
    for (var order in orders) {
      jsonOrders.add({
        //"user_id": order.user_id,
        "name": order.name,
        "desc": order.desc,
        "price": order.price,
        "quantity": order.quantity,
      });
    }

    return jsonOrders;
  }

  // printJson() {
  //   debugPrint(jsonOrders.toString());
  // }

  printID() {
    debugPrint(id[0] + " " + id.length);
  }

  //   Future addToOrderFirebase(
  //     {required String email,
  //     required String qr_id,
  //     required List<OrderItem> orders}) async {
  //   debugPrint(OrderItemstoJson(orders).toString());

  //   await FirebaseFirestore.instance
  //       .collection('Scanned')
  //       .where("email", isEqualTo: email)
  //       .where("qr_id", isEqualTo: qr_id)
  //       .where("status", isEqualTo: true)
  //       .get()
  //       .then((value) => value.docs.map((e) async => {
  //             id = e.id,
  //             await FirebaseFirestore.instance
  //                 .collection("Scanned")
  //                 .doc(e.id)
  //                 .set({"selected_dishes": OrderItemstoJson(orders)})
  //           }));
  // }

  Future addToOrderFirebase(
      {required String email,
      required String qr_id,
      required List<OrderItem> orders}) async {
    debugPrint(OrderItemstoJson(orders).toString());

    await FirebaseFirestore.instance
        .collection('Scanned')
        .where("user_email", isEqualTo: email)
        .where("qr_id", isEqualTo: qr_id)
        .where("status", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        id.add(doc.id);
        await FirebaseFirestore.instance
            .collection("Scanned")
            .doc(doc.id)
            .update({"selected_dishes": OrderItemstoJson(orders)});
      }
    });
  }

  List<OrderItem> getOrderList() {
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
