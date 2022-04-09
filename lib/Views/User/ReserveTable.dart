import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:project/Views/User/Widgets/InputBox.dart';
import 'package:project/Views/User/Widgets/RestaurantBanner.dart';
import 'package:intl/intl.dart';

class ReserveTable extends StatefulWidget {
  const ReserveTable({Key? key}) : super(key: key);

  @override
  _ReserveTableState createState() => _ReserveTableState();
}

class _ReserveTableState extends State<ReserveTable> {
  TextStyle h2 = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();

  Color c = Color(0xFF154038);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            //Image Banner
            RestaurantBanner(
                Name: "Restaurant's Name",
                Cuisine: 'Cuisine',
                image: 'assets/restaurant.jpg'),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Column(
                    children: [
                      //Heading
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 30),
                        child: Text(
                          'Reserve Table',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Where do you want to eat?',
                          style: h2,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonOption(
                              title: 'Indoor', image: 'assets/indoor.png'),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: ButtonOption(
                                title: 'Outdoor', image: 'assets/outdoor.png'),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('How many seats?', style: h2),
                            ),
                          ],
                        ),
                      ),

                      SelectionButton(
                        isSeats: true,
                        isDate: false,
                        isTime: false,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 36),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Time',
                                      style: h2,
                                    ),
                                  ),
                                  SelectionButton(
                                      isSeats: false,
                                      isDate: false,
                                      isTime: true)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 36),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Date', style: h2),
                                    ),
                                    SelectionButton(
                                        isSeats: false,
                                        isDate: true,
                                        isTime: false)
                                  ],
                                ),
                              )
                            ]),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InputBox(
                            label: 'Book by name:',
                            hintText: '',
                            icon: Icon(Icons.person, color: Color(0xFF5ABFA3)),
                            controller: name),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: InputBox(
                            label: 'Contact Number:',
                            hintText: '',
                            icon: Icon(Icons.phone, color: Color(0xFF5ABFA3)),
                            controller: contact),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 80, right: 80, bottom: 50),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF5ABFA3),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            textStyle: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          // Navigator.of(context).push(widget.next_page);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: const Text('Confirm Reservation'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: BackButton());
  }
}

class ButtonOption extends StatefulWidget {
  String title;
  String image;
  bool isSelected = false;

  ButtonOption({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  _ButtonOptionState createState() => _ButtonOptionState();
}

class _ButtonOptionState extends State<ButtonOption> {
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
              Image.asset(
                widget.image,
                width: 50,
                height: 50,
                color: Color(0xFF154038),
              ),
              Text(
                widget.title,
                style: TextStyle(color: Color(0xFF154038), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        widget.isSelected = !widget.isSelected;
        setState(() {});
      },
    );
  }
}

class SelectionButton extends StatefulWidget {
  bool isSeats;
  bool isDate;
  bool isTime;
  bool isSelected = false;

  SelectionButton(
      {Key? key,
      required this.isSeats,
      required this.isDate,
      required this.isTime})
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
          } else {
            seats = 2;
          }
          setState(() {});
        } else if (widget.isDate) {
          await _selectDate(context);
          widget.isSelected = true;
          setState(() {});
        } else if (widget.isTime) {
          String t = await _selectTime(context);
          Time = t;
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

  Future<void> _selectDate(BuildContext context) async {
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
    } else {
      var formatter = DateFormat('dd');
      day = formatter.format(defaultdate);
      formatter = DateFormat('MMM, y');
      MMyy = formatter.format(defaultdate);
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
