class UserModel {
  final String? name;
  final String? email;
  final String? location;
  final String? image;
  final int? phone;

  UserModel(
      {required this.name,
      required this.email,
      required this.location,
      required this.phone,
      required this.image});

  static fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        location: json['location'],
        phone: json['phone'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'location': location,
        'phone': phone,
        'image': image
      };

  static reservationReqs_fromJson(Map<String, dynamic> json) {
    return json['Request-ID'];
  }

}
