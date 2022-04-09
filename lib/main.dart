import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/RestaurantDetails.dart';
import 'package:project/temporary_main_page.dart';
import 'package:provider/provider.dart';

// <<<<<<< HEAD
import 'package:project/Order_history.dart';

// import 'package:project/Signup_View.dart';
import 'package:project/Signup_history.dart';
import 'package:project/Table_reservation.dart';

// import 'package:project/user_signup.dart';
// =======
//import 'package:project/user_signup.dart';
import 'Entities/cart.dart';
import 'Favorites.dart';
import 'MyOrders.dart';
import 'package:project/Views/User/user_signup.dart';

// >>>>>>> 90eb3c31f2d15043ea98f858ef6d4e48c6f46be5
import 'RestaurantMenu.dart';
import 'RestaurantEditDish.dart';
import 'RestaurantOrder.dart';
import 'Views/User/ScanQR.dart';
import 'Views/User/UserMenu.dart';
import 'Views/User/UserMenu.dart';

void main() {
  ChangeNotifierProvider(
    create: (_) => cart(),
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color(0xFF5ABFA3)),
      // darkTheme: ThemeData.dark(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: RestaurantMenu(),
      home: TempMain(),
      //home: const UserMenuBeforeScanning(),
      //home: const ScanQR(),
      // home: const RestaurantMenu(),
      //home: const RestaurantEditDish(),
      //home: const RestaurantOrder(),
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
      onPrimary: const Color(0xFF154038),
      primary: const Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            //Logo
            Image.asset(
              'assets/Hangry.png',
              width: 280,
              height: 280,
            ),
            //Heading
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: const Text(
                'Welcome to Hangry!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
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

            //Button
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 90),
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
