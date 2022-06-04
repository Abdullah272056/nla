import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:nova_lexxa/common/pay_nfc/pay_nfc_scan.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/navigation_page/home_page.dart';
import 'package:nova_lexxa/splash_screen/splash_screen2.dart';
import 'package:page_transition/page_transition.dart';


class SchedulePaymentScreen extends StatefulWidget {
  const SchedulePaymentScreen({Key? key}) : super(key: key);

  @override
  State<SchedulePaymentScreen> createState() => _SchedulePaymentScreenState();
}

class _SchedulePaymentScreenState extends State<SchedulePaymentScreen> {

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
                    Colors.white,
                    Colors.white,
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
                            color:novalexxa_text_color,
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
                                "Schedule a Payment",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color:novalexxa_text_color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                      ),

                    ],
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
