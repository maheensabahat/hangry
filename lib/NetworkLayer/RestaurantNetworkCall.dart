import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Entities/OrdersHistory.dart';
import '../Entities/ReservationRequest.dart';
import '../Entities/OrdersRest.dart';
import '../Entities/Restaurant.dart';
import '../Models/OrdersModel.dart';
import '../Models/ProductModel.dart';
import '../Models/RestaurantModel.dart';

abstract class RestaurantNetworkCall {
  Future<RestaurantModel?> getRestaurantFromFirebase(String email);

  Future updateDetails(Restaurant restaurant);

  Future<void> addProduct(ProductModel item, var restaurant_id);

  Future<List<ProductModel>> getProducts(var restaurant_id);

  Future updateProduct(ProductModel product, var restaurant_id);

  Future<List<ReservationRequest>> getRequest(var id, String status);

  Future<void> ApproveRequest(var id);

  Future<List<OrdersHistory>> getOrderHistory1(
      String restaurant_id, String status);

  Future<void> ApproveOrder(var id);

  Future<void> RejectOrder(var id);

  Future<List> getRestOrders(var restaurant_id, order_status);

  Future<List<OrdersModel>> getOrd(Restaurant restaurant, String status);
  Future<String> getRestaurantName(String rest_id);
}

class RFirebaseNetworkCall implements RestaurantNetworkCall {
  @override
  Future<RestaurantModel?> getRestaurantFromFirebase(String email) async {
    RestaurantModel? model;
    await FirebaseFirestore.instance
        .collection('Restaurants')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        model = RestaurantModel.fromJson(doc.data() as Map<String, dynamic>);
        model?.id = doc.id;
      });
    });
    return model;
  }

  Future updateDetails(Restaurant restaurant) async {
    CollectionReference res =
        FirebaseFirestore.instance.collection('Restaurants');

    await res.doc(restaurant.id).update({
      'name': restaurant.name,
      'desc': restaurant.desc,
      'cuisine': restaurant.category,
    }).then((value) {
      print("Details updated.");
    }).catchError((error) => print("Failed to updated detail: $error"));
  }

  Future<List<ReservationRequest>> getRequest(var id, String status) async {
    List<ReservationRequest> requests = [];
    await FirebaseFirestore.instance
        .collection('Reservations')
        .where('rest_ID', isEqualTo: id)
        .where('status', isEqualTo: status)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var r = ReservationRequest.fromJson(doc.data() as Map<String, dynamic>);
        r.id = doc.id;
        requests.add(r);
      });
    });
    return requests;
  }

  @override
  Future<void> ApproveRequest(var id) async {
    CollectionReference rest =
        FirebaseFirestore.instance.collection('Reservations');

    rest.doc(id).update({
      'status': 'approved',
    }).then((value) {
      print("Request approved.");
    }).catchError((error) => print("Failed to approve request: $error"));
  }

  Future<List<OrdersHistory>> getOrderHistory1(var id, String status) async {
    List<OrdersHistory> requests = [];
    await FirebaseFirestore.instance
        .collection('Orders')
        .where('restaurant_id', isEqualTo: id)
        .where('status', isEqualTo: status)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var r = OrdersHistory.fromJson(doc.data() as Map<String, dynamic>);
        r.id = doc.id;
        requests.add(r);
      });
    });
    return requests;
  }

  @override
  Future<void> ApproveOrder(var id) async {
    CollectionReference ord = FirebaseFirestore.instance.collection('Orders');

    ord.doc(id).update({
      'status': 'Approved',
    }).then((value) {
      print("Order approved.");
    }).catchError((error) => print("Failed to approve order: $error"));
  }

  @override
  Future<void> RejectOrder(var id) async {
    CollectionReference ord = FirebaseFirestore.instance.collection('Orders');

    ord.doc(id).update({
      'status': 'Rejected',
    }).then((value) {
      print("Order rejected.");
    }).catchError((error) => print("Failed to reject order: $error"));
  }

  @override
  Future<void> addProduct(ProductModel item, restaurant_id) async {
    CollectionReference rest =
        FirebaseFirestore.instance.collection('Restaurants');
    rest
        .doc(restaurant_id)
        .collection('Products')
        .add(item.toJson())
        .then((value) async {
      print("Product Added, ${value.id}");
    }).catchError((error) => print("Failed to add product: $error"));
  }

  Future updateProduct(ProductModel product, var restaurant_id) async {
    CollectionReference rest =
        FirebaseFirestore.instance.collection('Restaurants');

    rest.doc(restaurant_id).collection('Products').doc(product.ID).update({
      'name': product.name,
      'desc': product.desc,
      'price': product.price,
    }).then((value) {
      print("Item Details updated.");
    }).catchError((error) => print("Failed to updated item details: $error"));
  }

  @override
  Future<List<ProductModel>> getProducts(restaurant_id) async {
    List<ProductModel> products = [];

    await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(restaurant_id)
        .collection('Products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        ProductModel p =
            ProductModel.fromJson(doc.data() as Map<String, dynamic>);
        p.ID = doc.id;
        products.add(p);
      });
    });
    return products;
  }

  @override
  Future<List<Orders>> getRestOrders(restaurant_id, order_status) async {
    List<Orders> orders = [];

    await FirebaseFirestore.instance
        .collection('Orders')
        .where("restaurant_id", isEqualTo: restaurant_id)
        .where("order_status", isEqualTo: order_status)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var list = jsonDecode(jsonEncode(doc.data()));
        Orders ord = Orders(
            restaurant_id: list["restaurant_id"],
            user_id: list["user_id"],
            qr_id: list["qr_id"],
            order_status: list["order_status"],
            product_ids: list["product_ids"],
            tableNum: list["tableNum"],
            restaurant_name: list["restaurant_name"]);

        orders.add(ord);
      });
    });
    return orders;
  }

  Future<List<OrdersModel>> getOrd(Restaurant restaurant, String status) async {
    List<OrdersModel> reqs = [];

    List ids = await getOrdId(restaurant);

    int i = 0;
    while (i < ids.length) {
      OrdersModel r = await getOrdusingID(ids[i], status) as OrdersModel;
      if (r != null) {
        reqs.add(r);
      }
      i++;
    }

    return reqs;
  }

  Future<OrdersModel?> getOrdusingID(var id, String status) async {
    var x = await FirebaseFirestore.instance
        .collection('Orders')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      OrdersModel req =
          OrdersModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
      print(req);
      if (req.status == status) {
        return req;
      } else {
        return null;
      }
    });

    return x;
  }

  getOrdId(Restaurant restaurant) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(restaurant.id)
        .collection('Orders')
        .get();

    final thedetails = query.docs
        .map((DocumentSnapshot e) =>
            RestaurantModel.OrderID_fromJson(e.data() as Map<String, dynamic>))
        .toList();

    print(thedetails);
    return thedetails;
  }

  @override
  getRestaurantName(String rest_id) async {
    String name = '';
    await FirebaseFirestore.instance
        .collection("Restaurants")
        .where("email", isEqualTo: rest_id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      name = querySnapshot.docs[0].get("name");
    });
    return name;
  }
}
