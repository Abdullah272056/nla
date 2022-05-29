import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/Particular/particular_information.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'customer_services.dart';
import 'notification.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:Column(

              children: [
                const SizedBox(
                  height: 55,
                ),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,

                      child: Container(
                        width: 55,
                        height: 55,


                        margin:const EdgeInsets.only(left:30, top: 00, right: 15, bottom: 00),
                        // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(27.5),
                          child: Container(
                              height: 55,
                              width: 55,
                              color:hint_color,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.fill,
                                placeholder: 'assets/images/empty.jpg',
                                image: "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                                imageErrorBuilder: (context, url, error) =>
                                    Image.asset(
                                      'assets/images/empty.jpg',
                                      fit: BoxFit.fill,
                                    ),
                              )),
                        ),

                      ),
                    ),
                    Expanded(child:Column(
                      children: [
                        Flex(direction: Axis.horizontal,
                        children: [
                          Expanded(child:  Align(
                            alignment: Alignment.centerLeft,
                            child:Text(
                              "Simon Lewis",
                              style: TextStyle(
                                  color: novalexxa_text_color,
                                  fontSize: 22,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),
                          ) ,),
                          Container(
                            margin:EdgeInsets.only(right: 15,top: 0,left: 10,bottom: 0),
                            child:InkResponse(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerServicesScreen()));
                              },
                              child: Image.asset(
                                'assets/images/call_icon.png',
                                height: 22,
                                fit: BoxFit.fill,
                              ),
                            ),

                          ),
                          Container(
                            margin:EdgeInsets.only(right: 20,top: 0,left: 10,bottom: 0),
                            child:InkResponse(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsScreen()));

                              },
                              child:Image.asset(
                                'assets/images/icon_noti.png',
                                height: 25,

                                fit: BoxFit.fill,
                              ),
                            ),
                          ),



                        ],
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "IT60 X054 2811 1010 0000 0123 456",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        )


                      ],
                    )

                    )

                  ],
                ),

                Container(
                  margin:EdgeInsets.only(right: 30,top: 10,left: 30,bottom: 10),
                  height: 150,
                  width: 350,

                  decoration: BoxDecoration(

                    image: DecorationImage(
                      image: AssetImage("assets/images/current_balance_card_bg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),

                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [

                        Container(
                            margin:EdgeInsets.only(right: 10,top: 00,left: 20,bottom: 5),
                            child:  Text(
                              "Current Balance",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            )
                        ),

                        Container(
                          margin:EdgeInsets.only(right: 10,top: 00,left: 20,bottom: 00),
                          child: Text(
                            "€437",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold),
                          ),
                        ),



                      ],
                    ),
                  ),


                  /* add child content here */
                ),

                Container(
                  padding:EdgeInsets.only(right: 20,top: 10,left: 20,bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black38,
                        size: 30.0,
                      ),

                      Expanded(child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Flex(direction: Axis.vertical,
                              children: [
                                Container(
                                  margin:  EdgeInsets.only(left: 20, right: 15,bottom: 10,top: 10),
                                  width: 65,
                                  height: 65,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(33),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.35),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          2.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  //   height: 150,
                                  child: Container(

                                    margin: EdgeInsets.only(right: 17.0,top: 17,bottom: 17,left: 17),
                                    // height: double.infinity,
                                    // width: double.infinity,
                                    color: Colors.white,
                                    child: Image.asset(
                                      "assets/images/deposit_icon.png",
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.fill,
                                    ),
                                  ) ,
                                ),

                                Container(
                                    margin:  EdgeInsets.only(left: 20, right: 15,bottom: 00,top: 0),
                                    child:  Text(
                                      "Deposit",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                ),
                              ],
                            ),

                            Flex(direction: Axis.vertical,
                              children: [
                                Container(
                                  margin:  EdgeInsets.only(left: 15, right: 15,bottom: 10,top: 10),
                                  width: 65,
                                  height: 65,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(33),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.35),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          2.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  //   height: 150,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 17.0,top: 17,bottom: 17,left: 17),
                                    // height: double.infinity,
                                    // width: double.infinity,
                                    color: Colors.white,
                                    child: Image.asset(
                                      "assets/images/invite_friend_icon.png",
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.fill,
                                    ),
                                  ) ,
                                ),

                                Container(
                                    margin:  EdgeInsets.only(left: 15, right: 15,bottom: 0,top: 0),
                                    child:  Text(
                                      "Invite Friends",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                ),
                              ],
                            ),

                            Flex(direction: Axis.vertical,
                              children: [
                                Container(
                                  margin:  EdgeInsets.only(left: 15, right: 15,bottom: 10,top: 10),
                                  width: 65,
                                  height: 65,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(33),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(.35),
                                        blurRadius: 20.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          2.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                  ),
                                  //   height: 150,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 17.0,top: 17,bottom: 17,left: 17),
                                    // height: double.infinity,
                                    // width: double.infinity,
                                    color: Colors.white,
                                    child: Image.asset(
                                      "assets/images/stats_icon.png",
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.fill,
                                    ),
                                  ) ,
                                ),

                                Container(
                                    margin:  EdgeInsets.only(left: 15, right: 15,bottom: 0,top: 0),
                                    child:  Text(
                                      "Stats",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                ),
                              ],
                            ),


                          ],
                        ),
                      )),

                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black38,
                        size: 30.0,
                      ),

                    ],
                  ),
                ),
                Expanded(child: _buildBottomDesign())



              ],
            ),
          ),
        ],
      )


    );
  }

  Widget _buildBottomDesign() {
    return Container(
        width: double.infinity,
       // height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.50),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),

        child: Padding(
            padding:
            const EdgeInsets.only(left:25, top: 10, right: 25, bottom: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                children: [
                  Expanded(child: Align(
                    alignment: Alignment.centerLeft,
                    child:Text(
                      "Transaction History",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: novalexxa_text_color,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),),


                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Details",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: novalexxa_hint_text_color,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                children: [
                  Expanded(child:  Container(
                    margin: EdgeInsets.only(left:0, top: 0, right: 10, bottom: 0),
                    height: .4,
                    color: novalexxa_hint_text_color,

                  ),),
                  Text(
                    "01 Mar, 2020",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: novalexxa_hint_text_color,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                  Expanded(child:  Container(
                    margin: EdgeInsets.only(left:10, top: 0, right: 0, bottom: 0),
                    height: .4,
                    color: novalexxa_hint_text_color,

                  ),),


                ],
                ),



                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
              ],
            )));
  }

  Widget transactionItemDesign() {
    return Padding(padding: EdgeInsets.only(right:00,top: 10,left: 00,bottom: 10),
    child:  Row(
      children: [

        Align(
          alignment: Alignment.topLeft,

          child: Container(
            width: 55,
            height: 55,


            margin:const EdgeInsets.only(left:0, top: 00, right: 15, bottom: 00),
            // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(27.5),
              child: Container(
                  height: 55,
                  width: 55,
                  color:hint_color,
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    placeholder: 'assets/images/empty.jpg',
                    image: "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                    imageErrorBuilder: (context, url, error) =>
                        Image.asset(
                          'assets/images/empty.jpg',
                          fit: BoxFit.fill,
                        ),
                  )),
            ),

          ),


        ),
        Expanded(child:Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:Text(
                "Tech Italy",
                style: TextStyle(
                    color: novalexxa_text_color,
                    fontSize: 17,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Flex(direction: Axis.horizontal,
            children: [
              Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "10:45 AM",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: novalexxa_hint_text_color,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            ),
              Container(
                margin: const EdgeInsets.only(left: 5.0, right: 3.0),
                decoration: const BoxDecoration(
                  color: novalexxa_color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
                height: 5,
                width: 5,
              ),
              Align(alignment: Alignment.centerLeft,
              child: Text(
                "pending",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: novalexxa_hint_text_color,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            )],
            )

          ],
        ),),
        Align(
          alignment: Alignment.centerLeft,
          child:Text(
            "-€12",
            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 17,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10,)

      ],
    ),
    );
  }

  Widget cardItemDesign({required double marginLeft,required double marginRight,
    required String bg_image_link,required String icon_link,required String item_name_text,
  }) {
    return  Container(
      margin:EdgeInsets.only(right: marginRight,top: 10,left: marginLeft,bottom: 10),
      height: 150,
      width: 150,

      decoration: BoxDecoration(

        image: DecorationImage(
          image: AssetImage(bg_image_link),
          fit: BoxFit.fill,
        ),
      ),

      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,

            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(22.0),
                    bottomRight: Radius.circular(22.0),
                    topLeft: Radius.circular(22.0),
                    bottomLeft: Radius.circular(22.0)),
              ),

              margin:const EdgeInsets.only(left:20, top: 20, right: 10, bottom: 00),
              padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: Image.asset(icon_link,
                fit: BoxFit.fill,
              ),

            ),
          ),


          Container(
            padding:const EdgeInsets.only(left:20, top: 20, right: 5, bottom: 00),
            child:Align(alignment: Alignment.topLeft,
              child:Text(
                item_name_text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),


      /* add child content here */
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


}

