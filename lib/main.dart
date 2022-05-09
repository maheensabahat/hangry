import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/GoogleSignInProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/Admin/AdMainPage.dart';
import 'package:project/Views/User/MainPage.dart';
import 'package:provider/provider.dart';
import 'Entities/My_Order.dart';
import 'package:project/Views/User/user_signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Providers/AdminProvider.dart';
import 'Providers/RestaurantProvider.dart';
import 'Providers/ScanProvider.dart';
import 'Views/Restaurant/RestaurantHome.dart';

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
        ChangeNotifierProvider(create: (_) => MyOrder()),
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
        ChangeNotifierProvider(create: (_) => RestaurantProvider())
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
          primaryColor: const Color(0xFF5ABFA3)),
      // darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: AdMainPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: const Color(0xFF154038),
      primary: const Color(0xFF5ABFA3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  late final AnimationController controller;
  late final Animation<double> animation;

  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    initAnimation();
  }

  void initAnimation() async {
    Animation<double> curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween<double>(begin: 0.1, end: 1).animate(curve);

    animation.addListener(() {
      setState(() {});
    });

    //tell status on every change
    animation.addStatusListener((status) {
      if (controller.isDismissed) {
        controller.forward();
      }
    });

    controller.forward();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //Logo
              FadeTransition(
                opacity: animation,
                child: Image.asset(
                  'assets/Hangry.png',
                  width: 180 * animation.value + 100,
                  height: 180 * animation.value + 100,
                ),
              ),

              //Heading
              FadeInUp(
                delay: const Duration(milliseconds: 1000),
                child: const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    'Welcome to Hangry!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              //Sub heading
              FadeInUp(
                delay: const Duration(milliseconds: 1200),
                child: const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 24),
                  child: Text(
                    'Food you love with amazing discounts \n all in one place.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              //Button
              FadeInUp(
                delay: Duration(milliseconds: 1500),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 90),
                  child: Consumer<GoogleSignInProvider>(
                    builder: (context, signIn, child) {
                      if (signIn.isLoggedIn) {
                        return SizedBox(
                          width: 220,
                          height: 40,
                          child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: () {
                              context
                                  .read<GoogleSignInProvider>()
                                  .googleLogin()
                                  .whenComplete(
                                () async {
                                  var googleuser =
                                      context.read<GoogleSignInProvider>().user;

                                  if (context
                                      .read<GoogleSignInProvider>()
                                      .checkAdmin()) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdMainPage()),
                                    );
                                  } else {
                                    if (context
                                        .read<GoogleSignInProvider>()
                                        .checkRestaurant()) {
                                      context
                                          .read<RestaurantProvider>()
                                          .getRestaurant(googleuser?.email);

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RestaurantHome()),
                                      );
                                    } else {
                                      context.read<UserProvider>().createUser(
                                          name: googleuser?.displayName,
                                          profilePicture: googleuser?.photoUrl,
                                          email: googleuser?.email);

                                      if (googleuser != null) {
                                        bool userExists = await context
                                            .read<UserProvider>()
                                            .checkUser(context
                                                .read<GoogleSignInProvider>()
                                                .user
                                                ?.email);
                                        if (!userExists) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const User_Signup()),
                                          );
                                        } else {
                                          context
                                              .read<UserProvider>()
                                              .getUserFromDB(googleuser.email);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainPage()),
                                          );
                                        }
                                      } else {
                                        print('No user');
                                      }
                                    }
                                  }
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/googlelogo.png',
                                    width: 22, height: 22),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text('Continue with Google'),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator(
                          color: Color(0xFF5ABFA3),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
