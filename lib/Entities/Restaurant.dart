import 'package:project/Entities/Products.dart';
import 'package:project/Models/OrdersModel.dart';

class Restaurant {
  String name;
  String desc;
  String category;
  bool? isFav = false;
  String image;
  List<Products> items = [];
  var id;

  Restaurant(
      {required this.name,
      required this.desc,
      required this.category,
      required this.image,
      this.isFav,
      this.id});

  List<OrdersModel> Approved_Orders = [];
  List<OrdersModel> Pending_Orders = [];
  List<OrdersModel> Rejected_Orders = [];

  @override
  String toString() {
    return 'Restaurant{name: $name, desc: $desc, category: $category, image: $image}';
  }
}
