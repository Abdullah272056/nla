import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:page_transition/page_transition.dart';

import '../../../create_account_particular_company.dart';
import '../../../log_in/log_in.dart';
import '../select_top_up.dart';



class TryAgainTopUPScreen extends StatefulWidget {
  const TryAgainTopUPScreen({Key? key}) : super(key: key);

  @override
  State<TryAgainTopUPScreen> createState() => _TryAgainTopUPScreenState();
}

class _TryAgainTopUPScreenState extends State<TryAgainTopUPScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [

            Container(
              margin:EdgeInsets.only(right:15.0,top: 30,left: 15,
                bottom: 00,
              ),
              child:Image.asset(
                "assets/images/try_again_top_up_icon.png",
                width: 105,
                height: 105,
                fit: BoxFit.fill,
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 0),
              child:  Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Sorry we were unable to debit your Mobile Money balance. Please check if you have sufficient funds to make a top-up.",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 40, top: 90, right: 40, bottom: 0),
              child:  Align(
                alignment: Alignment.topCenter,
                child: _buildTryAgainButton(),
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 20),
              child:  Align(
                alignment: Alignment.topCenter,
                child:  _buildBackToHomeButton(),
              ),
            ),

          ],
        ) /* add child content here */,
      ),
    );
  }

  Widget _buildTryAgainButton() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child: ElevatedButton(
        onPressed: () {
          Route route = MaterialPageRoute(builder: (context) => TopUpScreenScreen());
          Navigator.pushReplacement(context, route);
        // Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateAccountParticularAndCompanyScreen()));

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
              "Try again",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackToHomeButton() {
    return InkWell(
      onTap: (){
      //  Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));

      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  Text(
          "Back to Home",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: novalexxa_text_color,
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

