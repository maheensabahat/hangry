import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

class SelectionButton extends StatefulWidget {
  bool isSeats;
  bool isDate;
  bool isTime;
  bool isSelected = false;
  Function(int)? onSelectPersons;
  Function(String)? onSelectTime;
  Function(DateTime)? onSelectDate;

  SelectionButton(
      {Key? key,
      required this.isSeats,
      required this.isDate,
      required this.isTime,
      this.onSelectPersons,
      this.onSelectTime,
      this.onSelectDate})
      : super(key: key);

  @override
  _SelectionButtonState createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  int seats = 2;
  late String day;
  late String MMyy;
  DateTime defaultdate = DateTime.now();
  String Time = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var formatter = DateFormat('dd');
    day = formatter.format(defaultdate);
    formatter = DateFormat('MMM, y');
    MMyy = formatter.format(defaultdate);
    Time = 'Time';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: 80,
        height: 80,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xFF5ABFA3) : Color(0xF0ADD9C9),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isSeats) ...[
                Text(seats.toString(),
                    style: TextStyle(
                        color: Color(0xFF154038),
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                Text('Seats',
                    style: TextStyle(color: Color(0xFF154038), fontSize: 13)),
              ] else ...[
                if (widget.isDate) ...[
                  Text(day,
                      style: TextStyle(
                          color: Color(0xFF154038),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(MMyy,
                        style:
                            TextStyle(color: Color(0xFF154038), fontSize: 10)),
                  )
                ] else ...[
                  if (checkTime('Time'))
                    Icon(Icons.access_time_filled_rounded,
                        size: 25, color: Color(0xFF154038))
                  else if (checkTime('Breakfast'))
                    Icon(Icons.wb_sunny_rounded,
                        size: 25, color: Color(0xFF154038))
                  else if (checkTime('Lunch'))
                    Icon(Icons.lunch_dining_rounded,
                        size: 25, color: Color(0xFF154038))
                  else if (checkTime('Dinner'))
                    Icon(Icons.nights_stay_rounded,
                        size: 25, color: Color(0xFF154038)),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(Time,
                        style:
                            TextStyle(color: Color(0xFF154038), fontSize: 12)),
                  ),
                ]
              ]
            ],
          ),
        ),
      ),
      onTap: () async {
        widget.isSelected = false;
        setState(() {});
        if (widget.isSeats) {
          int s = await _showNumberPickerDialog();
          if (s != 0) {
            widget.isSelected = true;
            widget.onSelectPersons!(seats);
          } else {
            seats = 2;
            widget.onSelectPersons!(0);
          }

          setState(() {});
        } else if (widget.isDate) {
          DateTime d = await _selectDate(context);
          widget.onSelectDate!(d);
          widget.isSelected = true;
          setState(() {});
        } else if (widget.isTime) {
          String t = await _selectTime(context);
          Time = t;
          widget.onSelectTime!(Time);
          setState(() {});
          widget.isSelected = true;
        }
      },
    );
  }

  Future _showNumberPickerDialog() async {
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Pick a number:',
          style: TextStyle(fontSize: 15),
        ),
        content: StatefulBuilder(
          builder: (context, SBsetState) {
            return NumberPicker(
              value: seats,
              minValue: 2,
              maxValue: 10,
              step: 1,
              axis: Axis.horizontal,
              onChanged: (value) {
                setState(() => seats = value);
                SBsetState(() => seats = value);
              },
            );
          },
        ),
        actions: [
          TextButton(
            child: Text(
              "OK",
              style: TextStyle(color: Color(0xFF5ABFA3)),
            ),
            onPressed: () {
              Navigator.of(context).pop(seats);
            },
          ),
          TextButton(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Color(0xFF5ABFA3)),
            ),
            onPressed: () {
              Navigator.of(context).pop(0);
            },
          )
        ],
      ),
    );
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF5ABFA3), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Color(0xFF5ABFA3), // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: Color(0xFF5ABFA3),
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold) // button text color
                  ),
            ),
            // dialogBackgroundColor: Color(0xA0ADD9C9),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      var formatter = DateFormat('dd');
      day = formatter.format(picked);
      formatter = DateFormat('MMM, y');
      MMyy = formatter.format(picked);
      return picked;
    } else {
      var formatter = DateFormat('dd');
      day = formatter.format(defaultdate);
      formatter = DateFormat('MMM, y');
      MMyy = formatter.format(defaultdate);
      return defaultdate;
    }
  }

  Future<String> _selectTime(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select time of a day to dine in:',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        content: Container(
          height: 180,
          child: Column(
            children: [
              _timeofDay('Breakfast'),
              _timeofDay('Lunch'),
              _timeofDay('Dinner'),
            ],
          ),
        ),
      ),
    );
  }

  bool checkTime(String title) => Time == title;

  Widget _timeofDay(String title) {
    return FlatButton(
      color: Color(0xFF5ABFA3),
      onPressed: () {
        Navigator.of(context).pop(title);
      },
      child: Text(
        title,
      ),
    );
  }
}
