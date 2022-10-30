
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

import '../api_service/api_service.dart';
import '../common/static/loding_dialog.dart';
import '../common/static/static_value.dart';
import 'email_verification_particular.dart';

class MessageVerificationParticularScreen extends StatefulWidget {
  String userId;
  MessageVerificationParticularScreen(this.userId, {Key? key}) : super(key: key);


  @override
  State<MessageVerificationParticularScreen> createState() => _MessageVerificationParticularScreenState(this.userId);
}

class _MessageVerificationParticularScreenState extends State<MessageVerificationParticularScreen> {
  String _userId;
  _MessageVerificationParticularScreenState(this._userId);

  String countryName="en",countryIcon="icon_country.png";






  String _firstDigitPin="-";
  String _secondDigitPin="-";
  String _thirdDigitPin="-";
  String _fourthDigitPin="-";
  String _fifthDigitPin="-";
  String _sixthDigitPin="-";
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

  bool _isCountingStatus=false;
  late Timer _timer;
  String _startTxt = "00:00";

  void startTimer(int second) {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (second == 0) {
          setState(() {
            _isCountingStatus=true;
            timer.cancel();
          });
        } else {
          setState(() {
            second--;

            _startTxt=_printDuration(Duration(seconds: second));
          });
        }
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    //countDown();
    _isCountingStatus=false;
    startTimer(otp_coundown_second);
    //controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }




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
                        const SizedBox(
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
                                  percent: 0.5,
                                  center: const Text("50%"),
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
                                            width: 80,
                                            height: 80,
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
                                            fontSize: 21,
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
                                      "Please enter the verification code, was send to your mobile ***",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: novalexxa_text_color,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),),
                                ),
                                if(_isCountingStatus==false)...[
                                  Container(
                                    margin:const EdgeInsets.only(right: 20.0,top: 20,left: 10,bottom: 0),
                                    child: Align(alignment: Alignment.topCenter,
                                      child: Text(
                                        _startTxt,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: novalexxa_color,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),),
                                  ),
                                ]else...[
                                  Container(
                                    margin:const EdgeInsets.only(right: 20.0,top: 15,left: 10,bottom: 0),
                                    child: Align(alignment: Alignment.topCenter,
                                      child: InkResponse(
                                        onTap: (){

                                          _userReSendCodeWithPhoneNumber();

                                        },
                                        child: const Text(
                                          "Resend Code",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: novalexxa_hint_text_color,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),),
                                  ),
                                ],


                                const SizedBox(
                                  height: 30,
                                ),
                                _buildTextFieldOTPView1(),



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



  _userSendCodeWithEmail() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await put(
              Uri.parse('$BASE_URL_API$SUB_URL_API_EMAIL_SEND_CODE$_userId/'),
              );
          Navigator.of(context).pop();
          if (response.statusCode == 200) {

            Navigator.push(context,MaterialPageRoute(builder: (context)=>EmailVerificationParticularScreen(_userId)));

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
          //print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  _userReSendCodeWithPhoneNumber() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await post(
              Uri.parse('$BASE_URL_API$SUB_URL_API_PHONE_NUMBER_RESEND_CODE'),
              body: {
                'user_id': _userId,
              }
          );
          Navigator.of(context).pop();
          if (response.statusCode == 200) {

            setState(() {
              _showToast("Check your phone number");
              _isCountingStatus=false;
              startTimer(otp_coundown_second);
            });

          }
          else {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }
        } catch (e) {
          Navigator.of(context).pop();
          //print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  // _userVerify(
  //     {
  //       required String otp,
  //       required String userId,
  //     }) async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       showLoadingDialog(context,"Sending...");
  //       try {
  //         Response response =
  //         await post(Uri.parse('$BASE_URL_API$SUB_URL_API_Email_verify'),
  //             body: {
  //               'user_id': userId,
  //               'code': otp,
  //             });
  //         Navigator.of(context).pop();
  //         if (response.statusCode == 200) {
  //           _showToast("successfully verified");
  //           var data = jsonDecode(response.body.toString());
  //           saveUserInfo(data["data"]);
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               //builder: (BuildContext context) => NavigationBarScreen(0,HomeScreen(1)),
  //             ),
  //                 (route) => false,
  //           );
  //
  //         }
  //         else if (response.statusCode == 400) {
  //           var data = jsonDecode(response.body.toString());
  //           _showToast(data['message']);
  //         }
  //         else {
  //           // var data = jsonDecode(response.body.toString());
  //           // _showToast(data['message']);
  //         }
  //       } catch (e) {
  //         Navigator.of(context).pop();
  //         print(e.toString());
  //       }
  //     }
  //   } on SocketException catch (_) {
  //     Fluttertoast.cancel();
  //     _showToast("No Internet Connection!");
  //   }
  // }

  // Widget _buildLogInButton() {
  //   return Container(
  //     margin: const EdgeInsets.only(left: 10.0, right: 10.0),
  //     child: ElevatedButton(
  //       onPressed: () {
  //         if(_particular_company_selected_status==1){
  //
  //           Navigator.push(context,MaterialPageRoute(builder: (context)=>const PrivacyPolicyForParticularScreen()));
  //         }
  //         else{
  //           Navigator.push(context,MaterialPageRoute(builder: (context)=>const PrivacyPolicyForCompanyScreen()));
  //
  //         }
  //
  //         _showToast(_particular_company_selected_status.toString());
  //         // Navigator.push(context,MaterialPageRoute(builder: (context)=>SplashScreen4()));
  //         // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SplashScreen4()));
  //
  //       },
  //       style: ElevatedButton.styleFrom(
  //           padding: EdgeInsets.zero,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(7))),
  //       child: Ink(
  //
  //         decoration: BoxDecoration(
  //             gradient: const LinearGradient(colors: [novalexxa_color, novalexxa_color],
  //               begin: Alignment.centerLeft,
  //               end: Alignment.centerRight,
  //             ),
  //             borderRadius: BorderRadius.circular(7.0)
  //         ),
  //         child: Container(
  //
  //           height: 50,
  //           alignment: Alignment.center,
  //           child:  const Text(
  //             "Login",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontFamily: 'PT-Sans',
  //               fontSize: 20,
  //               fontWeight: FontWeight.normal,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }


  _userVerify(
      {
        required String otp,
        required String userId,
      }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response = await post(Uri.parse('$BASE_URL_API$SUB_URL_API_PERSONAL_PHONE_VERIFY'),
              body: {
                'user_id': userId,
                'code': otp,
              });
          Navigator.of(context).pop();
          if (response.statusCode == 200) {
            _showToast("successfully verified");
            Navigator.push(context,MaterialPageRoute(builder: (context)=>EmailVerificationParticularScreen(_userId)));

          //  _userSendCodeWithEmail();

          }
          else if (response.statusCode == 400) {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }
          else {
            // var data = jsonDecode(response.body.toString());
            // _showToast(data['message']);
          }
        } catch (e) {
          Navigator.of(context).pop();
          //print(e.toString());
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
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Widget _buildBottomDesign() {
    return Container(
        height: 280,
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


                                if(inputText.length<6||inputText.length>6){

                                  _showToast("Input six digit pin");

                                }
                                else{
                                  _userVerify(userId: _userId,otp:inputText );

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

  void typeKeyboard(String typeKey) {
    setState(() {
      if (typeKey == "x") {
        if (inputText.length > 1) {
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

