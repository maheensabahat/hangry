import 'package:project/Views/User/Cart.dart';

class OrderItem{
  String name;
  String desc;
  double price;
  int quantity;

  OrderItem(this.name, this.desc, this.price, this.quantity);

  double calculatePrice(){
    return this.price * this.quantity;
  }

}