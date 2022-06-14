import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/navigation_page/home_page.dart';
import 'package:nova_lexxa/splash_screen/splash_screen2.dart';
import 'package:page_transition/page_transition.dart';

import '../navigation_page/navigation_bar_page.dart';


class FingerPrintLoginLoadingScreen extends StatefulWidget {
  const FingerPrintLoginLoadingScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintLoginLoadingScreen> createState() => _FingerPrintLoginLoadingScreenState();
}

class _FingerPrintLoginLoadingScreenState extends State<FingerPrintLoginLoadingScreen> {

  int loging_status=1;

  @override
  @mustCallSuper
  initState() {
    super.initState();
    Timer(Duration(milliseconds: 2500), () {
      setState(() {
        loging_status=2;
        _delay();
      });

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: loging_loading_bg_color,
        ),
        child:Center(
          child:Wrap(
            direction: Axis.vertical,
            children: [
              if(loging_status==1)...[
                _buildLoadingView()
              ]else if(loging_status==2)...[
                _buildLoginSuccess()
              ]else...{
                _buildLoginSuccess2(),
              }
              
            ],
            
          )
          
        
        ),
      ),
    );


  }

  Widget _buildLoginSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child:Image.asset(
            "assets/images/tick.png",
            width: 96,
            height: 96,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 15,),
        Align(
          alignment: Alignment.center,
          child:Text(
            "Logged in Successfully",
            textAlign: TextAlign.center,

            style: TextStyle(
                color:Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.normal),
          ),
        ),




      ],

    );
  }

  Widget _buildLoginSuccess2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 114.0,
          height: 114.0,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage('https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.all( Radius.circular(57.0)),
            border: Border.all(
              color: Colors.white,
              width: 5,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Nice to meet you again!",
          textAlign: TextAlign.center,

          style: TextStyle(
              color:Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.normal),
        ),
        Text(
          "Welcome Back",
          textAlign: TextAlign.center,

          style: TextStyle(
              color:Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child:Text(
            "Simon Lewis",
            textAlign: TextAlign.center,

            style: TextStyle(
                color:Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 80,
        ),

        Align(
          alignment: Alignment.center,
          child:Image.asset(
            "assets/images/tick.png",
            width: 96,
            height: 96,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 15,),
        Align(
          alignment: Alignment.center,
          child:Text(
            "Logged in Successfully",
            textAlign: TextAlign.center,

            style: TextStyle(
                color:Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.normal),
          ),
        ),




      ],

    );
  }

  Widget _buildLoadingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child:  CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: hint_color,
            strokeWidth: 7,

          ),

          height: 96,
          width: 96,

        ),
        SizedBox(height: 15,),
        Text(
          "Loading...",
          //textAlign: TextAlign.center,

          style: TextStyle(
              color:Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.normal),
        )




      ],

    );
  }

  _delay(){
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        loging_status=3;
        _delay2();
      });

    });
  }

  _delay2(){
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>NavigationBarScreen(0,HomePageScreen())));
      });

    });
  }

}
