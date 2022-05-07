import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/Entities/Restaurant.dart';
import 'package:project/Providers/UserProvider.dart';
import 'package:project/Views/User/UserMenu.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Entities/User.dart';
import '../../Entities/My_Order.dart';
import '../../Providers/ScanProvider.dart';

class ScanQR extends StatefulWidget {
  Restaurant restaurant = Restaurant(
      "Xander's",
      "Xander's is a modern gourmet café - the concept is all about simple, fresh ingredients & light meals in a vibrant and minimalistic ambience.",
      'Cafe',
      true,
      'assets/restaurant.jpg');
  User user;

  ScanQR({Key? key, required this.user}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
              setState(() {
                Navigator.of(context).pop();
              });
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
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (!widget.user.qr && result != null) {
                    widget.user.qr = true;
                    widget.user.CreateCart(widget.restaurant);
                    Scanned scanInstance = context
                        .read<ScanProvider>()
                        .createScannedInstance(
                            qr_id: result!.code.toString(),
                            user_id: context.read<UserProvider>().getEmail(),
                            order_status: false,
                            qr_status: true);
                    context.read<ScanProvider>().addInstanceToFirebase(
                        scanInstance, context.read<UserProvider>().getUser());
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserMenu(
                              user: widget.user,
                              scanned: true,
                              restaurant: widget.restaurant,
                              data: result!.code as String,
                            )));
                  }
                },
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
      setState(() {
        result = scanData;
      });
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
