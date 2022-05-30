import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/common/home_page.dart';
import 'package:nova_lexxa/splash_screen/splash_screen2.dart';
import 'package:page_transition/page_transition.dart';

import 'navigation_bar_page.dart';


class FingerPrintDoneScreen extends StatefulWidget {
  const FingerPrintDoneScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintDoneScreen> createState() => _FingerPrintDoneScreenState();
}

class _FingerPrintDoneScreenState extends State<FingerPrintDoneScreen> {

  int loging_status=1;

  @override
  @mustCallSuper
  initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      setState(() {
        loging_status=2;
        _delay();
      });

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              decoration: const BoxDecoration(
                color: novalexxa_color1,
              ),
              child:_buildLoginSuccess(),
            ),
          ),
        ],
      )


    );


  }


  Widget _buildLoginSuccess() {
    return Column(
     //  mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(
          height: 50,
        ),

        //info icon

        Align(
          alignment: Alignment.topRight,
          child:Container(
            margin: const EdgeInsets.only(left: 20.0, right: 25.0),
            child: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),

        SizedBox(
          height: 50,
        ),

        Align(
          alignment: Alignment.center,
          child:Text(
            "Biometric Login",
            textAlign: TextAlign.center,

            style: TextStyle(
                color:Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 6,
        ),

        Text(
          "Enter your fingerprint to login in your account",
          textAlign: TextAlign.center,

          style: TextStyle(
              color:Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.normal),
        ),

        Expanded(child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            //fingerprint icon
            Align(
              alignment: Alignment.center,
              child:Image.asset(
                "assets/images/fingerprint.png",
                width: 120,
                height: 170,
                fit: BoxFit.fill,
              ),
            ),
            
            Container(
            // color: novalexxa_finger_print_error_bg_color,
              margin:EdgeInsets.only(left: 33.0, right: 33.0,top: 72),
              decoration: BoxDecoration(
                 // Colors.redAccent.withOpacity(0.5)
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.all(Radius.circular(7))
              ),

              height: 60,
              child: Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Image.asset(
                      "assets/images/alert.png",
                      width: 25,
                      height: 25,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0, right: 10.0,left: 10),
                      child:Text("Fingerprint error...",
                        style: TextStyle(
                            color:Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),

                  ],
                )
                
                
              ),
            )
          ],
        )),



        SizedBox(height: 15,),

        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
            child:Align(
              alignment: Alignment.center,
              child:Text(
                "Login with PIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color:Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),

          InkResponse(
            onTap: (){
             //do something

            },
            child:Image.asset(
              "assets/images/password.png",
              width: 52,
              height: 32,
              fit: BoxFit.fill,
            ),
          )

        ],
        ),
        SizedBox(height: 30,),





      ],

    );
  }
  

  _delay(){
    Timer(Duration(seconds: 2), () {
      setState(() {
        loging_status=3;
        _delay2();
      });

    });
  }
  _delay2(){
    Timer(Duration(seconds: 2), () {
      setState(() {
       // Navigator.push(context,MaterialPageRoute(builder: (context)=>NavigationBarScreen(0,HomePageScreen())));
      });

    });
  }


}
