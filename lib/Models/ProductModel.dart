class ProductModel {
  final String? productName;
  final String? productImage;
  final int? price;

  ProductModel(
      {required this.productName,
        required this.productImage,
        required this.price});

  static fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productName: json['productName'],
        price: json['price'],
        productImage: json['productImage']);
  }

  Map<String, dynamic> toJson() => {
    'productName': productName,
    'price': price,
    'productImage': productImage
  };
}