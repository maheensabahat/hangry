import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Providers/AdminProvider.dart';
import 'package:project/Views/Admin/AdRestaurantsDisplay.dart';
import 'package:project/Views/Admin/AdminDisplay.dart';
import 'package:provider/provider.dart';
import '../../Providers/GoogleSignInProvider.dart';
import '../../main.dart';

class AdMainPage extends StatefulWidget {
  const AdMainPage({Key? key}) : super(key: key);

  @override
  State<AdMainPage> createState() => _AdMainPageState();
}

class _AdMainPageState extends State<AdMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 150, right: 20),
            child: FadeInRight(child: LogoutButton()),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Container(
                  child: Image.asset(
                    'assets/Admin.png',
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInLeft(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AdminProvider>().getRestaurants();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdRestaurantsDisplay()),
                            );
                          },
                          child: const Text('Restaurants'),
                          style: ElevatedButton.styleFrom(
                              onPrimary: Color(0xFF154038),
                              primary: const Color(0xff5abfa3)),
                        ),
                      ),
                    ),
                  ),
                  FadeInRight(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AdminProvider>().getAdmins();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AdminDisplay()),
                            );
                          },
                          child: const Text('Admins'),
                          style: ElevatedButton.styleFrom(
                              onPrimary: Color(0xFF154038),
                              primary: const Color(0xff5abfa3)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 30,
        width: 110,
        child: ElevatedButton(
          onPressed: () {
            context.read<GoogleSignInProvider>().signOut();
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: '')),
            );
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Logout',
                  style: TextStyle(
                      // color: Color(0xFF5ABFA3),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.logout,
                size: 18,
                // color: Color(0xFF5ABFA3),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
              onPrimary: Color(0xFF154038), primary: const Color(0xff5abfa3)),
        ),
      ),
    );
  }
}
