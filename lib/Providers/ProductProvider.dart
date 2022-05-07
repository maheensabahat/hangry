import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project/Models/ProductModel.dart';
import 'package:project/Entities/Products.dart';
import '../NetworkLayer/NetworkCall.dart';

class ProductProvider with ChangeNotifier{
  late Products product;

  List<ProductModel> productsList = [];

  NetworkCall networkCall = FirebaseNetworkCall();

  void createProduct({productName, productImage, price}) {
    product = Products(productName: productName, productImage: productImage, price: price);
    notifyListeners();
  }

  void setProductName(String productName) {
    product.productName = productName;
    notifyListeners();
  }


  String getProductName() {
    return product.productName!;
  }

  int getprice() {
    return product.price!;
  }


  Products getProduct() {
    return product;
  }

  String? getImage() {
    return product.productImage;
  }


  Future addProduct(Products product) async {
    // Firebase API call
    await networkCall.addProduct(product);
    notifyListeners();
  }



  Future getProductsFromDB(String price) async {
    var response = await networkCall.getUser(price);
    Map<String, dynamic> userMap = jsonDecode(response);

    ProductModel productModel = ProductModel.fromJson(userMap);
    if (productModel != null) {
      this.product = Products(
          productName: productModel.productName,
          productImage: productModel.productImage,
          price: productModel.price);
    }
    notifyListeners();
  }
}