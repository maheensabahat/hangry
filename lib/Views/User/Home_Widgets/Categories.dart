import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Entities/Category.dart';
import '../../../Providers/UserProvider.dart';

class CategoriesList extends StatefulWidget {
  List<Category> list;
  Function(List) getRestaurants;
  Function(bool) refresh;

  CategoriesList(
      {Key? key,
      required this.list,
      required this.getRestaurants,
      required this.refresh})
      : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 5, bottom: 20),
      child: Container(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.list.length,
          itemBuilder: (context, index) => FadeInRight(
            delay: Duration(milliseconds: 500 * (index + 1)),
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: widget.list[index].isSelected
                    ? Color(0x90F29191)
                    : Color(0x905ABFA3),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: InkWell(
                onTap: () {
                  widget.list[index].isSelected =
                      !widget.list[index].isSelected;
                  if (widget.list[index].isSelected) {
                    widget.list.forEach((element) {
                      if (element != widget.list[index]) {
                        element.isSelected = false;
                      }
                    });
                    List rest = context
                        .read<UserProvider>()
                        .searchCategory(widget.list[index].label);
                    widget.getRestaurants(rest);
                  } else {
                    widget.refresh(false);
                  }
                  setState(() {});
                },
                child: ListTile(
                  title: widget.list[index].icon,
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Text(
                      widget.list[index].label,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
