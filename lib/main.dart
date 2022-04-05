import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/user_signup.dart';
import 'RestaurantMenu.dart';
import 'RestaurantEditDish.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF2F2F2),
      ),
       // darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: const RestaurantMenu(),
      //home: const RestaurantEditDish(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Color(0xFF154038),
      primary: Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //Logo
            //Heading
            const Text(
              'Welcome to Hangry!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            //Sub heading
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 24),
              child: Text(
                'Food you love with amazing discounts \n all in one place.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 48),
              child: SizedBox(
                width: 220,
                height: 40,
                child: ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => User_Signup()),
                    );
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
            ),
          ],
        ),
      ),
    );
  }
}

//For Button:
// SizedBox(
// width: 220,
// height: 40,
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(
// onPrimary: Color(0xFF154038),
// primary: Color(0xFF5ABFA3),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.all(Radius.circular(30)),
// ),
// textStyle: TextStyle(fontWeight: FontWeight.bold)),
// onPressed: () {
// // Navigator.of(context).push(widget.next_page);
// },
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Image.asset('assets/googlelogo.png', width: 22, height: 22),
// Padding(
// padding: const EdgeInsets.only(left: 8),
// child: const Text('Continue with Google'),
// ),
// ],
// ),
// ),
// );
