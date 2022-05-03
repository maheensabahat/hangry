import 'User.dart';

class ShoppingCart {
  late List<User> friends = [];
  bool confirmOrder = false;

  double orderTotal() {
    double total = 0;
    friends.forEach((element) {
      total += element.currentOrder.Total();
    });
    return total;
  }

  //to check if all friends have placed order
  void checkAlldone() {
    friends.forEach((element) {
      if (!element.currentOrder.isPlaced) {
        confirmOrder = false;
        return;
      }
    });
    confirmOrder = true;
  }
}
