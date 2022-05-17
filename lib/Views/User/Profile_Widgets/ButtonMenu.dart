import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'Buttons.dart';

class ButtonMenu extends StatelessWidget {
  ButtonMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeft(
            delay: const Duration(milliseconds: 700),
            child: buttons(
              name: 'My orders',
              icon: 'assets/Order.png',
              width: 100,
              height: 65,
              istable: false,
            ),
          ),
          FadeInRight(
            delay: const Duration(milliseconds: 700),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: buttons(
                name: 'Reservations',
                icon: 'assets/Table.png',
                width: 100,
                height: 60,
                istable: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
