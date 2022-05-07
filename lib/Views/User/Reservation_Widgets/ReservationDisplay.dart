import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ReservationDisplay extends StatefulWidget {
  const ReservationDisplay({Key? key}) : super(key: key);

  @override
  _ReservationDisplayState createState() => _ReservationDisplayState();
}

class _ReservationDisplayState extends State<ReservationDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15, left: 30),
                child: Center(
                    child: FadeInRight(
                  delay: Duration(seconds: 1),
                  child: Text(
                    'Reservation Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.45,
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
                  )),
              FadeInLeft(
                delay: Duration(seconds: 1),
                child: Image.asset(
                  'assets/reserve.png',
                  height: 500,
                ),
              ),
            ],
          ),

          //Restaurant Name
          //Seating Area
          //seats
          //Time, Date
          //Name
          //Contact


        ],
      ),
    );
  }
}
