import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project/Models/ProductModel.dart';
import 'package:project/Entities/Products.dart';
import '../NetworkLayer/RestaurantNetworkCall.dart';

class ProductProvider with ChangeNotifier {
  late Products product;

  List<ProductModel> productsList = [];

  RestaurantNetworkCall networkCall = RFirebaseNetworkCall();

  // void createProduct({productName, productImage, price}) {
  //   product = Products(productName: productName, productImage: productImage, price: price);
  //   notifyListeners();
  // }

  // void setProductName(String productName) {
  //   product.productName = productName;
  //   notifyListeners();
  // }
  //
  //
  // String getProductName() {
  //   return product.productName!;
  // }
  //
  // int getprice() {
  //   return product.price!;
  // }
  //
  //
  // Products getProduct() {
  //   return product;
  // }
  //
  // String? getImage() {
  //   return product.productImage;
  // }

  Future getProductsFromDB(String price) async {
    // var response = await networkCall.getUser(price);
    // Map<String, dynamic> userMap = jsonDecode(response);
    //
    // ProductModel productModel = ProductModel.fromJson(userMap);
    // if (productModel != null) {
    //   this.product = Products(
    //       name: productModel.name,
    //       image: productModel.image,
    //       price: productModel.price);
    // }
    // notifyListeners();
  }
}
