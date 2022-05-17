class OrdersHistory {
  String? status = 'pending';
  String user_id;
  String time;
  String table_num;
  DateTime date;
  String qr_id;
  List product_details;
  String restaurant_id;

  //user
  //rest

  OrdersHistory(
      {required this.qr_id,
        required this.restaurant_id,
        required this.product_details,
        required this.table_num,
        required this.time,
        required this.user_id,
        required this.date,
        this.status});

  void approveRequest() {
    status = 'approved';
  }

  Map<String, dynamic> toJson() => {
    'qr_id': qr_id,
    'time': time,
    'date': date,
    'table_num': table_num,
    'user_id': user_id,
    'status': status,
    'product_details': product_details,
    'restaurant_id': restaurant_id
  };

  static fromJson(Map<String, dynamic> json) {
    return OrdersHistory(
      qr_id: json['qr_id'],
      time: json['time'],
      date: json['date'].toDate(),
      table_num: json['table_num'],
      user_id: json['user_id'],
      status: json['status'],
      product_details: json['product_details'],
      restaurant_id: json['restaurant_id'],
    );
  }

  @override
  String toString() {
    return 'OrdersHistory{restaurant_id: $restaurant_id}';
  }

  Map<String, dynamic> ID(var id) => {'Request-ID': id};
}
