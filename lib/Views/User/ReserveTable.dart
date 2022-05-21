import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/ReservationRequest.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:project/Views/User/Widgets/InputBox.dart';
import 'package:project/Views/User/Widgets/RestaurantBanner.dart';
import 'package:provider/provider.dart';

import '../../Providers/UserProvider.dart';
import 'Reservation_Widgets/ButtonOption.dart';
import 'Reservation_Widgets/ReservationDisplay.dart';
import 'Reservation_Widgets/SelectionButton.dart';

class ReserveTable extends StatefulWidget {
  Restaurant restaurant;

  ReserveTable({Key? key, required this.restaurant}) : super(key: key);

  @override
  _ReserveTableState createState() => _ReserveTableState();
}

class _ReserveTableState extends State<ReserveTable> {
  TextStyle h2 = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);

  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();
  String area = 'none';
  int persons = 2;
  String time = 'none';
  bool personSelected = false;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    name.text = context.read<UserProvider>().getName();
    contact.text = context.read<UserProvider>().user.phone.toString();
  }

  Color c = Color(0xFF154038);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            //Image Banner
            RestaurantBanner(
                Name: widget.restaurant.name,
                Cuisine: widget.restaurant.category,
                image: widget.restaurant.image),

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

                      FadeInDown(
                        delay: Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Where do you want to eat?',
                            style: h2,
                          ),
                        ),
                      ),

                      FadeInDown(
                          delay: Duration(milliseconds: 500),
                          child: SeatingAreaButtons(
                            getArea: (value) {
                              area = value;
                            },
                          )),

                      FadeInDown(
                        delay: Duration(milliseconds: 600),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('How many seats?', style: h2),
                              ),
                              SelectionButton(
                                isSeats: true,
                                isDate: false,
                                isTime: false,
                                onSelectPersons: (value) {
                                  persons = value;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      FadeInDown(
                        delay: Duration(milliseconds: 700),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 36),
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
                                      isTime: true,
                                      onSelectTime: (value) {
                                        time = value;
                                      },
                                    )
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
                                        isTime: false,
                                        onSelectDate: (value) {
                                          if (value != 0) {
                                            date = value;
                                            personSelected = true;
                                          } else {
                                            personSelected = false;
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ]),
                        ),
                      ),

                      FadeInDown(
                        delay: Duration(milliseconds: 800),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: InputBox(
                            label: 'Book by name:',
                            hintText: '',
                            icon: Icon(Icons.person, color: Color(0xFF5ABFA3)),
                            controller: name,
                            isNum: false,
                          ),
                        ),
                      ),
                      FadeInDown(
                        delay: Duration(milliseconds: 800),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: InputBox(
                            label: 'Contact Number:',
                            hintText: '',
                            icon: Icon(Icons.phone, color: Color(0xFF5ABFA3)),
                            controller: contact,
                            isNum: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 900),
                    child: Padding(
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
                              textStyle:
                                  TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (area != 'none' &&
                                personSelected &&
                                name.text.isNotEmpty && time != 'none' &&
                                contact.text.isNotEmpty && date != null) {
                              DateTime d = date!;
                              ReservationRequest req = ReservationRequest(
                                  name: name.text,
                                  restaurantName: widget.restaurant.name,
                                  restaurant_id: widget.restaurant.id,
                                  phone: int.parse(contact.text),
                                  seats: persons,
                                  time: time,
                                  date: d,
                                  status: 'pending');

                              context.read<UserProvider>().reserveTable(req);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReservationDisplay(
                                        request: req, fromList: false,
                                      )));
                            }
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

class SeatingAreaButtons extends StatefulWidget {
  Function(String)? getArea;

  SeatingAreaButtons({Key? key, this.getArea}) : super(key: key);

  @override
  _SeatingAreaButtonsState createState() => _SeatingAreaButtonsState();
}

class _SeatingAreaButtonsState extends State<SeatingAreaButtons> {
  String area = 'none';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonOption(
          isSelected: (area == 'Indoor'),
          title: 'Indoor',
          image: 'assets/indoor.png',
          onSelectParam: (String) {
            area = String;
            widget.getArea!(area);
            setState(() {});
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ButtonOption(
            isSelected: (area == 'Outdoor'),
            title: 'Outdoor',
            image: 'assets/outdoor.png',
            onSelectParam: (String) {
              area = String;
              widget.getArea!(area);
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
