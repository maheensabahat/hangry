
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Providers/GoogleSignInProvider.dart';
import '../../../Providers/UserProvider.dart';
import '../../../main.dart';
import 'package:project/Views/User/Widgets/ProfilePicture.dart';

class HomeHeader extends StatelessWidget {
  String userName;

  HomeHeader({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Hi Jimmy
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 24),
              child: Text('Hi, $userName!',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5ABFA3))),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 30, left: MediaQuery.of(context).size.width * 0.55),
              child: InkWell(
                child: Icon(
                  Icons.logout,
                  color: Color(0xFF5ABFA3),
                ),
                onTap: () {
                  context.read<GoogleSignInProvider>().signOut();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: '')),
                  );
                },
              ),
            ),
          ],
        ),

        //Profile pic and Bold Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'What do you\nwant to eat today?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Picture(
                  radius: 40,
                  border: 2,
                  image: context.read<UserProvider>().getImage()),
            ],
          ),
        ),
      ],
    );
  }
}
