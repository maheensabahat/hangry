import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Providers/RestaurantProvider.dart';
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

  var formatter = DateFormat('EE dd-MMM-yy');

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
                  InputBox(
                    label: 'Name',
                    hintText: '',
                    icon: Icon(Icons.person, color: Color(0xFF5ABFA3)),
                    controller:
                        TextEditingController(text: widget.request.name),
                    isNum: false,
                    canEdit: false,
                  ),
                  InputBox(
                    label: 'Date',
                    hintText: '',
                    icon: Icon(Icons.calendar_today, color: Color(0xFF5ABFA3)),
                    controller: TextEditingController(
                        text: formatter.format(widget.request.date)),
                    isNum: false,
                    canEdit: false,
                  ),
                  InputBox(
                    label: 'Time',
                    hintText: '',
                    icon: Icon(Icons.timer_outlined, color: Color(0xFF5ABFA3)),
                    controller:
                        TextEditingController(text: widget.request.time),
                    isNum: false,
                    canEdit: false,
                  ),
                  InputBox(
                    label: 'No. of persons',
                    hintText: 'Pre-filled text field containing no. of persons',
                    icon: Icon(Icons.group, color: Color(0xFF5ABFA3)),
                    controller: TextEditingController(
                        text: widget.request.seats.toString()),
                    isNum: false,
                    canEdit: false,
                  ),
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
