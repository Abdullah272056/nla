
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/static/Colors.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Particular/create_confirm_pin_particular.dart';



class CreatePinParticularScreen12 extends StatefulWidget {
  String userId;
  CreatePinParticularScreen12(this.userId, {Key? key}) : super(key: key);

  @override
  State<CreatePinParticularScreen12> createState() => _CreatePinParticularScreenState12(this.userId);

}

class _CreatePinParticularScreenState12 extends State<CreatePinParticularScreen12> {

  String _userId;
  _CreatePinParticularScreenState12(this._userId);

  double keyboardfontSize= 25;
  double keyboardfontTopPadding= 15;
  double keyboardfontBottomPadding= 15;
  String inputText="";
  TextStyle keyboardTextStyle= const TextStyle(
      color: novalexxa_text_color,
      fontSize: 26,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500);
  TextStyle otpInputBoxTextStyle= const TextStyle(
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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(


              children: [
                Expanded(child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 5),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 55,
                              ),
                              LinearPercentIndicator(
                                // width: MediaQuery.of(context).size.width - 80,
                                animation: true,
                                lineHeight: 20.0,
                                animationDuration: 1000,
                                percent: 0.9,
                                center: const Text("90%"),
                                barRadius: const Radius.circular(10),
                                fillColor:Colors.white,
                                backgroundColor: novalexxa_indicator_unselected_color,
                                progressColor: novalexxa_color,
                              ),
                              const SizedBox(
                                height: 40,
                              ),

                              Wrap(
                                children: [
                                  Container(
                                    margin:const EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 10),
                                    child:Align(alignment: Alignment.center,
                                      child:Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                              offset: const Offset(0, 2), // changes position of shadow
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

                                  const Align(alignment: Alignment.center,
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
                                margin:const EdgeInsets.only(right: 20.0,top: 40,left: 10,bottom: 0),
                                child: const Align(alignment: Alignment.topCenter,
                                  child: Text(
                                    "Create a new pin for future transaction and account security purpose",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: novalexxa_text_color,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),),
                              ),


                              const SizedBox(
                                height: 24,
                              ),
                              // _buildTextFieldOTPView(
                              //   hintText: 'Enter 6 digit Number',
                              //   obscureText: false,
                              //   // prefixedIcon: const Icon(Icons.phone, color: Colors.appRed),
                              // ),
                              _buildTextFieldOTPView1()

                            ],
                          ),
                        ),

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



  Widget _buildTextFieldOTPView1() {
    return  Flex(direction: Axis.horizontal,
      children: [
        Expanded(child: Container(
          height: 55,
          decoration: BoxDecoration(
              color:search_send_money_box_color,
              borderRadius: BorderRadius.circular(6)),
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
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
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
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
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
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
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
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
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
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
          margin:const EdgeInsets.only(left: 2, top: 2, right: 2, bottom: 2),
          padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
          child: Center(child: Text(
            _sixthDigitPin,
            textAlign: TextAlign.center,

            style: otpInputBoxTextStyle,
          ),),
        ),),

      ],
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

  Widget _buildBottomDesign() {
    return Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),

          boxShadow: [BoxShadow(

              color:Colors.grey.withOpacity(.3),
              //  blurRadius: 20.0, // soften the shadow
              blurRadius:20, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset:const Offset(
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

                        Flex(direction: Axis.horizontal,
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

                        Flex(direction: Axis.horizontal,
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

                        Flex(direction: Axis.horizontal,
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

                        Flex(direction: Axis.horizontal,
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
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateConfirmPinParticularScreen(_userId,inputText)));

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

                      ],
                    )

                ),


                const SizedBox(height: 15,),

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
      if(inputText.isEmpty){
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

