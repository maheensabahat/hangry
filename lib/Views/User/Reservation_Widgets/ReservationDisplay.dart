import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/ReservationRequest.dart';
import 'package:project/Views/User/Reservation_Widgets/RequestDetails.dart';

import '../MainPage.dart';

class ReservationDisplay extends StatefulWidget {
  ReservationRequest request;
  bool fromList;

  ReservationDisplay({Key? key, required this.request, required this.fromList})
      : super(key: key);

  @override
  _ReservationDisplayState createState() => _ReservationDisplayState();
}

class _ReservationDisplayState extends State<ReservationDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.12, left: 35),
                  child: Center(
                      child: FadeInRight(
                    delay: Duration(seconds: 1),
                    child: Text(
                      'Reservation Details',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
                ),
                Container(
                  height: 305,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0x405ABFA3),
                      Color(0x205ABFA3),
                      Color(0x0A5ABFA3),
                      Color(0x075ABFA3),
                      Color(0x205ABFA3),
                      Color(0x405ABFA3),
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                Positioned(
                  width: 300,
                  top: 60,
                  left: 30,
                  child: FadeInLeft(
                    delay: Duration(seconds: 1),
                    child: Image.asset(
                      'assets/reserve.png',
                      height: 300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  child: InkWell(
                      onTap: () {
                        if (widget.fromList) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MainPage()));
                        }
                      },
                      child: Icon(Icons.clear, color: Colors.black)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: RequestDetails(request: widget.request, isUser: true),
            ),
          ],
        ),
      ),
    );
  }
}
