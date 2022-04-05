import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  int min;
  int max;
  int value;
  int increments;

  Counter(
      {Key? key,
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
    int v = widget.value;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                  color: Color(0xFFADD9C9),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: 15,
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
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: Color(0xFFADD9C9),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Text(
                  '$v',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    color: Color(0xFFADD9C9),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 15,
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
      ),
    );
  }

  void add() {
    if (widget.value + widget.increments <= widget.max) {
      widget.value = widget.value + widget.increments;
    }
  }

  void sub() {
    if (widget.value - widget.increments >= widget.min) {
      widget.value = widget.value - widget.increments;
    }
  }
}
