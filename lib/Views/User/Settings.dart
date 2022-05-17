import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Views/User/Widgets/Header.dart';
import 'package:provider/provider.dart';

import '../../Entities/User.dart';
import '../../Providers/GoogleSignInProvider.dart';
import '../../Providers/UserProvider.dart';
import '../../main.dart';
import 'Widgets/InputBox.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var buttonStyle = ElevatedButton.styleFrom(
    elevation: 3,
    onPrimary: Color(0xFF154038),
    primary: Color(0xE05ABFA3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    textStyle: TextStyle(fontWeight: FontWeight.bold),
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Header(
            title: 'Settings',
            bottom: 60,
          ),
          FadeInLeft(
            delay: Duration(milliseconds: 500),
            child: SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  EditProfile(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_outline),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: const Text('Edit your Profile'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          FadeInRight(
            delay: Duration(milliseconds: 600),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    NotAvailable(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: const Text('About Hangry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FadeInLeft(
            delay: Duration(milliseconds: 700),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    NotAvailable(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.help_outline_outlined),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: const Text('Help'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FadeInRight(
            delay: Duration(milliseconds: 600),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    context.read<GoogleSignInProvider>().signOut();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage(title: '')),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> EditProfile(BuildContext context) async {
    nameController.text = context.read<UserProvider>().user.name!;
    phoneController.text = context.read<UserProvider>().user.phone!.toString();

    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Edit you Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              content: Container(
                height: 210,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputBox(
                        label: 'Name',
                        hintText: 'Enter full name',
                        icon:
                            const Icon(Icons.person, color: Color(0xFF5ABFA3)),
                        controller: nameController,
                        isNum: false,
                      ),

                      //Phone
                      InputBox(
                          label: 'Phone Number',
                          hintText: '03xx-xxxxxxx',
                          icon:
                              const Icon(Icons.phone, color: Color(0xFF5ABFA3)),
                          controller: phoneController,
                          isNum: true),
                    ],
                  ),
                ),
              ),
              actions: [
                FlatButton(
                  color: Color(0xFF5FBFA3),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      User user = context.read<UserProvider>().user;
                      user.name = nameController.text;
                      user.phone = int.parse(phoneController.text);
                      Provider.of<UserProvider>(context, listen: false)
                          .updateUser(user);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                FlatButton(
                  color: Color(0xFF5FBFA3),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ));
  }

  Future<void> NotAvailable(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Not Available',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              content: Container(
                height: 100,
                child: Image.asset('assets/Hangry.png'),
              ),
            ));
  }
}
