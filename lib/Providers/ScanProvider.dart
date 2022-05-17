import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Entities/OrderItem.dart';

import '../Entities/User.dart';

class Scanned {
  final String qr_id;
  final String user_id;
  bool order_status;
  late List<OrderItem> orders;
  final bool qr_status;

  Scanned(
      {required this.qr_id,
      required this.user_id,
      required this.order_status,
      required this.qr_status});
}

class ScanProvider extends ChangeNotifier {
  late String ScannedEmail;
  late Scanned scanned;
  List jsonOrders = [];
  bool isPresent = false;

  //List id = [];

  Scanned createScannedInstance({
    required String qr_id,
    required String user_id,
    required bool order_status,
    required bool qr_status,
  }) {
    scanned = Scanned(
        qr_id: qr_id,
        user_id: user_id,
        order_status: order_status,
        qr_status: qr_status);
    scanned.orders = [];
    return scanned;
  }

  String getScannedEmail() {
    return ScannedEmail;
  }

  void setScannedEmail({required String email}) {
    ScannedEmail = email;
  }

  String getQRID() {
    return scanned.qr_id;
  }

  bool checkItemPresent(var product) {
    List productIDs = [];
    for (var order in scanned.orders) {
      productIDs.add(order.ProductID);
    }
    int index = productIDs.indexOf(product);
    return index > -1;
  }

  void addToOrder({required OrderItem order}) {
    isPresent = false;
    List productIDs = [];
    for (var order in scanned.orders) {
      productIDs.add(order.ProductID);
    }
    int index = productIDs.indexOf(order.ProductID);
    if (index > -1) {
      scanned.orders.remove(scanned.orders[index]);
      // if (scanned.orders[index].quantity < 5) {
      //   scanned.orders[index].quantity += 1;
      // }
    } else {
      scanned.orders.add(order);
    }

    isPresent = true;
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
        "product_id": order.ProductID,
        "name": order.name,
        "desc": order.desc,
        "price": order.price,
        "quantity": order.quantity,
        "image": order.image
      });
    }

    return jsonOrders;
  }

  Future addToOrderFirebase(
      {required String email,
      required String qr_id,
      required List<OrderItem> orders}) async {
    await FirebaseFirestore.instance
        .collection('Scanned')
        .where("user_email", isEqualTo: email)
        .where("qr_id", isEqualTo: qr_id)
        .where("qr_status", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
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

  double Total(List orders) {
    double total = 0;
    orders.forEach((element) {
      total += element.calculatePrice();
    });
    return total;
  }

  Future addInstanceToFirebase(
      {required Scanned scanned, required User user}) async {
    await FirebaseFirestore.instance.collection("Scanned").add({
      "qr_id": scanned.qr_id,
      "user_email": scanned.user_id,
      "user_name": user.name,
      "user_picture": user.profilePicture,
      "order_status": scanned.order_status,
      "qr_status": scanned.qr_status,
      "selected_dishes": scanned.orders,
    });
  }

  Future updateOrderStatusInFirebase(
      {required String email,
      required String qr_id,
      required bool status}) async {
    await FirebaseFirestore.instance
        .collection('Scanned')
        .where("user_email", isEqualTo: email)
        .where("qr_id", isEqualTo: qr_id)
        .where("qr_status", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection("Scanned")
            .doc(doc.id)
            .update({"order_status": status});
      }
    });
  }

  Future updateQRStatusInFirebase(
      {required String email,
      required String qr_id,
      required bool status}) async {
    await FirebaseFirestore.instance
        .collection('Scanned')
        .where("user_email", isEqualTo: email)
        .where("qr_id", isEqualTo: qr_id)
        .where("qr_status", isEqualTo: true)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection("Scanned")
            .doc(doc.id)
            .update({"qr_status": status});
      }
    });
  }

  Future exitCart({required String email, required String qr_id}) async {
    await FirebaseFirestore.instance
        .collection('Scanned')
        .where("user_email", isEqualTo: email)
        .where("qr_id", isEqualTo: qr_id)
        .get()
        .then((QuerySnapshot querySnapshot) async => {
              for (QueryDocumentSnapshot doc in querySnapshot.docs)
                {
                  await FirebaseFirestore.instance
                      .collection("Scanned")
                      .doc(doc.id)
                      .delete()
                }
            });
  }
}
