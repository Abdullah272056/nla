import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nova_lexxa/common/navigation_page/home_page.dart';


class FingerprintAuth extends StatefulWidget {
  const FingerprintAuth({Key? key}) : super(key: key);

  @override
  _FingerprintAuthState createState() => _FingerprintAuthState();
}

class _FingerprintAuthState extends State<FingerprintAuth> {
  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool _canCheckBiometric = false;
  String message ="Authenticate using your fingerprint insted of your password";

  // static const iosStrings = const IOSAuthMessages(
  //     cancelButton: 'cancel',
  //     goToSettingsButton: 'settings',
  //     goToSettingsDescription: 'Please set up your Touch ID.',
  //     lockOut: 'Please reenable your Touch ID');


  static const iosStrings = IOSAuthMessages(
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
          useErrorDialogs: true,
          iOSAuthStrings: iosStrings
      );



    } on PlatformException catch (e) {
      if(authenticated){
        message=e.toString();
      }
     // print("Abd: "+e.toString()+"0000");
    }


    setState(() {
      //_showToast("asd3");
      authorized = authenticated ? "Authorized success" : "Failed to authenticate";
      if(authenticated){
        _showToast("match");
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  const HomePageScreen()),
        );
      }else{
        _showToast("not match");
      }


    });
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      //print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
      //call first
      _showToast("call-1");
    });
  }



  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException {
      //print(e);
    }

    setState(() {

      //call second
      _showToast("call-2");
    });
  }


  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
   // _authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Fingerprint Auth")),
      backgroundColor: const Color(0xFF3C3E52),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/fingerprint.png",
                    width: 120.0,
                  ),
                  const Text(
                    "Fingerprint Auth",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, height: 1.5),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        // Fluttertoast.showToast(
                        //     msg: "button click",
                        //     toastLength: Toast.LENGTH_SHORT,
                        //     gravity: ToastGravity.CENTER,
                        //     backgroundColor: Colors.redAccent,
                        //     timeInSecForIosWeb: 1,
                        //     textColor: Colors.blue,
                        //     fontSize: 16.0);
                        _authenticate();
                      },

                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),


                      child: Ink(
                      //  color: Color(0xFF04A5ED),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 14.0),
                          child: Text(
                            "Authenticate",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
