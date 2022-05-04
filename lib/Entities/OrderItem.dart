import 'package:project/Views/User/Cart.dart';

class OrderItem {
  String user_id;
  late String restaurant_id;
  late String dish_id;
  String name;
  String desc;
  double price;
  int quantity;

  OrderItem(
      {required this.user_id,
      required this.name,
      required this.desc,
      required this.price,
      required this.quantity});

  double calculatePrice() {
    return this.price * this.quantity;
  }

  @override
  String toString() {
    return 'OrderItem{name: $name}';
  }
}
