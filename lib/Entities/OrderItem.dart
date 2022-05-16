import 'package:project/Views/User/Cart.dart';

class OrderItem {
  var ProductID;
  String user_id;
  late String restaurant_id;
  late List<String> dish_id;
  late String image;
  String name;
  String desc;
  int price;
  int quantity;

  OrderItem(
      {required this.user_id,
      required this.name,
      required this.desc,
      required this.price,
      required this.quantity});

  int calculatePrice() {
    return this.price * this.quantity;
  }

  @override
  String toString() {
    return 'OrderItem{name: $name}';
  }
}
