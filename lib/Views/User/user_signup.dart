import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Views/User/Widgets/InputBox.dart';
import 'package:project/Views/User/MainPage.dart';
import 'package:project/Entities/User.dart';
import 'package:project/Views/User/Profile.dart';

class User_Signup extends StatefulWidget {
  const User_Signup({Key? key}) : super(key: key);

  @override
  _User_SignupState createState() => _User_SignupState();
}

class _User_SignupState extends State<User_Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var name;
  var phone;
  var location;

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: const Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Image.asset(
                'assets/Pasta.png',
                width: 200,
                height: 200,
              ),
            ),

            //SignUp Header
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

            //Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //Name
                    name = InputBox(
                      label: 'Name',
                      hintText: 'Enter full name',
                      icon: Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),

                    //Phone
                    phone = InputBox(
                      label: 'Phone Number',
                      hintText: '03xx-xxxxxxx',
                      icon: Icon(Icons.phone, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),

                    //Location
                    location = InputBox(
                      label: 'Location',
                      hintText: 'eg. Karachi',
                      icon: Icon(Icons.location_on, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),

                    //Continue Button
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 24),
                      child: SizedBox(
                        width: 220,
                        height: 40,
                        child: ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            if (validate()) {
                              User user = User(
                                  name.controller.text,
                                  int.parse(phone.controller.text),
                                  location.controller.text);
                                  print(user);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainPage(user: user)));
                            }
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
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validate() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
