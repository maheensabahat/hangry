import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/OrderItem.dart';
import 'package:project/Entities/OrdersRest.dart';
import 'package:project/Entities/Products.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:project/Views/Admin/AdRestaurants.dart';
import 'package:project/Views/User/Cart_Widgets/Order.dart';

import '../Entities/Order_details.dart';
import '../Entities/User_order.dart';

class OrdersProvider extends ChangeNotifier {
  List<OrderItem> friendOrders = [];
  int price = 0;
  bool myOrderStatus = false;
  bool friendsOrderStatus = false;

  get userOrders => null;

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

  UserOrders createUserOrder({
    required restaurant_id,
    required user_id,
    required qr_id,
    required order_status,
    required tableNum,
  }) {
    return UserOrders(
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

    print(price);
  }

  int getTotalPrice({required List<OrderItem> myOrder}) {
    setTotalPrice(myOrders: myOrder);
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

  addFinalOrdersToFirebase(
      String qr_id, String user_id, List<OrderItem> orders) async {
    List product_details = [];
    for (var order in orders) {
      product_details.add({
        "product_id": order.ProductID,
        "quantity": order.quantity,
        "image": order.image,
        "name": order.name,
        "price": order.price * order.quantity
      });
      // debugPrint(order.ProductID);
    }
    String table_num = qr_id.split(" ")[1].split(":")[1];
    String restaurant_id = qr_id.split(" ")[0].split(":")[1];

    await FirebaseFirestore.instance.collection('Orders').add(
      {
        "user_id": user_id,
        "qr_id": qr_id,
        "restaurant_id": restaurant_id,
        "product_details": product_details,
        "table_num": table_num,
        "date": DateTime.now(),
        "status": "Pending",
      },
    );
  }

  getOrdersFromFirebase({required String email}) async {
    await FirebaseFirestore.instance
        .collection('Orders')
        .where("user_id", isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var order = UserOrders(
            restaurant_id: doc.get("restaurant_id"),
            user_id: doc.get("user_id"),
            qr_id: doc.get("qr_id"),
            order_status: doc.get("status"),
            tableNum: doc.get("table_num"));
        order.id = doc.id;
        order.date = (doc.get("date") as Timestamp).toDate().toUtc().toString();
        userOrders.add(order);
        userOrders[userOrders.length - 1].product_details = [];
        List productdetails = doc.get("product_details");
        for (int i = 0; i < productdetails.length; i++) {
          userOrders[userOrders.length - 1].product_details!.add(ProductDetails(
              ProductID: productdetails[i]["product_id"],
              quantity: productdetails[i]["quantity"],
              image: productdetails[i]["image"],
              name: productdetails[i]["name"],
              price: productdetails[i]["price"]));
        }
      }
    });
  }

  List<UserOrders> getUserOrders() {
    return userOrders;
  }
}
