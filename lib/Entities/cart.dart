import 'package:flutter/cupertino.dart';
import 'OrderItem.dart';

class cart extends ChangeNotifier{

  double total = 0;

  List<OrderItem> list = [];

  void calculateTotal(){
    list.forEach((element) {
      total += element.calculatePrice();
      notifyListeners();
    });
  }

  void addItem(OrderItem item){
    list.add(item);
    notifyListeners();
  }

}