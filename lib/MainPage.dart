import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project/Profile.dart';
import 'package:project/Settings.dart';
import 'package:project/home.dart';
import 'package:project/Cart.dart';

class MainPage extends StatefulWidget {
  int i = 0;
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int selected;
  PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.i;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          Home(),
          Cart(),
          Profile(),
          Settings(),
        ],
        onPageChanged: (index) {
          setState(() {
            selected = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Color(0x40ADD9C9),
        buttonBackgroundColor: Color(0xFF5ABFA3),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: <Widget>[
          Icon(Icons.home, size: 20),
          Icon(Icons.shopping_cart, size: 20),
          Icon(Icons.person, size: 20),
          Icon(Icons.settings, size: 20),
        ],
        index: selected,
        onTap: (index) {
          setState(() {
            selected = index;
          });
          controller.jumpToPage(index);
        },
      ),
    );
  }
}
