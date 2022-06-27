
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/money_option/pay_with_qr_code/pay_with_qr_amount_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../api_service/api_service.dart';
import '../../static/Colors.dart';
import '../../static/loding_dialog.dart';



class PayWithQRCodeScreen extends StatefulWidget {
  const PayWithQRCodeScreen({Key? key}) : super(key: key);

  @override
  State<PayWithQRCodeScreen> createState() => _PayWithQRCodeScreenState();
}

class _PayWithQRCodeScreenState extends State<PayWithQRCodeScreen> {
  String countryName="en",countryIcon="icon_country.png";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? _result;
  QRViewController? controller;
  String _scannedQRCode="";
  int scanQrStatus=1;

  @override
  @mustCallSuper
  initState(){
    super.initState();
    setState(()  {
      _delay();
    });
  }

  // @override
  // Future<void> reassemble() async {
  //   super.reassemble();
  //
  //  // controller!.resumeCamera();
  //
  //   if (Platform.isAndroid) {
  //     await controller?.resumeCamera();
  //     _scannedQRCode="";
  //   //  controller!.pauseCamera();
  //   } else if (Platform.isIOS) {
  //     controller!.resumeCamera();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:scanQrStatus==1?Colors.white:Colors.black,
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
                    color:scanQrStatus==1?novalexxa_text_color:Colors.white,
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
                            color:scanQrStatus==1?novalexxa_text_color:Colors.white,
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

          if(scanQrStatus==1)...{
            Container(
              margin: const EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
              child:   scanMessageSection(),
            ),
          },

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

          if(scanQrStatus==1)...{
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
                          _scannedQRCode="";
                        },
                        child: const Text('Retry',
                            style: TextStyle(fontSize: 18)),
                      ),
                    )
                  ],
                ),

              ],
            ),
          }
          else...{
            _buildLoadingView(),
          },



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

  Widget _buildLoadingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child:  CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: hint_color,
            strokeWidth: 5,

          ),

          height: 55,
          width: 55,

        ),
        SizedBox(height: 15,),
        Text(
          "Scanning...",
          //textAlign: TextAlign.center,

          style: TextStyle(
              color:Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.normal),
        )




      ],

    );
  }

  Widget  _buildScanQRCodeButton() {
    return Container(
      margin:EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {
          if(_scannedQRCode.isNotEmpty){
            setState(() {
              if(scanQrStatus==1){
                scanQrStatus=2;
                _sendQrCodeData(email: _scannedQRCode);
              }else{
                scanQrStatus=1;
              }
              //_showToast(_scannedQRCode);
            });

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

  _delay(){
    Timer(Duration(milliseconds: 100), () {
      setState(() async {
        await controller?.resumeCamera();
        _scannedQRCode="";
      });

    });
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
        _scannedQRCode='${_result!.code}';


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

  _sendQrCodeData({
    required String email,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        scanQrStatus=2;
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_QR_CODE_EMAIL_CHECKED'),
              body: {
                'email': email,
              });
          scanQrStatus=1;
          //_showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            _showToast("success");
            setState(() {
              var data = jsonDecode(response.body);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>PayWithQRAmountPageScreen(
                  data["data"]["id"].toString(),data["data"]["username"].toString())));
            });
          }

          else {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }

        } catch (e) {
          Navigator.of(context).pop();
          _showToast("Try again!");
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      scanQrStatus=1;
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }


}



