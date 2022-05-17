import 'package:flutter/material.dart';
import 'package:project/Entities/OrdersRest.dart';
import 'package:project/Entities/ReservationRequest.dart';
import 'package:project/Models/OrdersModel.dart';
import '../Entities/OrdersHistory.dart';
import '../Entities/Products.dart';
import '../Entities/Restaurant.dart';
import '../Models/ProductModel.dart';
import '../NetworkLayer/RestaurantNetworkCall.dart';

class RestaurantProvider extends ChangeNotifier {
  late Restaurant restaurant;
  late Restaurant Cartrestaurant;
  List<Orders?> orders = [];
  late String email;
  late String restaurant_id;
  late String Cartrestaurant_id;
  late String order_status;
  bool isLoaded = true;
  late List<ReservationRequest> Approved_request;
  late List<ReservationRequest> Pending_request;
  late String name = '';
  bool notFound = false;

  late List<OrdersHistory> Pending_orders;
  late List<OrdersHistory> Approved_orders;
  late List<OrdersHistory> Rejected_orders;

  RestaurantNetworkCall networkCall = RFirebaseNetworkCall();

  Future getRestaurantFromFirebase(String? email) async {
    var rModel = await networkCall.getRestaurantFromFirebase(email!);

    if (rModel != null) {
      this.restaurant = Restaurant(
          id: rModel.id,
          name: rModel.name,
          category: rModel.category,
          desc: rModel.desc,
          image: rModel.image);
      this.email = email;
      notFound = false;
    } else {
      notFound = true;
    }
    notifyListeners();
  }

  Restaurant getRestaurant(String? email) {
    return restaurant;
  }

  setCartRestaurant(Restaurant r) {
    Cartrestaurant = r;
    Cartrestaurant_id = r.id;
  }

  setRestaurant(Restaurant r) {
    restaurant = r;
    restaurant_id = r.id;
  }


  getRequests(String status) async {
    isLoaded = false;
    await Future.delayed(Duration(milliseconds: 1));
    notifyListeners();

    if (status == 'approved') {
      Approved_request = await networkCall.getRequest(restaurant.id, status);
    } else {
      Pending_request = await networkCall.getRequest(restaurant.id, status);
    }

    isLoaded = true;
    notifyListeners();
  }

  approveRequest(var request_id) async {
    await networkCall.ApproveRequest(request_id);
    getRequests('approved');
    getRequests('pending');
  }


  getOrderHistory(String status) async {
    isLoaded = false;
    await Future.delayed(const Duration(milliseconds: 1));
    notifyListeners();

    if (status == 'pending') {
      Pending_orders = await networkCall.getOrderHistory1(restaurant.id, status);
    } else if (status == 'approved'){
      Approved_orders = await networkCall.getOrderHistory1(restaurant.id, status);
    }
    else {
      Rejected_orders = await networkCall.getOrderHistory1(restaurant.id, status);
    }

    isLoaded = true;
    notifyListeners();
  }

  approveOrder(var request_id) async {
    await networkCall.ApproveRequest(request_id);
    getOrderHistory('approved');
    getOrderHistory('pending');
    getOrderHistory('rejected');
  }

  rejectOrder(var request_id) async {
    await networkCall.ApproveRequest(request_id);
    getOrderHistory('pending');
    getOrderHistory('approved');
    getOrderHistory('rejected');
  }

  Future<void> updateDetails(Restaurant r) async {
    isLoaded = false;
    notifyListeners();

    await networkCall.updateDetails(r);
    getRestaurantFromFirebase(email);

    isLoaded = true;
    notifyListeners();
  }

  Future addProduct(Products product) async {
    isLoaded = false;
    notifyListeners();

    var p = ProductModel(
        name: product.name,
        image: product.image,
        price: product.price,
        desc: product.desc);

    await networkCall.addProduct(p, restaurant.id);
    getProducts();
  }

  Future updateProduct(Products product) async {
    isLoaded = false;
    notifyListeners();

    var p = ProductModel(
        ID: product.ID,
        name: product.name,
        image: product.image,
        price: product.price,
        desc: product.desc);

    await networkCall.updateProduct(p, restaurant.id);
    getProducts();
  }

  Future<void> getProducts() async {
    isLoaded = false;
    await Future.delayed(Duration(milliseconds: 1));
    notifyListeners();

    var response = await networkCall.getProducts(restaurant.id);

    List<Products> products = response
        .map((e) => Products(
            name: e.name,
            price: e.price,
            image: e.image,
            desc: e.desc,
            ID: e.ID))
        .toList();

    restaurant.items = products;

    isLoaded = true;
    notifyListeners();
  }

  Future<List<Orders?>> getRestOrdersFromFirebase(
      restaurant_id, order_status) async {
    var orders;
    orders = await networkCall.getRestOrders(restaurant_id, order_status);
    for (Orders order in orders) {
      this.orders.add(order);
    }
    notifyListeners();
    return orders;
  }

  List<Orders?> getOrders(restaurant_id, order_status) {
    getRestOrdersFromFirebase(restaurant_id, order_status);
    return orders;
  }

  String getEmail() {
    return restaurant.id;
  }

  Future<void> getOrd(String status) async {
    restaurant.Pending_Orders.clear();
    changeLoadingVar(false);

    List<OrdersModel> r = await getOrdFromDB(status);
    if (status == 'Pending') {
      restaurant.Pending_Orders = r;
      notifyListeners();
    } else {
      restaurant.Approved_Orders = r;
    }

    changeLoadingVar(true);
  }

  Future<List<OrdersModel>> getOrdFromDB(String status) async {
    List<OrdersModel> r = [];

    r = await networkCall.getOrd(this.restaurant, status);

    return r;
  }

  Future<void> changeLoadingVar(bool bvar) async {
    isLoaded = bvar;
    await Future.delayed(
      const Duration(milliseconds: 1),
    );
    notifyListeners();
  }

  getRestaurantNameFromFirebase(String rest_id) async {
    name = await networkCall.getRestaurantName(rest_id);
  }

  getRestaurantName(String rest_id) {
    getRestaurantNameFromFirebase(rest_id);
    return name;
  }
}

// Future<void> getRestOrders() async {
//   isLoaded = false;
//   await Future.delayed(const Duration(milliseconds: 1));
//   notifyListeners();
//
//   var response = await networkCall.getRestOrders(id);
//
//   List<Orders> o = response
//       .map((e) => Orders(
//       user_id: e.user_id,
//       restaurant_id: e.restaurant_id,
//       qr_id: e.qr_id,
//       product_ids: e.product_ids,
//       order_status: e.order_status))
//       .toList();
//
//   orders = o ;
//
//   isLoaded = true;
//   notifyListeners();
// }
