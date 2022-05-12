import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/Entities/Products.dart';
import '../Entities/Restaurant.dart';
import '../Models/ProductModel.dart';
import '../Models/RestaurantModel.dart';

abstract class RestaurantNetworkCall {
  Future<RestaurantModel?> getRestaurant(String email);

  Future updateDetails(Restaurant restaurant);

  Future<void> addProduct(ProductModel item, var restaurant_id);

  Future<List<ProductModel>> getProducts(var restaurant_id);

  Future updateProduct(ProductModel product, var restaurant_id);

}

class RFirebaseNetworkCall implements RestaurantNetworkCall {
  @override
  Future<RestaurantModel?> getRestaurant(String email) async {
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

}
