import 'package:flutter/material.dart';
import 'Views/User/Widgets/InputBox.dart';

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
      onPrimary: Colors.black,
      primary: Colors.red,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TableR_tile'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                child: Column(
                  children: [
                    InputBox(
                      label: 'User name',
                      hintText: 'Pre-filled text field',
                      icon: Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    InputBox(
                      label: 'Table reserved',
                      hintText: 'Pre-filled text field containing table no.',
                      icon: Icon(Icons.chair, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    InputBox(
                      label: 'Time table reserved on',
                      hintText: 'Pre-filled text field containing time',
                      icon: Icon(Icons.timer_outlined, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    InputBox(
                      label: 'No. of persons',
                      hintText: 'Pre-filled text field containing no. of persons',
                      icon: Icon(Icons.group,
                          color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    SizedBox(
                      width: 220,
                      height: 40,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) => Approved_tables()));
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
                          //     MaterialPageRoute(builder: (context) => Rejected_Tables()));
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
