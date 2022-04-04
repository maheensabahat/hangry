import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  String label;
  String hintText;
  Icon icon;
  TextEditingController controller;

  InputBox(
      {Key? key,
      required this.label,
      required this.hintText,
      required this.icon,
      required this.controller})
      : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool _validate = false;

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          child: TextFormField(
            onEditingComplete: () {
              validate(widget.controller.text);
              setState(() {});
            },
            controller: widget.controller,
            style: const TextStyle(color: Color(0xFF5ABFA3)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    const BorderSide(width: 1.0, color: Color(0xFF5ABFA3)),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      const BorderSide(width: 2, color: Color(0xFF5ABFA3))),
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFFADD9C9),
                fontSize: 12,
              ),
              errorText: _validate ? "*Required" : null,
              // filled: true,
              // fillColor: Colors.black12,
              prefixIcon: widget.icon
            ),
            cursorColor: Color(0xFF5ABFA3),
          ),
        ),
      ],
    );
  }

  void validate(String text) {
    if (text.isEmpty) {
      _validate = true;
    }
    _validate = false;
  }
}
