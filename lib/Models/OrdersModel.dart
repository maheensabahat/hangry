
class OrdersModel {
  final String UserEmail;
  final String RestEmail;
  List<String> products = [];
  final int total;
  late var id;
  final int TableNum;
  late String qrID;
  var status = 'Pending';


  OrdersModel({required this.UserEmail,
    this.id,
    required this.RestEmail,
    required this.TableNum,
    required this.products,
    required this.total,
    required this.qrID,
    required this.status});

  static fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      UserEmail: json['UserId'],
      RestEmail: json['RestId'],
      TableNum: json['TableNum'],
      products: json['products'],
      total: json['total'],
      qrID: json['qrID'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'UserId': UserEmail,
        'RestId': RestEmail,
        'TableNum': TableNum,
        'products': products,
        'total': total,
        'qrID': qrID,
        'status': status
      };
}
