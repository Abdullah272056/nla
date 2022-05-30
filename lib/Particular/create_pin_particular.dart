import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/Particular/particular_information.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'create_confirm_pin_particular.dart';

class CreatePinParticularScreen extends StatefulWidget {
  const CreatePinParticularScreen({Key? key}) : super(key: key);

  @override
  State<CreatePinParticularScreen> createState() => _CreatePinParticularScreenState();
}

class _CreatePinParticularScreenState extends State<CreatePinParticularScreen> {

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
                      percent: 0.9,
                      center: Text("90%"),
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
                          "Create a new pin for future transaction and account security purpose",
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

        style: TextStyle(
          fontSize: 18,
          color: novalexxa_text_color,
        ),
        keyboardType: TextInputType.number,
        inputFormatter: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
        onCompleted: (pin) {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateConfirmPinParticularScreen()));


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

