import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/navigation_page/home_page.dart';
import 'package:nova_lexxa/splash_screen/splash_screen2.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigation_page/navigation_bar_page.dart';
import 'finger_print_login_loading_page.dart';


class FingerPrintInputForLoginScreen extends StatefulWidget {
  const FingerPrintInputForLoginScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintInputForLoginScreen> createState() => _FingerPrintInputForLoginScreenState();
}

class _FingerPrintInputForLoginScreenState extends State<FingerPrintInputForLoginScreen> {

  int loging_status=1;
  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool _canCheckBiometric = false;
  late List<BiometricType> _availableBiometric;

  static const iosStrings = const IOSAuthMessages(
      cancelButton: 'cancel',
      goToSettingsButton: 'settings',
      goToSettingsDescription: 'Please set up your Touch ID.',
      lockOut: 'Please reenable your Touch ID');



  //after button click
  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      // authenticated = await auth.authenticateWithBiometrics(
      //     localizedReason: "Scan your finger to authenticate",
      //     useErrorDialogs: true,
      //     stickyAuth: true);


      authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          useErrorDialogs: false,
          iOSAuthStrings: iosStrings
      );



    } on PlatformException catch (e) {
      print(e);
    }


    setState(() {
      //_showToast("asd3");
      authorized = authenticated ? "Authorized success" : "Failed to authenticate";
      if(authenticated){
      //  _showToast("match");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  FingerPrintLoginLoadingScreen()),
        );
      }else{
       // _showToast("not match");
      }


    });
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
      //call first
     // _showToast("call-1");
    });
  }



  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {

      //call second
    //  _showToast("call-2");
      _availableBiometric = availableBiometric;
    });
  }


  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
    // _authenticate();
    super.initState();
  }
  // _authenticate();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              decoration: const BoxDecoration(
                color: novalexxa_color1,
              ),
              child:_buildLoginSuccess(),
            ),
          ),
        ],
      )


    );


  }


  Widget _buildLoginSuccess() {
    return Column(
     //  mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(
          height: 50,
        ),

        //info icon

        Align(
          alignment: Alignment.topRight,
          child:Container(
            margin: const EdgeInsets.only(left: 20.0, right: 25.0),
            child: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),

        SizedBox(
          height: 50,
        ),

        Align(
          alignment: Alignment.center,
          child:Text(
            "Biometric Login",
            textAlign: TextAlign.center,

            style: TextStyle(
                color:Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 6,
        ),

        Text(
          "Enter your fingerprint to login in your account",
          textAlign: TextAlign.center,

          style: TextStyle(
              color:Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.normal),
        ),

        Expanded(child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            //fingerprint icon
            InkResponse(
              onTap: (){

                _authenticate();
              },
              child:Align(
                alignment: Alignment.center,
                child:Image.asset(
                  "assets/images/fingerprint.png",
                  width: 120,
                  height: 170,
                  fit: BoxFit.fill,
                ),
              ),
            ),

            
            // Container(
            // // color: novalexxa_finger_print_error_bg_color,
            //   margin:EdgeInsets.only(left: 33.0, right: 33.0,top: 72),
            //   decoration: BoxDecoration(
            //      // Colors.redAccent.withOpacity(0.5)
            //       color: Colors.black.withOpacity(0.25),
            //       borderRadius: BorderRadius.all(Radius.circular(7))
            //   ),
            //
            //   height: 60,
            //   child: Center(
            //     child: Wrap(
            //       direction: Axis.horizontal,
            //       children: [
            //         Image.asset(
            //           "assets/images/alert.png",
            //           width: 25,
            //           height: 25,
            //           fit: BoxFit.fill,
            //         ),
            //         Container(
            //           margin: EdgeInsets.only(top: 5.0, right: 10.0,left: 10),
            //           child:Text("Fingerprint error...",
            //             style: TextStyle(
            //                 color:Colors.white,
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.normal),
            //           ),
            //         ),
            //
            //       ],
            //     )
            //
            //
            //   ),
            // )
          ],
        )),



        SizedBox(height: 15,),

        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
            child:Align(
              alignment: Alignment.center,
              child:Text(
                "Login with PIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),

          InkResponse(
            onTap: (){
             //do something

            },
            child:Image.asset(
              "assets/images/password.png",
              width: 52,
              height: 32,
              fit: BoxFit.fill,
            ),
          )

        ],
        ),
        SizedBox(height: 30,),





      ],

    );
  }






  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.redAccent,
        timeInSecForIosWeb: 1,
        textColor: Colors.blue,
        fontSize: 16.0);
  }

}
