class ProductModel {
  final String name;
  final String? image;
  String desc;
  var ID;
  final int price;

  ProductModel(
      {required this.name,
      required this.desc,
      this.ID,
      required this.image,
      required this.price});

  static fromJson(Map<String, dynamic> json) {
    return ProductModel(
        name: json['name'],
        price: json['price'],
        desc: json['desc'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'price': price, 'image': image, 'desc': desc};
}
