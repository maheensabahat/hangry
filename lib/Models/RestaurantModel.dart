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


  static OrderID_fromJson(Map<String, dynamic> json) {
    return json['Order-ID'];
  }

  static Map<String, dynamic> ID_toJson(var id) => {'ID': id};

  static ID_fromJson(Map<String, dynamic> json) {
    return json['ID'];
  }
}
