import 'package:project/Entities/Products.dart';

class Restaurant {
  String name;
  String desc;
  String category;
  bool? isFav = false;
  String image;
  late List<Products> items;
  var id;

  Restaurant(
      {required this.name,
      required this.desc,
      required this.category,
      required this.image,
      this.isFav,
      this.id});

  @override
  String toString() {
    return 'Restaurant{name: $name, desc: $desc, category: $category, image: $image}';
  }
}
