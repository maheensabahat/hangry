import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/OrderItem.dart';
import 'package:project/Entities/OrdersRest.dart';
import 'package:project/Views/User/Cart_Widgets/Order.dart';

class OrdersProvider extends ChangeNotifier {
  List<OrderItem> friendOrders = [];
  int price = 0;
  bool myOrderStatus = false;
  bool friendsOrderStatus = false;

  Orders createOrder(
      {required restaurant_id,
      required user_id,
      required qr_id,
      required order_status,
      required tableNum}) {
    return Orders(
        restaurant_id: restaurant_id,
        user_id: user_id,
        qr_id: qr_id,
        order_status: order_status,
        tableNum: tableNum);
  }

  static fromJson(Map<String, dynamic> json) {
    return Orders(
      restaurant_id: json['restaurant_id'],
      user_id: json['user_id'],
      qr_id: json['qr_id'],
      product_ids: json['product_ids'],
      order_status: json['order_status'],
      tableNum: json['tableNum'],
    );
  }

  Map<String, dynamic> toJson(Orders order) => {
        'restaurant_id': order.restaurant_id,
        'user_id': order.user_id,
        'qr_id': order.qr_id,
        'product_ids': order.product_ids,
        "order_status": order.order_status,
        "tableNum": order.tableNum,
      };

  Future<void> addOrderInFirebase(Orders order) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .add(toJson(order))
        .then((documentSnapshot) => order.id = documentSnapshot.id);
  }

  Future<void> updateOrderStatus(String order_status, String id) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(id)
        .update({"order_status": order_status});
  }

  getOrders(String restaurant_id, String order_status) async {
    await FirebaseFirestore.instance
        .collection("Orders")
        .where("restaurant_id", isEqualTo: restaurant_id)
        .where("order_status", isEqualTo: order_status);
  }

  setFriendOrders(List<List<OrderItem>> friendOrders) {
    this.friendOrders.clear();
    for (var list in friendOrders) {
      for (OrderItem orderItem in list) {
        this.friendOrders.add(orderItem);
        debugPrint(orderItem.price.toString());
      }
    }
  }

  void setTotalPrice({required List<OrderItem> myOrders}) {
    price = 0;
    for (OrderItem orderItem in friendOrders) {
      price += orderItem.price * orderItem.quantity;
    }
    for (OrderItem orderItem in myOrders) {
      price += orderItem.price * orderItem.quantity;
    }

    notifyListeners();
  }

  int getTotalPrice({required List<OrderItem> myOrder}) {
    return price;
  }

  setMyOrderStatus(bool status) {
    myOrderStatus = status;
    notifyListeners();
  }

  checkMyOrderStatus() {
    return myOrderStatus;
  }

  setFriendsOrderStatusList(bool status) {
    friendsOrderStatus = status;
    //notifyListeners();
  }

  checkFriendsOrderStatus() {
    return friendsOrderStatus;
  }
}
