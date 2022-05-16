import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Views/Restaurant/ReservationRequests.dart';

import '../../../Entities/ReservationRequest.dart';
import '../Widgets/InputBox.dart';

class RequestDetails extends StatelessWidget {
  ReservationRequest request;
  bool isUser;

  RequestDetails({Key? key, required this.request, required this.isUser})
      : super(key: key);

  var formatter = DateFormat('EE dd-MMM-yy');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputBox(
          label: !isUser ? 'Name' : 'Restaurant',
          hintText: '',
          icon: Icon(!isUser ? Icons.person : Icons.restaurant,
              color: Color(0xFF5ABFA3)),
          controller: TextEditingController(
              text: !isUser ? request.name : request.restaurantName),
          isNum: false,
          canEdit: false,
        ),
        !isUser
            ? InputBox(
                label: 'Contact',
                hintText: '',
                icon: Icon(Icons.phone, color: Color(0xFF5ABFA3)),
                controller:
                    TextEditingController(text: request.phone.toString()),
                isNum: false,
                canEdit: false,
              )
            : Container(),
        InputBox(
          label: 'Date',
          hintText: '',
          icon: Icon(Icons.calendar_today, color: Color(0xFF5ABFA3)),
          controller:
              TextEditingController(text: formatter.format(request.date)),
          isNum: false,
          canEdit: false,
        ),
        InputBox(
          label: 'Time',
          hintText: '',
          icon: Icon(Icons.timer_outlined, color: Color(0xFF5ABFA3)),
          controller: TextEditingController(text: request.time),
          isNum: false,
          canEdit: false,
        ),
        InputBox(
          label: 'No. of persons',
          hintText: 'Pre-filled text field containing no. of persons',
          icon: Icon(Icons.group, color: Color(0xFF5ABFA3)),
          controller: TextEditingController(text: request.seats.toString()),
          isNum: false,
          canEdit: false,
        ),
      ],
    );
  }
}
