
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';

import '../api_service/api_service.dart';
import '../common/static/loding_dialog.dart';
import 'message_verification_company.dart';

class ConfirmNumberForCompanyScreen extends StatefulWidget {
  String phoneNumber,userId;
  ConfirmNumberForCompanyScreen(
      this.userId,
      this.phoneNumber, {Key? key}

      ) : super(key: key);

  @override
  State<ConfirmNumberForCompanyScreen> createState() => _ConfirmNumberForCompanyScreenState(  this.userId,
      this.phoneNumber);
}

class _ConfirmNumberForCompanyScreenState extends State<ConfirmNumberForCompanyScreen> with SingleTickerProviderStateMixin{
  String _phoneNumber;
  String _userId;


  _ConfirmNumberForCompanyScreenState(
      this._userId,
      this._phoneNumber,
      );


  String countryName="en",countryIcon="icon_country.png";

  late AnimationController controller;
  late Animation heartbeatAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    heartbeatAnimation = Tween<double>(begin: 100.0, end: 150.0).animate(controller);
    controller.forward().whenComplete(() {
      //  controller.reverse();
    });

    /* Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.of(context).pushReplacementNamed("/dashboard");
    });
*/
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            const SizedBox(
              height: 45,
            ),
            Expanded(child:Align(alignment: Alignment.center,
            child: DelayedWidget(

              delayDuration: const Duration(milliseconds: 100),// Not required
              animationDuration: const Duration(milliseconds: 400),// Not required
              animation: DelayedAnimations.SLIDE_FROM_LEFT,// Not required
              child: Wrap(
                children: [
                  Container(
                    margin:const EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 10),
                    child:Align(alignment: Alignment.center,
                      child:Image.asset(
                        "assets/images/logo_icon.png",
                        width: 140,
                        height: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  const Align(alignment: Alignment.center,
                    child:Text(
                      "Novalexxxa",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ),
                  ),




                ],
              ),
            ),



            )

              ),

            _buildBottomDesign()

          ],
        ) /* add child content here */,
      ),
    );
  }

  Widget _buildBottomDesign() {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 22,
                ),
                const Text(
                  "Is this your correct phone number?",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 30,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _phoneNumber,
                  textAlign: TextAlign.center,

                  style: const TextStyle(
                      color: novalexxa_color,
                      fontSize: 30,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 15,
                ),



                const SizedBox(
                  height: 25,
                ),

                _buildConfirmButton(),
                const SizedBox(
                  height: 5,
                ),
                _buildWantChangeButton()

              ],
            )));
  }

  ///send user phone number verification code send button
  Widget _buildConfirmButton() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child: ElevatedButton(
        onPressed: () {
          _userSendCodeWithPhoneNumber();

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [novalexxa_color, novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  const Text(
              "Yes, send code by SMS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///phone number change button
  Widget _buildWantChangeButton() {
    return InkWell(
      onTap: (){
        Navigator.of(context).pop();
       // Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));

      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  const Text(
          "No, I want to change it",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: novalexxa_text_color,
          ),
        ),
      ),
    );
  }
  //You can create a function with your desirable animation

  ///send user phone number verification code
  _userSendCodeWithPhoneNumber() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await post(
              Uri.parse('$BASE_URL_API$SUB_URL_API_PHONE_NUMBER_SEND_CODE'),
              body: {
                'user_id': _userId,
              }
          );
          Navigator.of(context).pop();
          if (response.statusCode == 200) {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>MessageVerificationCompanyScreen(_userId)));
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

  ///create toast
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
