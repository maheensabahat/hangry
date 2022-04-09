import 'package:flutter/cupertino.dart';
import 'OrderItem.dart';

class cart extends ChangeNotifier{


  List<OrderItem> list = [];

  double calculateTotal(){
    double total = 0;
    list.forEach((element) {
      total += element.calculatePrice();
    });
    return total;
  }

  void addItem(OrderItem item){
    list.add(item);
    notifyListeners();
  }

  @override
  String toString() {
    return 'cart{list: $list}';
  }
}