import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/UserProvider.dart';
import '../MyOrders.dart';
import '../User_TableReservations.dart';

class buttons extends StatelessWidget {
  bool istable;
  String icon;
  double width;
  double height;
  String name;

  buttons(
      {Key? key,
        required this.name,
        required this.icon,
        required this.width,
        required this.height,
        required this.istable})
      : super(key: key);

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: const Color(0xFF154038),
      primary: const Color(0xFF5ABFA3),
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 100,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              if (istable) {
                context.read<UserProvider>().getRequests('pending');
                context.read<UserProvider>().getRequests('approved');
                return const UserTableReservations();
              }
              return const MyOrders();
            }),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Image.asset(icon, width: width, height: height),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  name,
                  style:
                  const TextStyle(fontSize: 12, color: Color(0xFFf2f2f2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
