import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/ReserveTable.dart';
import 'package:project/Voucher.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, bottom: 40),
                  child: Text(
                    'Profile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: new BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border:
                              Border.all(width: 1, color: Color(0xFFADD9C9))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 11, top: 11),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF5ABFA3),
                        radius: 74,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('assets/profile.png'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 120, top: 120),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xF0ADD9C9),
                        child: Icon(Icons.edit, color: Color(0xFFF2F2F2)),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 4),
                  child: Text('Jimmy Vanderson',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ),
                Text('Karachi, Pakistan', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttons(
                  name: 'Voucher',
                  icon: 'assets/voucher.png',
                  width: 150,
                  height: 150,
                  istable: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: buttons(
                    name: 'Reservations',
                    icon: 'assets/Table.png',
                    width: 100,
                    height: 60,
                    istable: true,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              'Your Favourites',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // color: Color(0xFF5ABFA3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class buttons extends StatelessWidget {
  bool istable;
  String icon;
  double width;
  double height;
  String name;

  buttons(
      {Key? key,
      required this.name,
      required this.icon,
      required this.width,
      required this.height,
      required this.istable})
      : super(key: key);

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      onPrimary: Color(0xFF154038),
      primary: Color(0xFF5ABFA3),
      textStyle: TextStyle(fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 100,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              if(istable){
                return ReserveTable();
              }
              return Voucher();
            }),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              child: Image.asset(icon, width: width, height: height),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 12, color: Color(0xFFf2f2f2)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
