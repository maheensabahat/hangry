import 'package:flutter/material.dart';
import 'package:project/Views/User/OrderSummary.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';
import 'package:provider/provider.dart';
import '../../../Entities/My_Order.dart';
import '../../../Providers/UserProvider.dart';

class Order extends StatelessWidget {
  String name;
  MyOrder order;
  String image;

  Order(
      {Key? key, required this.name, required this.order, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 90,
              decoration: const BoxDecoration(
                color: Color(0xF0ADD9C9),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    bottomRight: Radius.circular(30)),
              ),
            ),
          ),
          Picture(
            radius: 35,
            border: 3,
            image: image,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Color(0xFF154038),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                if (!order.isPlaced) ...[
                  const Text(
                    'is deciding..',
                    style: TextStyle(
                        color: Color(0xFF154038),
                        fontSize: 13,
                        fontStyle: FontStyle.italic),
                  ),
                ] else ...[
                  name == 'You'
                      ? const Text(
                          'have placed order',
                          style: TextStyle(
                              color: Color(0xFF154038),
                              fontSize: 13,
                              fontStyle: FontStyle.italic),
                        )
                      : const Text(
                          'has placed order',
                          style: TextStyle(
                              color: Color(0xFF154038),
                              fontSize: 13,
                              fontStyle: FontStyle.italic),
                        )
                ],
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24, bottom: 35),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OrderSummary(name: name, order: order)),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30, bottom: 20),
                child: Text(
                  'Total: ' + '  ' + '\$ ' + order.Total().toString(),
                  style: const TextStyle(
                    color: Color(0xFF154038),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
