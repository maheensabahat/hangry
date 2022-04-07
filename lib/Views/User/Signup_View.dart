import 'package:flutter/material.dart';

import 'Widgets/InputBox.dart';

class Signup_View extends StatefulWidget {
  const Signup_View({Key? key}) : super(key: key);

  @override
  _Signup_ViewState createState() => _Signup_ViewState();
}

class _Signup_ViewState extends State<Signup_View> {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Color(0xFF154038),
      primary: Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: TextStyle(fontWeight: FontWeight.bold));
  final ButtonStyle buttonStyle2 = ElevatedButton.styleFrom(
      onPrimary: Colors.red,
      primary: Colors.red,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: TextStyle(fontWeight: FontWeight.bold));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Signup_View'),
        ),
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Column(
              children: [
                InputBox(
                  label: 'Restaurant Name',
                  hintText: 'Enter your restaurant name',
                  icon: Icon(Icons.restaurant, color: Color(0xFF5ABFA3)),
                  controller: TextEditingController(),
                ),
                InputBox(
                  label: 'Owner\'s name' ,
                  hintText: 'Enter your full name',
                  icon: Icon(Icons.person, color: Color(0xFF5ABFA3)),
                  controller: TextEditingController(),
                ),
                InputBox(
                  label: 'Cuisines Served',
                  hintText: 'eg. Chinese',
                  icon: Icon(Icons.fastfood, color: Color(0xFF5ABFA3)),
                  controller: TextEditingController(),
                ),
                InputBox(
                  label: 'Timings',
                  hintText: 'eg. 11:00 - 23:00',
                  icon: Icon(Icons.access_time_outlined, color: Color(0xFF5ABFA3)),
                  controller: TextEditingController(),
                ),
                InputBox(
                  label: 'Restaurant\'s Location',
                  hintText: 'eg. Karachi',
                  icon: Icon(Icons.location_on, color: Color(0xFF5ABFA3)),
                  controller: TextEditingController(),
                ),
                SizedBox(
                  width: 220,
                  height: 40,
                  child: ElevatedButton(
                    style: buttonStyle,
                    onPressed: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Approved_Signups()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Approve'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 220,
                  height: 40,
                  child: ElevatedButton(
                    style: buttonStyle2,
                    onPressed: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => Rejected_Signups()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Reject'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
