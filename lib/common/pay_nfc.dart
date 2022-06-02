import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:nova_lexxa/common/pay_nfc_scan.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/navigation_page/home_page.dart';
import 'package:nova_lexxa/splash_screen/splash_screen2.dart';
import 'package:page_transition/page_transition.dart';




class PayNFCScreen extends StatefulWidget {
  const PayNFCScreen({Key? key}) : super(key: key);

  @override
  State<PayNFCScreen> createState() => _PayNFCScreenState();
}

class _PayNFCScreenState extends State<PayNFCScreen> {

  int loging_status=1;

  @override
  @mustCallSuper
  initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:Container(
              decoration:BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    novalexxa_start_bg_color,
                    novalexxa_end_bg_color,
                  ],
                ),
                // color: loging_loading_bg_color,
              ),
              child:Column(

                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        margin: new EdgeInsets.only(left: 30),
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                      ),

                      Expanded(
                          child: Container(
                            margin: new EdgeInsets.only(right: 60),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Pay with NFC",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi,
                        color: Colors.white,
                        size: 50.0,

                      ),
                      Image.asset(
                        "assets/images/icon_nfc.png",
                        height: 82,
                        width: 50,
                        fit: BoxFit.fill,
                        color: Colors.white,
                      ),
                      InkResponse(
                        onTap: (){
                          Route route = MaterialPageRoute(builder: (context) => PayNFCScanScreen());
                          Navigator.pushReplacement(context, route);
                        //  Navigator.push(context,MaterialPageRoute(builder: (context)=>PayNFCScanScreen()));
                        },
                        child: Row(
                          children: [
                            Expanded(child: Container(

                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(.19),
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              padding:EdgeInsets.only(left: 30.0, right: 30.0,top: 20,bottom: 20),
                              margin:EdgeInsets.only(left: 20.0, right: 20.0,top: 90,bottom: 18),
                              child: Column(

                                children: [


                                  Image.asset(
                                    "assets/images/information.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.fill,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),

                                  Text("Your NFC is disabled,\nopen your phone setting and active\nthe NFC to make payment",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),

                                ],
                              ),
                            ))
                          ],
                        ),
                      )
                    ],
                  )),

                  SizedBox(
                    height: 100,
                  ),

                ],

              ),
            ),
          ),
        ],
      )


    );


  }



}
