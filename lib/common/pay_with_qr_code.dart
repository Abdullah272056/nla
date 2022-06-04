
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_lexxa/Particular/scan_doc_back_particular.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

import '../common/static/Colors.dart';

class PayWithQRCodeScreen extends StatefulWidget {
  const PayWithQRCodeScreen({Key? key}) : super(key: key);

  @override
  State<PayWithQRCodeScreen> createState() => _PayWithQRCodeScreenState();
}

class _PayWithQRCodeScreenState extends State<PayWithQRCodeScreen> {
  String countryName="en",countryIcon="icon_country.png";

int _particular_company_selected_status=1;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;
  QRViewController? controller;

  String _scannedQRCode="";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.resumeCamera();
     // controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body:Column(
        children: [


          SizedBox(
            height: 55,
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                margin: new EdgeInsets.only(left: 30),
                child: InkResponse(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color:novalexxa_text_color,
                    size: 25.0,
                  ),
                ),
              ),

              Expanded(
                  child: Container(
                    margin: new EdgeInsets.only(right: 60),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Pay with QR Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:novalexxa_text_color,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
              ),

            ],
          ),

          SizedBox(
            height: 50,
          ),

          Container(
            margin: const EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
            child:   scanMessageSection(),
          ),

          Expanded(
              child:Center(
            child: Container(
              width: 250,
              height: 250,
              child: _buildQrView(context),
            ),
          )
          ),




          const SizedBox(
            height: 20,
          ),



          Container(
            child: _buildScanQRCodeButton(),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // if (_result != null)
              //   Text(
              //       'Barcode Type: ${describeEnum(_result!.format)}   Data: ${_result!.code}')
              // else
              //   const Text('Scan a code'),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: InkResponse(
                      onTap: () async {
                        await controller?.resumeCamera();
                      },
                      child: const Text('Retry',
                          style: TextStyle(fontSize: 18)),
                    ),
                  )
                ],
              ),
            ],
          ),

          const SizedBox(height: 25,),


        ],
      ),
    );
  }


  Widget scanMessageSection() {
    return Container(
     // height: 110,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color:scan_text_box_color, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 25,bottom: 25, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Scan the QR code to Pay",
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Open your camera to make scan. the QR code will be automatically scanned",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: novalexxa_hint_text_color,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ],

        ),
      ),
    );
  }


  Widget _buildScanQRCodeButton() {
    return Container(
      margin:EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {
          if(_scannedQRCode.isNotEmpty){
            _showToast(_scannedQRCode);
          }else{
            _showToast("please scan valid QR code!");
          }

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [novalexxa_color,novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
              "Scan QR Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildQrView(BuildContext context){
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 0,
          borderLength: 20,
          borderWidth: 5,
          overlayColor: Colors.white,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() async {
        await controller.pauseCamera();
        _result = scanData;
        _scannedQRCode={_result!.code}.toString();
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

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }


}



