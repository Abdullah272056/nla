import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_service/api_service.dart';
import '../../../api_service/sharePreferenceDataSaveName.dart';
import '../../static/toast.dart';


class CardPageScreen extends StatefulWidget {
  const CardPageScreen({Key? key}) : super(key: key);

  @override
  State<CardPageScreen> createState() => _CardPageScreenState();
}

class _CardPageScreenState extends State<CardPageScreen> {
  double _switchButtonWidth = 45;
  double _switchButtonHeight = 27;
  double _buttonToggleSize = 20;
  bool _switchButtonStatus = false;
  String _card_number="xxxx xxxx xxxx xxxx";
  String _card_holder_name="-------";
  String _card_expire_date="xx/xx";

  String _userId = "";
  String _user_uuidId = "";

  List _novalexxaCardDataList = [];

  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {
          _getUserNovalexxaCardDataList();
          // _getCurrentBalanced();
        });
      }
      else{
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  _buildProfileSection(),

                  ///card section start
                  ///
                  _buildCardSection(),

                  const SizedBox(
                    height: 40,
                  ),

                  Expanded(child: _buildBottomDesign())
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildCardSection() {
    return Column(
      children: [
        if(_switchButtonStatus)...[
          Flex
            (
            direction: Axis.horizontal,
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: 00, top: 30, left: 00, bottom: 10),
                height: 163,
                width: 19,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/card_left_side_freeze.png",
                    height: 137,
                    width: 19,
                  ),
                ),
              ),
              Expanded(
                child:Center(
                  child: Container(
                      margin: EdgeInsets.only(
                          right: 10, top: 30, left: 10, bottom: 10),
                      height: 163,
                      width: 316,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
                        gradient: LinearGradient(colors: [ novalexxa_hint_text_color,novalexxa_hint_text_color,],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),

                      ),
                      child: Stack(
                        children: [

                          Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: 00,
                                          top: 00,
                                          left: 20,
                                          bottom: 00),
                                      child: Image.asset(
                                        "assets/images/logo_for_card_.png",
                                        fit: BoxFit.fill,
                                        width: 103,
                                        height: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 20,
                                              top: 00,
                                              left: 00,
                                              bottom: 00),
                                          child:Text(
                                            "Freezed Card",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 1.0,
                                                fontSize: 18,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.bold),
                                          ) ,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 3,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _card_number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2.0,
                                        fontSize: 22,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 00,
                                      top: 00,
                                      left: 00,
                                      bottom: 00),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right: 10,
                                                    top: 00,
                                                    left: 20,
                                                    bottom: 5),
                                                child: Text(
                                                  "Card Holder Name",
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10,
                                                  top: 00,
                                                  left: 20,
                                                  bottom: 00),
                                              child: Text(
                                                "Simon Lewis",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.5,
                                                    decoration:
                                                    TextDecoration
                                                        .none,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right: 10,
                                                    top: 00,
                                                    left: 20,
                                                    bottom: 5),
                                                child: Text(
                                                  "Expiry Date",
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400),
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10,
                                                  top: 00,
                                                  left: 20,
                                                  bottom: 00),
                                              child: Text(
                                                _card_expire_date,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.5,
                                                    decoration:
                                                    TextDecoration
                                                        .none,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                          Alignment.centerRight,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 20,
                                                top: 00,
                                                left: 00,
                                                bottom: 00),
                                            child: Image.asset(
                                              "assets/images/visa_logo.png",
                                              fit: BoxFit.fill,
                                              width: 87,
                                              height: 27,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),

                          BlurryContainer(
                            child: Text(""),
                            blur: 4.5,
                            height: 163,
                            width: 316,
                            elevation: 0,
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(8),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                          Container(
                            child: Center(
                              child: Icon(
                                Icons.lock_rounded,
                                color: Colors.white,
                                size: 50.0,
                              ),
                            ),
                          )


                        ],
                      )

                    /* add child content here */
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: 00, top: 30, left: 00, bottom: 10),
                height: 163,
                width: 19,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    "assets/images/card_right_side_freeze.png",
                    height: 137,
                    width: 19,
                  ),
                ),
              ),
            ],
          ),

        ]
        else...[
          Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: 00, top: 30, left: 00, bottom: 10),
                height: 163,
                width: 19,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/card_left_side.png",
                    height: 137,
                    width: 19,
                  ),
                ),
              ),

              Expanded(
                child:Center(
                  child: Container(
                      margin: EdgeInsets.only(
                          right: 10, top: 30, left: 10, bottom: 10),
                      height: 163,
                      width: 316,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
                        gradient: LinearGradient(colors: [ novalexxa_visa_card_start_color,novalexxa_visa_card_end_color,],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),

                      ),
                      child: Stack(
                        children: [

                          Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          right: 00,
                                          top: 00,
                                          left: 20,
                                          bottom: 00),
                                      child: Image.asset(
                                        "assets/images/logo_for_card_.png",
                                        fit: BoxFit.fill,
                                        width: 103,
                                        height: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 20,
                                              top: 00,
                                              left: 00,
                                              bottom: 00),
                                          child: Image.asset(
                                            "assets/images/chip_for_card.png",
                                            fit: BoxFit.fill,
                                            width: 35,
                                            height: 26,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                flex: 3,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _card_number,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 2.0,
                                        fontSize: 22,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 00,
                                      top: 00,
                                      left: 00,
                                      bottom: 00),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right: 10,
                                                    top: 00,
                                                    left: 20,
                                                    bottom: 5),
                                                child: Text(
                                                  "Card Holder Name",
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                      FontWeight
                                                          .w500),
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10,
                                                  top: 00,
                                                  left: 20,
                                                  bottom: 00),
                                              child: Text(
                                                _card_holder_name,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.5,
                                                    decoration:
                                                    TextDecoration
                                                        .none,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Wrap(
                                          direction: Axis.vertical,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right: 10,
                                                    top: 00,
                                                    left: 20,
                                                    bottom: 5),
                                                child: Text(
                                                  "Expiry Date",
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400),
                                                )),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10,
                                                  top: 00,
                                                  left: 20,
                                                  bottom: 00),
                                              child: Text(
                                                _card_expire_date,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.5,
                                                    decoration:
                                                    TextDecoration
                                                        .none,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment:
                                          Alignment.centerRight,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 20,
                                                top: 00,
                                                left: 00,
                                                bottom: 00),
                                            child: Image.asset(
                                              "assets/images/visa_logo.png",
                                              fit: BoxFit.fill,
                                              width: 87,
                                              height: 27,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ],
                      )

                    /* add child content here */
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                    right: 00, top: 30, left: 00, bottom: 10),
                height: 163,
                width: 19,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    "assets/images/card_right_side.png",
                    height: 137,
                    width: 19,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 55,
            height: 55,

            margin: const EdgeInsets.only(
                left: 30, top: 00, right: 15, bottom: 00),
            // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(27.5),
              child: Container(
                  height: 55,
                  width: 55,
                  color: hint_color,
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    placeholder: 'assets/images/empty.jpg',
                    image:
                    "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                    imageErrorBuilder: (context, url, error) =>
                        Image.asset(
                          'assets/images/empty.jpg',
                          fit: BoxFit.fill,
                        ),
                  )),
            ),
          ),
        ),
        Expanded(
            child: Column(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _card_holder_name,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 22,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: 20, top: 0, left: 10, bottom: 0),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline_outlined,
                          color: novalexxa_text_color,
                          size: 25,
                        ),
                        onPressed: () {},
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
            ))
      ],
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
                const EdgeInsets.only(left: 25, top: 30, right: 25, bottom: 30),
            child: Column(
              children: [
                cartOptionItemDesign(
                    iconLink: "assets/images/icon_pin.png",
                    itemHeader: "PIN Code",
                    itemValue: "Change your PIN code",
                    iconHeight: 10,
                    iconWidth: 30),
                freezeCardItemDesign(
                  iconLink: "assets/images/icon_freeze.png",
                  itemHeader: "Freeze Card",
                  itemValue: "You can always defrost",
                ),
                cartOptionItemDesign(
                    iconLink: "assets/images/icon_limit.png",
                    itemHeader: "Change Card Limit",
                    itemValue: "Now card limit €15000",
                    iconHeight: 30,
                    iconWidth: 30),
                cartOptionItemDesign(
                    iconLink: "assets/images/icon_statement.png",
                    itemHeader: "Send Statement",
                    itemValue: "Send on the email",
                    iconHeight: 30,
                    iconWidth: 20),
                cartOptionItemDesign(
                    iconLink: "assets/images/icon_settings.png",
                    itemHeader: "Settings",
                    itemValue: "Personal and security settings",
                    iconHeight: 30,
                    iconWidth: 30),
              ],
            )));
  }

  Widget cartOptionItemDesign(
      {required String itemHeader,
      required String itemValue,
      required String iconLink,
      required double iconHeight,
      required double iconWidth}) {
    return Padding(
      padding: EdgeInsets.only(right: 00, top: 00, left: 00, bottom: 10),
      child: InkWell(
         onTap: (){
           _showToast(_user_uuidId.toString());
         },
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  // margin:  EdgeInsets.only(left: 20, right: 15,bottom: 10,top: 10),
                  width: 57,
                  height: 57,
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
                    margin: EdgeInsets.only(
                        right: 17.0, top: 17, bottom: 17, left: 17),
                    // height: double.infinity,
                    // width: double.infinity,
                    color: Colors.white,
                    child: Image.asset(
                      iconLink,
                      width: iconWidth,
                      height: iconHeight,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          itemHeader,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 17,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          itemValue,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_hint_text_color,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: hint_color,
                    size: 17.0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 10, top: 10, left: 65, bottom: 0),
              height: 1,
              color: novalexxa_customer_services_list_divider_color,
            )
          ],
        ),
      ),
    );
  }

  Widget freezeCardItemDesign(
      {required String itemHeader,
      required String itemValue,
      required String iconLink}) {
    return Padding(
      padding: EdgeInsets.only(right: 00, top: 00, left: 00, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                // margin:  EdgeInsets.only(left: 20, right: 15,bottom: 10,top: 10),
                width: 57,
                height: 57,
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
                  margin: EdgeInsets.only(
                      right: 17.0, top: 17, bottom: 17, left: 17),
                  // height: double.infinity,
                  // width: double.infinity,
                  color: Colors.white,
                  child: Image.asset(
                    iconLink,
                    width: 30,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        itemHeader,
                        style: TextStyle(
                            color: novalexxa_text_color,
                            fontSize: 17,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        itemValue,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: novalexxa_hint_text_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FlutterSwitch(
                  width: _switchButtonWidth,
                  height: _switchButtonHeight,
                  toggleSize: 20.0,
                  activeColor: novalexxa_color,
                  inactiveColor: intello_level_color,

                  value: _switchButtonStatus,
                  borderRadius: 15.0,
                  padding: 5.0,
                  //showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      _switchButtonStatus = val;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 10, top: 10, left: 65, bottom: 0),
            height: 1,
            color: novalexxa_customer_services_list_divider_color,
          )
        ],
      ),
    );
  }
  //novalexxa card list data
  _getUserNovalexxaCardDataList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_NOVALEXXA_CARD_INFO_LIST$_user_uuidId'),
          );
          Navigator.of(context).pop();
         //  showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _novalexxaCardDataList = data["data"];
              if(_novalexxaCardDataList[0]["user_info"]["name"].toString()!=null){
                _card_holder_name=_novalexxaCardDataList[0]["user_info"]["name"].toString();
              }

              if(dateConvert(_novalexxaCardDataList[0]["expiration_date"].toString())!=null){
                _card_expire_date= dateConvert(_novalexxaCardDataList[0]["expiration_date"].toString());
              }

              if(_novalexxaCardDataList[0]["card_number"].toString()!=null){
                var value =  _novalexxaCardDataList[0]["card_number"].toString().replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
                _card_number=value.toString();
              }



              // var cardNumber = _novalexxaCardDataList[0]["card_number"];
              // cardNumber = cardNumber.substring(0, 4) + " " + cardNumber.substring(4, 8) + " " + cardNumber.substring(8, 12) + " " + cardNumber.substring(12, cardNumber.length);
              // _card_number=cardNumber.toString();


            });
          } else {
            Fluttertoast.cancel();
          }
        } catch (e) {
          Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      showToast("No Internet Connection!");
    }
  }
  void _showLoadingDialog(BuildContext context, String _message) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          child: Wrap(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 30, bottom: 30),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator(
                          backgroundColor: novalexxa_color,
                          strokeWidth: 5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          _message,
                          style: TextStyle(fontSize: 25),
                        )
                      ],
                    ),
                  ))
            ],
            // child: VerificationScreen(),
          ),
        );
      },
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

  loadUserIdFromSharePref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        _userId = sharedPreferences.getString(pref_user_id)!;
        _user_uuidId = sharedPreferences.getString(pref_user_uuid)!;


      });
    } catch(e) {
      //code
    }

  }

   dateConvert(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);

    final DateFormat format = DateFormat('MM/dd');
    final String formatted = format.format(dateTime);
    return formatted;
  }

}
