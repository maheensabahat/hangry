import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Entities/My_Order.dart';
import '../../../Providers/OrdersProvider.dart';
import '../../../Providers/ScanProvider.dart';
import '../../../Providers/UserProvider.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class AnimatedButton extends StatefulWidget {
  int order_length;
  Function(bool) isPlaced;

  AnimatedButton({Key? key, required this.order_length, required this.isPlaced})
      : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  double _containerPaddingLeft = 20.0;
  late double _animationValue;
  double _translateX = 0;
  double _translateY = 0;
  double _rotate = 0;
  double _scale = 1;

  late bool show;
  bool sent = false;
  Color _color = Color(0xFF5ABFA3);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1300));
    show = true;
    _animationController.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController.value;
        if (_animationValue >= 0.2 && _animationValue < 0.4) {
          _containerPaddingLeft = 100.0;
          _color = Color(0xf0F29191);
        } else if (_animationValue >= 0.4 && _animationValue <= 0.5) {
          _translateX = 80.0;
          _rotate = -20.0;
          _scale = 0.1;
        } else if (_animationValue >= 0.5 && _animationValue <= 0.8) {
          _translateY = -20.0;
        } else if (_animationValue >= 0.81) {
          _containerPaddingLeft = 20.0;
          sent = true;
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {
              print(widget.order_length);
              if (widget.order_length > 0) {
                context.read<ScanProvider>().updateOrderStatusInFirebase(
                    email: context.read<UserProvider>().getEmail(),
                    qr_id: context.read<ScanProvider>().getQRID(),
                    status: true);
                widget.isPlaced(true);
                context.read<OrdersProvider>().setMyOrderStatus(true);
                _animationController.forward();
              }
            },
            child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                      color: _color,
                      blurRadius: 21,
                      spreadRadius: -15,
                      offset: Offset(
                        0.0,
                        20.0,
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.only(
                    left: _containerPaddingLeft,
                    right: 20.0,
                    top: 10.0,
                    bottom: 10.0),
                duration: Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    (!sent)
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            curve: Curves.fastOutSlowIn,
                            transform: Matrix4.translationValues(
                                _translateX, _translateY, 0)
                              ..rotateZ(_rotate)
                              ..scale(_scale),
                          )
                        : Container(),
                    AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 600),
                      child: show ? SizedBox(width: 10.0) : Container(),
                    ),
                    AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 200),
                      child: show
                          ? Text(
                              "Place Order",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ),
                    AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 200),
                      child: sent
                          ? Icon(
                              Icons.done,
                              color: Colors.black87,
                            )
                          : Container(),
                    ),
                    AnimatedSize(
                      vsync: this,
                      alignment: Alignment.topLeft,
                      duration: Duration(milliseconds: 600),
                      child: sent ? SizedBox(width: 10.0) : Container(),
                    ),
                    AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 200),
                      child: sent
                          ? Text(
                              "Done",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            )
                          : Container(),
                    ),
                  ],
                ))));
  }
}
