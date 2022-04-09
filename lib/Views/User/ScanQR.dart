import 'package:flutter/material.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:project/Views/User/UserMenu.dart';

import '../../Entities/User.dart';
import '../../Entities/cart.dart';

class ScanQR extends StatefulWidget {
  Restaurant restaurant;
  User user;

  ScanQR({Key? key, required this.user, required this.restaurant})
      : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Scan QR',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Camera will open here',
                style: TextStyle(fontSize: 20),
              ),
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2.7,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.7,
              color: const Color(0xff51bfa3),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (!widget.user.qr) {
                    widget.user.qr = true;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            UserMenu(
                              user: widget.user,
                              scanned: true,
                              restaurant: widget.restaurant,
                            )));
                  }
                },
                backgroundColor: Color(0xFF5ABFA3),
                label: Text('Next'),
                icon: Icon(Icons.arrow_forward),
              ),
            )
          ],
        ),
      ),
    );
  }
}
