import 'package:flutter/cupertino.dart';
import 'OrderItem.dart';
import 'Restaurant.dart';

class MyOrder extends ChangeNotifier {
  List<OrderItem> list = [];
  bool isPlaced = false;
  late Restaurant restaurant;

  double Total() {
    double total = 0;
    list.forEach((element) {
      total += element.calculatePrice();
    });
    return total;
  }

  void addItem(OrderItem item) {
    if (!isPlaced) {
      list.add(item);
      notifyListeners();
    }
  }

  void MarkPlaced() {
    isPlaced = true;
  }

  @override
  String toString() {
    return 'cart{list: $list}';
  }
}
