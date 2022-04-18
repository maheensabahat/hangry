import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/provider/GoogleSignInProvider.dart';
import 'package:project/temporary_main_page.dart';
import 'package:provider/provider.dart';
import 'Entities/cart.dart';
import 'package:project/Views/User/user_signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'hangry',
    options: const FirebaseOptions(
        apiKey: "AIzaSyCoWVSEMj-UOOyFnV5_nuYNo238gMIsWdI",
        authDomain: "hangry-fad8f.firebaseapp.com",
        projectId: "hangry-fad8f",
        storageBucket: "hangry-fad8f.appspot.com",
        messagingSenderId: "159589195892",
        appId: "1:159589195892:web:d4c6148160bfa273b1b121"),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => cart()),
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
      ],
      child: const MyApp(),
    ),
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: TempMain(),
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
                    context.read<GoogleSignInProvider>().googleLogin();

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => User_Signup()),
                    // );
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
