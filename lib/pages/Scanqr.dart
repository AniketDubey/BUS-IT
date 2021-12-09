// ignore_for_file: file_names, avoid_web_libraries_in_flutter, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minoragain/models/Provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scratcher/scratcher.dart';

class Scanqr extends StatefulWidget {
  //const Scanqr({Key? key}) : super(key: key);

  @override
  _ScanqrState createState() => _ScanqrState();
}

class _ScanqrState extends State<Scanqr> {
  final qrKey = GlobalKey(debugLabel: "QR");
  bool _isLoading = true;
  Barcode? barcode;
  QRViewController? controller;
  int? _totalPresent;

  TextEditingController _controllertext = TextEditingController();

  @override
  void dispose() {
    controller?.dispose();
    _controllertext.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();

    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
    if (isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void _afterScan() async {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Provider.of<BList>(context, listen: false).screenChange();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              buildQRView(context),
              Positioned(
                bottom: barcode != null ? 258 : 25,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: buildResult(),
                ),
              ),
              barcode == null
                  ? Positioned(
                      top: 10,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Text(
                          "Prime Members Subscription",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResult() {
    if (barcode == null) {
      return Text(
        "Scan QR for Offers",
        style: TextStyle(
          fontSize: 18,
        ),
      );
    } else {
      /* var animap = json.decode(barcode!.code);
      print(animap); */ // isko isliye hataya qki isse scanning mein error aa rhi thi bina iske sahi chal rha hai
      //return Text(barcode!.code);

      //print(barcode!.code);

      var newaniket = json.decode(barcode!.code);
      //print("changed data $newaniket");

      int PasLog = newaniket["PassLog"];
      print(PasLog);

      var busNo = barcode!.code;

      _afterScan();

      return Consumer<BList>(
        builder: (ctx, data, ch) {
          return _isLoading
              ? Center(child: CircularProgressIndicator())
              : PasLog < 50
                  ? Scratcher(
                      brushSize: 50,
                      threshold: 50,
                      color: Colors.red,
                      image: Image.asset(
                        "assets/outerimage.png",
                        fit: BoxFit.fill,
                      ),
                      child: Container(
                        height: 300,
                        width: 300,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/newimage.png",
                              fit: BoxFit.contain,
                              width: 150,
                              height: 150,
                            ),
                            Column(
                              children: [
                                Text(
                                  "You won",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "30% Cashback",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : AlertDialog(
                      title: Text("No seats Avaialble"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          child: Text("Go Back"),
                        ),
                      ],
                    );
        },
      );
    }
  }

  Widget buildQRView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: MediaQuery.of(context).size.width * 0.80,
        borderWidth: 10,
        borderLength: 160,
        borderRadius: 10,
        borderColor: Colors.white,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }
}
