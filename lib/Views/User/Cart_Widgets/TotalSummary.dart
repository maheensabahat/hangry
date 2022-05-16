import 'package:flutter/material.dart';
import 'package:project/Providers/OrdersProvider.dart';
import 'package:project/Providers/ScanProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:provider/provider.dart';

import '../../../Entities/ShoppingCart.dart';

class Summary extends StatefulWidget {
  Summary({
    Key? key,
  }) : super(key: key);

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Grand Total:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  '\$ ' +
                      context
                          .watch<OrdersProvider>()
                          .getTotalPrice(
                              myOrder:
                                  context.read<ScanProvider>().getOrderList())
                          .toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Tax:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  '\$ ' +
                      (context.watch<OrdersProvider>().getTotalPrice(
                                  myOrder: context
                                      .read<ScanProvider>()
                                      .getOrderList()) *
                              0.13)
                          .toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Net Total:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    '\$ ' +
                        (context.watch<OrdersProvider>().getTotalPrice(
                                    myOrder: context
                                        .read<ScanProvider>()
                                        .getOrderList()) *
                                1.13)
                            .toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
