import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Views/User/Widgets/InputBox.dart';
import 'package:project/Views/User/MainPage.dart';
import 'package:project/Entities/User.dart';
import 'package:provider/provider.dart';

import '../../Providers/GoogleSignInProvider.dart';
import '../../Providers/UserProvider.dart';

class User_Signup extends StatefulWidget {
  const User_Signup({Key? key}) : super(key: key);

  @override
  _User_SignupState createState() => _User_SignupState();
}

class _User_SignupState extends State<User_Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Color(0xFF154038),
      primary: const Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  setController(TextEditingController controller, String text) {
    controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    setController(nameController, context.read<UserProvider>().getName());
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
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                'Sign Up',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Provide the following details to continue:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
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
                    InputBox(
                      label: 'Name',
                      hintText: 'Enter full name',
                      icon: const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: nameController,
                    ),

                    //Phone
                    InputBox(
                      label: 'Phone Number',
                      hintText: '03xx-xxxxxxx',
                      icon: const Icon(Icons.phone, color: Color(0xFF5ABFA3)),
                      controller: phoneController,
                    ),

                    //Location
                    InputBox(
                      label: 'Location',
                      hintText: 'eg. Karachi',
                      icon: const Icon(Icons.location_on,
                          color: Color(0xFF5ABFA3)),
                      controller: locationController,
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
                              context
                                  .read<UserProvider>()
                                  .setName(nameController.text);
                              context
                                  .read<UserProvider>()
                                  .setPhone(phoneController.text);
                              context
                                  .read<UserProvider>()
                                  .setLocation(locationController.text);

                              User user =
                                  context.read<UserProvider>().getUser();

                              context.read<UserProvider>().addUser(user);

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainPage()));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('Continue'),
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
