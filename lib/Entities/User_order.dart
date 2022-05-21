import 'package:project/Entities/Order_details.dart';

class UserOrders {
  late String id;
  final String restaurant_id;
  List<ProductDetails>? product_details = [];
  final String user_id;
  final String qr_id;
  final String order_status;
  final String tableNum;
  late String date;
  final String restaurant_name;

  UserOrders({
    required this.restaurant_name,
    required this.restaurant_id,
    required this.user_id,
    required this.qr_id,
    this.product_details,
    required this.order_status,
    required this.tableNum,
  });
}
