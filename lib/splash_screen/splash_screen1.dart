import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/splash_screen/splash_screen2.dart';
import 'package:page_transition/page_transition.dart';


class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child:  InkResponse(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SplashScreen2()));
            },
            child: Column(
              children: [
                Expanded(child: Container()),
                Container(
                  margin:EdgeInsets.only(right: 20.0,top: 00,left: 25),
                  child:Align(alignment: Alignment.topLeft,
                    child:Image.asset(
                      "assets/images/logo_icon.png",
                      width: 81,
                      height: 81,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  margin:EdgeInsets.only(right: 20.0,top: 20,left: 25,bottom: 0),
                  child: Align(alignment: Alignment.topLeft,
                    child: Text(
                      "Novalexxa",
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                      softWrap: false,
                      maxLines:1,
                    ),
                  ),
                ),

                Container(
                  margin:EdgeInsets.only(right: 20.0,top: 20,left: 25,bottom: 0),
                  child: Align(alignment: Alignment.topLeft,
                    child: Text(
                      "Lorem Ipsum is simply dummy industry...",
                      overflow: TextOverflow.ellipsis,
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.normal),
                      softWrap: false,
                      maxLines:2,
                    ),
                  ),
                ),
                Container(
                  margin:EdgeInsets.only(right: 20.0,top: 10,left: 25,bottom: 30),
                  child: Align(alignment: Alignment.topLeft,
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipis.",
                        overflow: TextOverflow.ellipsis,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                        softWrap: false,
                        maxLines:2,
                      )

                  ),
                ),
                Flex(

                  direction: Axis.horizontal,
                  children: [
                    Expanded(child:
                    Container(
                      margin: const EdgeInsets.only(left: 25.0, right: 00.0),
                      decoration: const BoxDecoration(
                        color:novalexxa_color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                      ),
                      height: 2.5,
                      // width: 11,
                    ),
                      flex: 1,),
                    Expanded(child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                      decoration: const BoxDecoration(
                        color: novalexxa_color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                      ),
                      height: 2.5,
                      // width: 11,
                    ),
                      flex: 4,),
                    Expanded(child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      decoration: const BoxDecoration(
                        color:novalexxa_color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                      ),
                      height: 2.5,
                      // width: 11,
                    ),
                      flex: 2,),

                  ],
                ),
                SizedBox(height: 30,)
              ],

            ),
          ),
        )/* add child content here */,
      ),
    );


  }

}
