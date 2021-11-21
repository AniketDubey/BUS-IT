// ignore_for_file: file_names, avoid_web_libraries_in_flutter, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:minoragain/models/Provider.dart';
import 'package:minoragain/pages/Payment.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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

  @override
  void dispose() {
    controller?.dispose();
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

  void _afterScan(String busNo) async {
    await Provider.of<BList>(context, listen: false).getPasLog(busNo);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateData(String busNo, int PasCount) async {
    String? Bid = await Provider.of<BList>(context, listen: false).getID(busNo);
    print(Bid);
    if (Bid != null) {
      await Provider.of<BList>(context, listen: false)
          .changeData(Bid, PasCount);
    }
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
                bottom: barcode != null ? 258 : 15,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white24,
                  ),
                  child: buildResult(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResult() {
    if (barcode == null) {
      return Text("Scan QR");
    } else {
      /* var animap = json.decode(barcode!.code);
      print(animap); */ // isko isliye hataya qki isse scanning mein error aa rhi thi bina iske sahi chal rha hai
      //return Text(barcode!.code);

      print(barcode!.code);

      String busNo = barcode!.code;

      /* Map<String, dynamic> Businfo = {};
      

      print("bahar se $Businfo"); */

      _afterScan(busNo);

      return Consumer<BList>(
        builder: (ctx, data, ch) {
          return _isLoading
              ? Center(child: CircularProgressIndicator())
              : /*T extButton(
                  onPressed: () {
                    print(data.PasCount);
                  },
                  child: Text("${data.PasCount}")); */
              AlertDialog(
                  title: Text("Click Pay to Proceed"),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await _updateData(busNo, data.PasCount);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (cctx) => Payment(),
                          ),
                        );
                        //setState(() {});
                      },
                      child: Text("Pay"),
                    ),
                  ],
                );
        },
      );
    }
    //return Text(barcode!.code);
  }

  Widget buildQRView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        cutOutSize: MediaQuery.of(context).size.width * 0.80,
        borderWidth: 10,
        borderLength: 20,
        borderRadius: 10,
        borderColor: Colors.blueAccent,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });

    /*this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunch(scanData.code)) {
        await launch(scanData.code);
      }
      controller.resumeCamera();
    });*/
  }

  /*void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      if (await canLaunch(scanData.code)) {
        await launch(scanData.code);
        controller.resumeCamera();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Could not find viable url'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    //Text('Barcode Type: ${describeEnum(scanData.format)}'),
                    Text('Data: ${scanData.code}'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  onPressed: () {

                  },
                  child: Text("Pay Now"),
                ),
              ],
            );
          },
        ).then((value) => controller.resumeCamera());
      }
    });
  }*/
}
