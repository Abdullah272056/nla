
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';
import '../common/navigation_page/home_page.dart';
import '../common/navigation_page/navigation_bar_page.dart';
import '../common/static/loding_dialog.dart';

class CreateConfirmPinParticularScreen extends StatefulWidget {
  String userId;
  String newPin;
  CreateConfirmPinParticularScreen(this.userId,this.newPin);


  @override
  State<CreateConfirmPinParticularScreen> createState() => _CreateConfirmPinParticularScreenState(this.userId,this.newPin);
}

class _CreateConfirmPinParticularScreenState extends State<CreateConfirmPinParticularScreen> {
  String _userId;
  String _newPin;
  _CreateConfirmPinParticularScreenState(this._userId,this._newPin);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(
              height: 55,
            ),
            Padding(
                padding:
                const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      // width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1000,
                      percent: 1.0,
                      center: Text("100%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      fillColor:Colors.white,
                      backgroundColor: novalexxa_indicator_unselected_color,
                      progressColor: novalexxa_color,
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    Wrap(
                      children: [
                        Container(
                          margin:EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 10),
                          child:Align(alignment: Alignment.center,
                            child:Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                "assets/images/logo_icon.png",
                                width: 110,
                                height: 110,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),

                        Align(alignment: Alignment.center,
                          child:Text(
                            "Novalexxxa",
                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 28,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal),
                          ),
                        ),




                      ],
                    ),

                    Container(
                      margin:EdgeInsets.only(right: 20.0,top: 40,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.topCenter,
                        child: Text(
                          "Create confirm pin for future transaction and account security purpose",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),

                    SizedBox(
                      height: 24,
                    ),
                    _buildTextFieldOTPView(
                      hintText: 'Enter 6 digit Number',
                      obscureText: false,
                     // prefixedIcon: const Icon(Icons.phone, color: Colors.appRed),
                    ),


                  ],
                ))

          ],
        ),
      ),
    );
  }


  Widget _buildTextFieldOTPView({
    required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    String? labelText,
  }) {
    return Container(
      color: Colors.transparent,
      child: OTPTextField(
        length: 6,
        width: MediaQuery.of(context).size.width,
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldStyle: FieldStyle.box,
       // contentPadding: EdgeInsets.only(right: 20.0,top: 20,left: 10,bottom: 0),
        fieldWidth:45,
        spaceBetween:0,
        style: TextStyle(
          fontSize: 18,
          color: novalexxa_text_color,
        ),
        keyboardType: TextInputType.number,
        inputFormatter: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
        // textInputAction: TextInputAction.search,
        // onSubmitted: (value) {
        //   print("search");
        // },
        onCompleted: (confirmPin) {


          if(_newPin!=confirmPin){
            _showToast("new pin and confirm pin does not match");
          }else{
            // call api
            _sendPersonalPin(newPin:_newPin,confirmPin: confirmPin );
          }

        //  Navigator.push(context,MaterialPageRoute(builder: (context)=>AddInformationForParticularScreen()));


          //_otpTxt = pin;
         // _showToast(pin);
        },
        onChanged: (value) {
          if (value.length < 6) {
           // _otpTxt = "";
          }
        },
      ),
    );
  }

  _sendPersonalPin({
    required String newPin,
    required String confirmPin,

  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_PERSONAL_CREATE_PIN'),
              body: {
                'user_id': _userId,
                'new_pin': newPin,
                'confirm_pin': confirmPin,

              });
          Navigator.of(context).pop();
          if (response.statusCode == 201) {
            _showToast("success");

            setState(() {
              //_showToast("success");
              var data = jsonDecode(response.body);
              saveUserId(_userId);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => NavigationBarScreen(0,HomePageScreen()),
                ), (route) => false,
              );

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
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  void saveUserId(String userId) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(pref_user_id,userId);

    } catch (e) {
      //code
    }
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

