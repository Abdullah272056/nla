

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'create_confirm_pin_company.dart';



class CreatePinCompanyScreen extends StatefulWidget {
  String userId;
  CreatePinCompanyScreen(this.userId);

  @override
  State<CreatePinCompanyScreen> createState() => _CreatePinCompanyScreenState(this.userId);
}

class _CreatePinCompanyScreenState extends State<CreatePinCompanyScreen> {
  String _userId;
  _CreatePinCompanyScreenState(this._userId);


  double keyboardfontSize= 25;
  double keyboardfontTopPadding= 15;
  double keyboardfontBottomPadding= 15;
  String inputText="";
  TextStyle keyboardTextStyle= TextStyle(
      color: novalexxa_text_color,
      fontSize: 26,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500);
  TextStyle otpInputBoxTextStyle= TextStyle(
      color: novalexxa_text_color,
      fontSize: 20,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500);

  String _firstDigitPin="-";
  String _secondDigitPin="-";
  String _thirdDigitPin="-";
  String _fourthDigitPin="-";
  String _fifthDigitPin="-";
  String _sixthDigitPin="-";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(


              children: [
                Expanded(child: Stack(
                  children: [
                    Column(
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
                                  barRadius: const Radius.circular(10),
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
                                _buildTextFieldOTPView1()

                              ],
                            )),

                        Expanded(child:  Align(alignment: Alignment.bottomCenter,
                          child: _buildBottomDesign(),
                        ),)


                      ],
                    )
                  ],
                )),

              ],
            ),
          ),
        ],
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
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateConfirmPinCompanyScreen(_userId,pin)));



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

  Widget _buildTextFieldOTPView1() {
    return  Container(

      child: Flex(direction: Axis.horizontal,
        children: [
          Expanded(child: Container(
            height: 55,
            decoration: BoxDecoration(
                color:search_send_money_box_color,
                borderRadius: BorderRadius.circular(6)),
            margin:EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
            padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
            child: Center(
              child: Text(
                _firstDigitPin,
                textAlign: TextAlign.center,

                style: otpInputBoxTextStyle,
              ),
            ),
          ),),
          Expanded(child: Container(
            height: 55,
            decoration: BoxDecoration(
                color:search_send_money_box_color,
                borderRadius: BorderRadius.circular(6)),
            margin:EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
            padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
            child:Center(
              child:  Text(
                _secondDigitPin,
                textAlign: TextAlign.center,

                style: otpInputBoxTextStyle,
              ),
            ),
          ),),
          Expanded(child: Container(
            height: 55,
            decoration: BoxDecoration(
                color:search_send_money_box_color,
                borderRadius: BorderRadius.circular(6)),
            margin:EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
            padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
            child: Center(
              child: Text(
                _thirdDigitPin,
                textAlign: TextAlign.center,

                style: otpInputBoxTextStyle,
              ),
            ),
          ),),
          Expanded(child: Container(
            height: 55,
            decoration: BoxDecoration(
                color:search_send_money_box_color,
                borderRadius: BorderRadius.circular(6)),
            margin:EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
            padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
            child: Center(
              child: Text(
                _fourthDigitPin,
                textAlign: TextAlign.center,

                style: otpInputBoxTextStyle,
              ),
            ),
          ),),
          Expanded(child: Container(
            height: 55,
            decoration: BoxDecoration(
                color:search_send_money_box_color,
                borderRadius: BorderRadius.circular(6)),
            margin:EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
            padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
            child: Center(
              child: Text(
                _fifthDigitPin,
                textAlign: TextAlign.center,

                style: otpInputBoxTextStyle,
              ),
            ),
          ),),
          Expanded(child: Container(
            height: 55,
            decoration: BoxDecoration(
                color:search_send_money_box_color,
                borderRadius: BorderRadius.circular(6)),
            margin:EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
            padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
            child: Center(child: Text(
              _sixthDigitPin,
              textAlign: TextAlign.center,

              style: otpInputBoxTextStyle,
            ),),
          ),),

        ],
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
        textColor: Colors.black,
        fontSize: 16.0);
  }


  Widget _buildBottomDesign() {
    return Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),

          boxShadow: [BoxShadow(

              color:Colors.grey.withOpacity(.3),
              //  blurRadius: 20.0, // soften the shadow
              blurRadius:20, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset:Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              )
          )],

        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 00, top: 15, right: 00, bottom: 0),
            child: Column(
              children: [

                Expanded(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(

                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("1");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "1",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("2");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "2",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("3");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "3",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),

                            ],
                          ),
                        ),

                        Container(

                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("4");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "4",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("5");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "5",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("6");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "6",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),

                            ],
                          ),
                        ),

                        Container(

                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("7");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "7",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("8");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "8",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("9");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "9",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),

                            ],
                          ),
                        ),

                        Container(

                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("x");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 10, bottom: keyboardfontBottomPadding),
                                  child:Image.asset('assets/images/icon_backspace.png',
                                    height: 20,
                                    width: 30,
                                  ),
                                  // Text(
                                  //   "x",
                                  //   textAlign: TextAlign.center,
                                  //
                                  //   style: keyboardTextStyle,
                                  // ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("0");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "0",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  // typeKeyboard("x");
                                  if(inputText.length<6||inputText.length>6){

                                    _showToast("Input six digit pin");

                                  }
                                  else{
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateConfirmPinCompanyScreen(_userId,inputText)));

                                  }
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 10, bottom: keyboardfontBottomPadding),
                                  child:Image.asset('assets/images/submit_icon.png',
                                    height: 32,
                                    width: 32,

                                  ),

                                ),
                              ),),



                            ],
                          ),
                        ),

                      ],
                    )

                ),


                SizedBox(height: 15,),

              ],
            )));
  }

  void typeKeyboard(String typeKey) {
    setState(() {
      if (typeKey == "x") {
        if (inputText != null && inputText.length > 1) {
          inputText = inputText.substring(0, inputText.length - 1);
        } else {
          inputText = "";
        }
      }
      else {
        String abc = inputText + typeKey;
        if(abc.length<=6){
          inputText = inputText + typeKey;
        }

      }
      setText(inputText);
    });
  }

  void setText(String inputText){

    setState(() {
      if(inputText.length==0){
        _firstDigitPin="-";
        _secondDigitPin="-";
        _thirdDigitPin="-";
        _fourthDigitPin="-";
        _fifthDigitPin="-";
        _sixthDigitPin="-";
        return;
      }
      if(inputText.length==1){
        _firstDigitPin=inputText[0].toString();
        _secondDigitPin="-";
        _thirdDigitPin="-";
        _fourthDigitPin="-";
        _fifthDigitPin="-";
        _sixthDigitPin="-";
        return;
      }
      if(inputText.length==2){
        _firstDigitPin=inputText[0].toString();
        _secondDigitPin=inputText[1].toString();
        _thirdDigitPin="-";
        _fourthDigitPin="-";
        _fifthDigitPin="-";
        _sixthDigitPin="-";
        return;
      }
      if(inputText.length==3){
        _firstDigitPin=inputText[0].toString();
        _secondDigitPin=inputText[1].toString();
        _thirdDigitPin=inputText[2].toString();
        _fourthDigitPin="-";
        _fifthDigitPin="-";
        _sixthDigitPin="-";
        return;
      }
      if(inputText.length==4){
        _firstDigitPin=inputText[0].toString();
        _secondDigitPin=inputText[1].toString();
        _thirdDigitPin=inputText[2].toString();
        _fourthDigitPin=inputText[3].toString();
        _fifthDigitPin="-";
        _sixthDigitPin="-";
        return;
      }
      if(inputText.length==5){
        _firstDigitPin=inputText[0].toString();
        _secondDigitPin=inputText[1].toString();
        _thirdDigitPin=inputText[2].toString();
        _fourthDigitPin=inputText[3].toString();
        _fifthDigitPin=inputText[4].toString();
        _sixthDigitPin="-";
        return;
      }
      if(inputText.length==6){
        _firstDigitPin=inputText[0].toString();
        _secondDigitPin=inputText[1].toString();
        _thirdDigitPin=inputText[2].toString();
        _fourthDigitPin=inputText[3].toString();
        _fifthDigitPin=inputText[4].toString();
        _sixthDigitPin=inputText[5].toString();
        return;

      }

    });

  }


}

