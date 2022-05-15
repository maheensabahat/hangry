class Orders {
  late String id;
  final String restaurant_id;
  List<String>? product_ids = [];
  final String user_id;
  final String qr_id;
  final String order_status;
  final String tableNum;

  Orders({
    required this.restaurant_id,
    required this.user_id,
    required this.qr_id,
    this.product_ids,
    required this.order_status,
    required this.tableNum,

  });
}
