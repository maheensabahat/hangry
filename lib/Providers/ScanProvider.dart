import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Entities/OrderItem.dart';

class Scanned {
  final String qr_id;
  final String user_id;
  final bool order_status;
  List orders = [];

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

  void addToOrder(OrderItem dish) {
    scanned.orders.add(dish);
    notifyListeners();
  }

  Future addToOrderFirebase(OrderItem dish, String email) async {
    FirebaseFirestore.instance
        .collection('Scanned')
        .where("email", isEqualTo: email)
        .get()
        .then((value) => value.docs.map((e) => FirebaseFirestore.instance
            .collection("Scanned")
            .doc(e.id)
            .update({"selected_dishes": scanned.orders})));
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
