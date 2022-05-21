import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Entities/OrdersHistory.dart';
import 'package:provider/provider.dart';
import '../../Entities/Order_details.dart';
import '../../Providers/RestaurantProvider.dart';
import '../User/Widgets/InputBox.dart';

class OrderDetails extends StatelessWidget {
  OrdersHistory request;
  String type;

  OrderDetails({Key? key, required this.request, required this.type})
      : super(key: key);

  var formatter = DateFormat('EE dd-MMM-yy');

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
            "Viewing Order",
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
                  itemCount: request.product_details?.length,
                  itemBuilder: ((context, index) {
                    ProductDetails item = request.product_details![index];
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
                              )),
                        ),
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
                            'Items: ' +
                                request.product_details!.length.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Total: \$ ' +
                                getTotal(request.product_details).toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (type == 'Pending') ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 35,
                        child: ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            context
                                .read<RestaurantProvider>()
                                .approveOrder(request.id);
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: 100,
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              context
                                  .read<RestaurantProvider>()
                                  .rejectOrder(request.id);
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
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  double getTotal(List<ProductDetails>? product_details) {
    double sum = 0;
    product_details?.forEach((element) {
      sum += (element.price * element.quantity);
    });
    return sum;
  }
}
