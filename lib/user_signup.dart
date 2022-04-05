import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/InputBox.dart';
import 'package:project/MainPage.dart';

class User_Signup extends StatefulWidget {
  const User_Signup({Key? key}) : super(key: key);

  @override
  _User_SignupState createState() => _User_SignupState();
}

class _User_SignupState extends State<User_Signup> {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset(
                'assets/Pasta.png',
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: const Text(
                'Sign Up',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                'Provide the following details to continue:',
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                children: [
                  InputBox(
                    label: 'Name',
                    hintText: 'Enter full name',
                    icon: Icon(Icons.person, color: Color(0xFF5ABFA3)),
                    controller: TextEditingController(),
                  ),
                  InputBox(
                    label: 'Phone Number',
                    hintText: '03xx-xxxxxxx',
                    icon: Icon(Icons.phone, color: Color(0xFF5ABFA3)),
                    controller: TextEditingController(),
                  ),
                  InputBox(
                    label: 'Location',
                    hintText: 'eg. Karachi',
                    icon: Icon(Icons.location_on, color: Color(0xFF5ABFA3)),
                    controller: TextEditingController(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10, bottom: 24),
                    child: SizedBox(
                      width: 220,
                      height: 40,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MainPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Continue'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
