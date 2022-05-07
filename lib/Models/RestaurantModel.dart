class RestaurantModel {
  String name;
  String desc;
  String category;
  String image;
  var id;

  RestaurantModel(
      {required this.name,
      required this.desc,
      required this.category,
      required this.image, this.id});

  static fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      name: json['name'],
      desc: json['desc'],
      category: json['cuisine'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'desc': desc, 'category': category, 'image': image};
}
