import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Views/User/Reservation_Widgets/RequestDetails.dart';
import 'package:provider/provider.dart';
import '../../Entities/ReservationRequest.dart';
import '../User/Widgets/InputBox.dart';

class ReservationRequests extends StatefulWidget {
  String type;
  ReservationRequest request;

  ReservationRequests({Key? key, required this.type, required this.request})
      : super(key: key);

  @override
  _ReservationRequestsState createState() => _ReservationRequestsState();
}

class _ReservationRequestsState extends State<ReservationRequests> {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Color(0xFF154038),
      primary: Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      textStyle: TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text('Reservation Request',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.clear, color: Colors.black)),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Column(
                children: [
                  RequestDetails(request: widget.request, isUser: false),
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
                                .approveRequest(widget.request.id);
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Approve'),
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
