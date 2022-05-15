import 'package:flutter/material.dart';
import 'package:project/Entities/OrdersRest.dart';
import 'package:project/Entities/ReservationRequest.dart';
import '../Entities/Products.dart';
import '../Entities/Restaurant.dart';
import '../Models/ProductModel.dart';
import '../NetworkLayer/RestaurantNetworkCall.dart';

class RestaurantProvider extends ChangeNotifier {
  late Restaurant restaurant;
  late List orders;
  late String email;
  late String restaurant_id;
  late String order_status;
  bool isLoaded = true;
  late List<ReservationRequest> Approved_request;
  late List<ReservationRequest> Pending_request;

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
    }
    notifyListeners();
  }

  Restaurant getRestaurant(String? email) {
    return restaurant;
  }

  setRestaurant(Restaurant r) {
    restaurant = r;
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

  Future<Orders?> getRestOrders(restaurant_id, order_status) async {
    isLoaded = false;
    notifyListeners();

    orders = await networkCall.getRestOrders(restaurant_id,order_status);
    print(orders);

    isLoaded = true;
    notifyListeners();
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
}
