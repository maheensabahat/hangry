import 'package:flutter/material.dart';
import 'package:project/Entities/My_Order.dart';
import 'package:project/Entities/OrderItem.dart';
import 'package:project/Providers/OrdersProvider.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:provider/provider.dart';

class OrderSummaryCart extends StatefulWidget {
  String name;
  MyOrder order;

  OrderSummaryCart({Key? key, required this.name, required this.order})
      : super(key: key);

  @override
  State<OrderSummaryCart> createState() => _OrderSummaryCartState();
}

class _OrderSummaryCartState extends State<OrderSummaryCart> {
  @override
  Widget build(BuildContext context) {
    String name = '';
    widget.name == 'You' ? name = widget.name + 'r' : name = widget.name + "'s";
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Text(
            name + " Order",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemExtent: 100,
                  itemCount: widget.order.list.length,
                  itemBuilder: ((context, index) {
                    OrderItem item = widget.order.list[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
                      child: Container(
                        alignment: const Alignment(0, 0),
                        decoration: BoxDecoration(
                            color: Color(0xC0ADD9C9),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        height: 80,
                        child: ListTile(
                            title: Text(
                              item.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              item.quantity.toString() +
                                  ' x \$ ' +
                                  item.price.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      item.image,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ))),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 90,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Items: ' + widget.order.list.length.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total: \$ ' + widget.order.Total().toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
