class UserModel {
  final String? name;
  final String? email;
  final String? location;

  UserModel({
    required this.name,
    required this.email,
    required this.location,
  });

  static fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      location: json['location']
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'location': location
  };
}