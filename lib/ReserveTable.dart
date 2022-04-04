import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/InputBox.dart';

class ReserveTable extends StatefulWidget {
  const ReserveTable({Key? key}) : super(key: key);

  @override
  _ReserveTableState createState() => _ReserveTableState();
}

class _ReserveTableState extends State<ReserveTable> {
  TextStyle h2 = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/restaurant.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: 258,
                  color: const Color.fromRGBO(255, 255, 255, 0.4),
                  colorBlendMode: BlendMode.modulate),
              const Text(
                "Restaurant's Name",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: const Text(
                  'Cuisine',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 240),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border(
                        top: BorderSide(width: 2, color: Color(0xFF5ABFA3))),
                  ),
                  child: Text(''),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text(
                        'Reserve Table',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF5ABFA3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/googlelogo.png',
                                    width: 50, height: 50),
                                Text('Indoor'),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF5ABFA3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/googlelogo.png',
                                      width: 50, height: 50),
                                  Text('Outdoor'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Column(
                        children: [
                          Text('How many seats?', style: h2),
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF5ABFA3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/googlelogo.png',
                                      width: 50, height: 50),
                                  Text('Seats'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 36),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Date',
                                  style: h2,
                                ),
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5ABFA3),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/googlelogo.png',
                                            width: 50, height: 50),
                                        Text('Date'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 36),
                              child: Column(
                                children: [
                                  Text('Time', style: h2),
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF5ABFA3),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/googlelogo.png',
                                              width: 50, height: 50),
                                          Text('Time'),
                                        ],
                                      ),
                                    ),
                                  ),
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
                  padding: const EdgeInsets.only(left: 150, right: 150, bottom: 48),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Color(0xFF154038),
                          primary: Color(0xFF5ABFA3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          textStyle: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                          // Navigator.of(context).push(widget.next_page);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/googlelogo.png',
                              width: 22, height: 22),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: const Text('Continue with Google'),
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
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Color(0xFFADD9C9),
        foregroundColor: Color(0xFF5ABFA3),
      ),
    );
  }
}
