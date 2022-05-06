import 'package:flutter/material.dart';

class ButtonOption extends StatefulWidget {
  String title;
  String image;
  bool isSelected;

  Function(String) onSelectParam;

  ButtonOption(
      {Key? key,
      required this.isSelected,
      required this.onSelectParam,
      required this.title,
      required this.image})
      : super(key: key);

  @override
  _ButtonOptionState createState() => _ButtonOptionState();
}

class _ButtonOptionState extends State<ButtonOption> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        width: 80,
        height: 80,
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xFF5ABFA3) : Color(0xF0ADD9C9),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.image,
                width: 50,
                height: 50,
                color: Color(0xFF154038),
              ),
              Text(
                widget.title,
                style: TextStyle(color: Color(0xFF154038), fontSize: 13),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        widget.isSelected = !widget.isSelected;
        if (widget.isSelected) {
          widget.onSelectParam(widget.title);
        } else {
          widget.onSelectParam('none');
        }
        // setState(() {});
      },
    );
  }
}
