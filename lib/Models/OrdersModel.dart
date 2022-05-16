import 'package:flutter/material.dart';

class OrdersModel {
  String? status = 'Pending';
  String TableNum;
  List products;
  String qr_id;
  String rest_id;
  String user_id;

  //user
  //rest

  OrdersModel(
      {
        required this.rest_id,
        required this.TableNum,
        required this.user_id,
        required this.products,
        required this.qr_id,
        this.status});

  void approveRequest() {
    status = 'approved';
  }

  Map<String, dynamic> toJson() => {
    'rest_id': rest_id,
    'TableNum': TableNum,
    'products': products,
    'qr_id': qr_id,
    'user_id': user_id,
    'status': status,
  };

  static fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      rest_id: json['rest_id'],
      TableNum: json['TableNum'],
      products: json['products'],
      qr_id: json['qr_id'],
      user_id: json['user_id'],
      status: json['status'],
    );
  }

  @override
  String toString() {
    return 'OrdersModel{TableNum: $TableNum}';
  }

}