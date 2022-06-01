
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


class LogInByPinScreen extends StatefulWidget {
  const LogInByPinScreen({Key? key}) : super(key: key);

  @override
  State<LogInByPinScreen> createState() => _LogInByPinScreenState();
}

class _LogInByPinScreenState extends State<LogInByPinScreen> {

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

                    Align(
                      alignment: Alignment.topRight,
                      child:Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 25.0),
                        child: Icon(
                          Icons.info_outline,
                          color: intello_input_text_color,
                          size: 30.0,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Wrap(
                      children: [

                        Container(
                          margin:EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 20),
                          child:Align(alignment: Alignment.center,
                            child:_buildTrashAltButton(),
                          ),
                        ),

                        Align(alignment: Alignment.center,
                          child:Text(
                            "Pin Login",
                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 38,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],
                    ),

                    Container(
                      margin:EdgeInsets.only(right: 10.0,top: 5,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.topCenter,
                        child: Text(
                          "Enter your PIN to access",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_hint_text_color,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),

                    SizedBox(
                      height: 50,
                    ),

                    _buildTextFieldOTPView(
                      hintText: 'Enter 6 digit Number',
                      obscureText: false,
                    ),

                    Container(
                      margin:EdgeInsets.only(right: 10.0,top: 33,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.topCenter,
                        child: InkWell(

                          child: Text(
                            "I don’t remember my PIN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: intello_input_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),

                        ),),
                    ),


                  ],
                ))

          ],
        ),
      ),
    );
  }

  Widget _buildTrashAltButton() {
    return Container(
      margin:  EdgeInsets.only(left: 10, right: 10,bottom: 0,top: 10),
      padding:  EdgeInsets.only(left: 10, right:10,bottom: 10,top: 10),
      height: 77,
      width: 77,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.35),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      //   height: 150,
      child: Center(
        child: Image.asset(
          "assets/images/logo.png",
          fit: BoxFit.fill,
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
         // Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateConfirmPinCompanyScreen()));


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

