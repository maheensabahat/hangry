import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/OrderItem.dart';

class Counter extends StatefulWidget {
  int min;
  int max;
  int value;
  int increments;
  bool canEdit;
  Function(int) onChangeValue;

  Counter(
      {Key? key,
      required this.canEdit,
      required this.onChangeValue,
      required this.min,
      required this.max,
      required this.value,
      required this.increments})
      : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: Color(0xFF5ABFA3),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
              child: Icon(
                Icons.remove,
                color: Color(0xFF154038),
                size: 13,
              ),
            ),
          ),
          onTap: () {
            sub();
            setState(() {});
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Center(
            child: Text(
              '${widget.value}',
              style: TextStyle(
                  color: Color(0xFF154038),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: InkWell(
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: Color(0xFF5ABFA3),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 13,
                  color: Color(0xFF154038),
                ),
              ),
            ),
            onTap: () {
              add();
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  void add() {
    if (widget.canEdit && widget.value + widget.increments <= widget.max) {
      widget.value = widget.value + widget.increments;
      widget.onChangeValue(widget.value);
    }
  }

  void sub() {
    if (widget.canEdit && widget.value - widget.increments >= widget.min) {
      widget.value = widget.value - widget.increments;
      widget.onChangeValue(widget.value);
    }
  }
}
