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
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: const Text('Restaurant Details'),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
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
                      label: 'Restaurant Name',
                      hintText: 'Pre-filled data with Restaurant name',
                      icon: Icon(Icons.restaurant, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    InputBox(
                      label: 'Owner\'s name',
                      hintText: 'Pre-filled data with Owner\'s name',
                      icon: Icon(Icons.person, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    InputBox(
                      label: 'Cuisines Served',
                      hintText: 'Pre-filled data with cuisines served',
                      icon: Icon(Icons.fastfood, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    InputBox(
                      label: 'Timings',
                      hintText:
                          'Pre-filled data with open timings for the restaurant',
                      icon: Icon(Icons.access_time_outlined,
                          color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    InputBox(
                      label: 'Restaurant\'s Location',
                      hintText: 'Pre-filled data with Restaurant\'s locationss',
                      icon: Icon(Icons.location_on, color: Color(0xFF5ABFA3)),
                      controller: TextEditingController(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        width: 220,
                        height: 40,
                        child: ElevatedButton(
                          style: buttonStyle,
                          onPressed: () {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (context) => Approved_Signups()));
                          },
                          //if clicked on approved it will add to the approved list in next phase
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Approve'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: SizedBox(
                        width: 220,
                        height: 40,
                        child: ElevatedButton(
                          style: buttonStyle2,
                          onPressed: () {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (context) => Rejected_Signups()));
                          },
                          //if clicked on rejected it will add to the rejected list in next phase
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Reject'),
                            ],
                          ),
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
