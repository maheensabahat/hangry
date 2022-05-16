import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/UserProvider.dart';

class SearchBar extends StatefulWidget {
  Function(List) getRestaurants;
  Function(bool)? refresh;

  SearchBar({Key? key, required this.getRestaurants, this.refresh})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 2),
      child: TextField(
        controller: search,
        style: const TextStyle(color: Color(0xFF5ABFA3)),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 1.0, color: Color(0xFF5ABFA3)),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 2, color: Colors.black45)),
          hintText: 'Search here',
          hintStyle: const TextStyle(
              color: Color(0xFFADD9C9),
              fontSize: 12,
              fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Color(0x10F29191),
          suffixIcon: InkWell(
            child: Icon(
              Icons.search,
              color: Color(0xFF5ABFA3),
            ),
            onTap: () {
              List rest =
              context.read<UserProvider>().searchRestaurant(search.text);
              widget.getRestaurants(rest);
            },
          ),
        ),
        onChanged: (String) {
          if (String.length == 0) {
            widget.refresh!(true);
          } else {
            widget.refresh!(false);
          }
        },
        cursorColor: Color(0xFF5ABFA3),
      ),
    );
  }
}
