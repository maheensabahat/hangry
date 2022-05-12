class ReservationRequest {
  String? status = 'pending';
  int seats;
  String time;
  int phone;
  DateTime date;
  String? name;
  String? restaurantName;
  var restaurant_id;

  //user
  //rest

  ReservationRequest(
      {required this.name,
      required this.restaurant_id,
      required this.restaurantName,
      required this.phone,
      required this.time,
      required this.seats,
      required this.date,
      this.status});

  void approveRequest() {
    status = 'approved';
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'time': time,
        'date': date,
        'phone': phone,
        'seats': seats,
        'status': status,
        'restaurant': restaurantName,
        'rest_ID': restaurant_id
      };

  static fromJson(Map<String, dynamic> json) {
    return ReservationRequest(
      name: json['name'],
      time: json['time'],
      date: json['date'].toDate(),
      phone: json['phone'],
      seats: json['seats'],
      status: json['status'],
      restaurantName: json['restaurant'],
      restaurant_id: json['rest_ID'],
    );
  }

  @override
  String toString() {
    return 'ReservationRequest{name: $name}';
  }

  Map<String, dynamic> ID(var id) => {'Request-ID': id};
}
