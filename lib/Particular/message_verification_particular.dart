
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'email_verification_particular.dart';

class MessageVerificationParticularScreen extends StatefulWidget {
  const MessageVerificationParticularScreen({Key? key}) : super(key: key);

  @override
  State<MessageVerificationParticularScreen> createState() => _MessageVerificationParticularScreenState();
}

class _MessageVerificationParticularScreenState extends State<MessageVerificationParticularScreen> {
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
                                color: novalexxa_text_color,
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
                              color: novalexxa_text_color,
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
                      //prefixedIcon: const Icon(Icons.phone, color: Colors.appRed),
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
          Navigator.push(context,MaterialPageRoute(builder: (context)=>EmailVerificationParticularScreen()));
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


  Widget _buildLogInButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {
          if(_particular_company_selected_status==1){

            Navigator.push(context,MaterialPageRoute(builder: (context)=>PrivacyPolicyForParticularScreen()));
          }
          else{
            Navigator.push(context,MaterialPageRoute(builder: (context)=>PrivacyPolicyForCompanyScreen()));

          }

          _showToast(_particular_company_selected_status.toString());
          // Navigator.push(context,MaterialPageRoute(builder: (context)=>SplashScreen4()));
          // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SplashScreen4()));

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
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

