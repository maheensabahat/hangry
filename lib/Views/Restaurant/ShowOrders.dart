import 'package:flutter/material.dart';
import 'package:project/Entities/OrdersHistory.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Views/Restaurant/OrderDetails.dart';
import 'package:provider/provider.dart';

class ShowOrders extends StatefulWidget {
  String type;
  OrdersHistory request;

  ShowOrders({Key? key, required this.type, required this.request})
      : super(key: key);

  @override
  _ShowOrdersState createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: const Color(0xFF154038),
      primary: const Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text('Orders',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.clear, color: Colors.black)),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Column(
                children: [
                  OrderDetails(request: widget.request, isUser: false),
                  if (widget.type == 'pending') ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        width: 130,
                        height: 45,
                        child: ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            context
                                .read<RestaurantProvider>()
                                .approveOrder(widget.request.restaurant_id);
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Approve'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        width: 130,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary:  Colors.red,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),),
                              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            context
                                .read<RestaurantProvider>()
                                .rejectOrder(widget.request.restaurant_id);
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Reject'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ));
  }
}
