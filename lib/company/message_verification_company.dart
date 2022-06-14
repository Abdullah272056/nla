
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Particular/email_verification_particular.dart';
import '../api_service/api_service.dart';
import '../common/static/loding_dialog.dart';
import 'email_verification_company.dart';


class MessageVerificationCompanyScreen extends StatefulWidget {
  String userId;
  MessageVerificationCompanyScreen(this.userId);

  @override
  State<MessageVerificationCompanyScreen> createState() => _MessageVerificationCompanyScreenState(this.userId);
}

class _MessageVerificationCompanyScreenState extends State<MessageVerificationCompanyScreen> {
  String _userId;
  _MessageVerificationCompanyScreenState(this._userId);



  String countryName="en",countryIcon="icon_country.png";


  String _genderDropDownSelectedValue = "English";
  final List<String> _countryNameList = ["English", "French", "Spanish","Italian",
    "German","Indonesia","Portugues","Romana","Arabics"];
  final List<String> _countryNameIcon = ["icon_country.png", "icon_country.png", "icon_country.png","icon_country.png",
    "German","icon_country.png","icon_country.png","icon_country.png","icon_country.png"];

  int _particular_company_selected_status=1;
  TextEditingController? _emailController = TextEditingController();
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
                    new LinearPercentIndicator(
                      // width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1000,
                      percent: 0.5,
                      center: Text("50%"),
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
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),

                        Align(alignment: Alignment.center,
                          child:Text(
                            "Novalexxxa",
                            style: TextStyle(
                                color:novalexxa_text_color,
                                fontSize: 21,
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
                          "Please enter the verification code, was send to your mobile ***",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:novalexxa_text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 20.0,top: 20,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.topCenter,
                        child: Text(
                          "01:36",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_color,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 20.0,top: 10,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.topCenter,
                        child: Text(
                          "Resend Code",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_hint_text_color,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    _buildTextFieldOTPView(
                      hintText: 'Enter 6 digit Number',
                      obscureText: false,
                    //  prefixedIcon: const Icon(Icons.phone, color: Colors.appRed),
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

        style: TextStyle(
          fontSize: 18,
          color: novalexxa_text_color,
        ),
        keyboardType: TextInputType.number,
        inputFormatter: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
        onCompleted: (pin) {
          _userSendCodeWithEmail();
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




  _userSendCodeWithEmail() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await put(
            Uri.parse('$BASE_URL_API$SUB_URL_API_EMAIL_SEND_CODE_COMPANY$_userId/'),
          );
          Navigator.of(context).pop();
          if (response.statusCode == 200) {

            Navigator.push(context,MaterialPageRoute(builder: (context)=>EmailVerificationCompanyScreen(_userId)));

          }
          else if (response.statusCode == 400) {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }
          else {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }
        } catch (e) {
          Navigator.of(context).pop();
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }
  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}

