import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:project/Providers/RestaurantProvider.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/User/MainPage.dart';
import 'package:project/Views/User/UserMenu.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Entities/ShoppingCart.dart';
import '../../Entities/User.dart';
import '../../Entities/My_Order.dart';
import '../../Providers/ScanProvider.dart';
import 'home.dart';

class ScanQR extends StatefulWidget {
  User user;

  ScanQR({Key? key, required this.user}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  late Restaurant restaurant;
  String status = '';
  String? email;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool pressable = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    String qr_id = "";
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Scan QR',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: _buildQrView(context),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.85,
              color: const Color(0xff51bfa3),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    // Text("Successfully Scanned, Press Next\n"
                    //     'Barcode Type: ${describeEnum(result!.format)}   \nData: ${result!.code}')
                    Text("Successfully Scanned")
                  else
                    const Text('Scan a code'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: FloatingActionButton.extended(
                onPressed: pressable
                    ? () async {
                        await context
                            .read<RestaurantProvider>()
                            .getRestaurantFromFirebase(email);
                        if (!context.read<RestaurantProvider>().notFound) {
                          restaurant = context
                              .read<RestaurantProvider>()
                              .getRestaurant(email);
                          print(restaurant.name);
                          //if (!widget.user.qr && result != null) {
                          if (!context.read<UserProvider>().getQR() &&
                              result != null) {
                            // ShoppingCart CurrentCart = ShoppingCart();
                            context.read<UserProvider>().setQR(true);
                            context
                                .read<UserProvider>()
                                .initialiseCurrentOrder();
                            //widget.user.qr = true;
                            widget.user.CreateCart(restaurant);
                            Scanned scanInstance = context
                                .read<ScanProvider>()
                                .createScannedInstance(
                                    qr_id: result!.code.toString(),
                                    user_id:
                                        context.read<UserProvider>().getEmail(),
                                    order_status: false,
                                    qr_status: true);
                            context.read<ScanProvider>().addInstanceToFirebase(
                                scanned: scanInstance,
                                user: context.read<UserProvider>().getUser());
                            context.read<UserProvider>().setQR(true);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserMenu(
                                      user: widget.user,
                                      scanned: true,
                                      restaurant: restaurant,
                                      data: result!.code as String,
                                    )));
                          }
                        } else {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text('Invalid QR Code',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      content:
                                          Text('We are closing the camera now.',
                                              style: const TextStyle(
                                                fontSize: 15,
                                              )),
                                      actions: [
                                        FlatButton(
                                          color: Color(0xFF5ABFA3),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return MainPage();
                                            }));
                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ]));
                        }
                      }
                    : null,
                backgroundColor: Color(0xFF5ABFA3),
                label: Text('Next'),
                icon: Icon(Icons.arrow_forward),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xff51bfa3),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 7,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        result = scanData;
        if (scanData.code!.contains(" ") && scanData.code!.contains(":")) {
          email = (scanData.code!.split(" ")[0]).split(":")[1];
          print(email);
          pressable = true;
          context.read<ScanProvider>().setScannedEmail(email: email!);
        } else {
          status = 'Invalid code';
        }
        setState(() {});
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
