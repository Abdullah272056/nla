
import 'dart:convert';
import 'dart:io';

import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/money_option/top_up_account/top_up_amount_page.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_congrats.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_details_From_mobile.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TopUpScreenScreen extends StatefulWidget {
  const TopUpScreenScreen({Key? key}) : super(key: key);

  @override
  State<TopUpScreenScreen> createState() => _TopUpScreenScreenState();
}

class _TopUpScreenScreenState extends State<TopUpScreenScreen> {


  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _surnameController = TextEditingController();
  TextEditingController? _birthDayController = TextEditingController();
  String _countryBirthDay="Enter Birthday";
  String select_your_country="Enter Birthday";

  double _switchButtonWidth = 40;
  double _switchButtonHeight = 25;
  double _buttonToggleSize = 20;
  bool _switchButtonStatus = false;
  String _countryName = "Select your country";
  String _countryNameId = "0";
  String _countryCode = "IT";
  List _countryList = [];
  TextEditingController? _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body: SingleChildScrollView(
        child: Column(

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
                      color: novalexxa_text_color,
                      size: 30.0,
                    ),
                  ),
                ),

                Expanded(
                    child: Container(
                      margin: new EdgeInsets.only(right: 60),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Top Up Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                ),

              ],
            ),


            Container(
              margin:EdgeInsets.only(right: 20.0,top: 80,left: 20,bottom: 0),
              child: Align(alignment: Alignment.center,
                child: Text(
                  "Select your Topup Method",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 23,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),

            Container(
              margin:EdgeInsets.only(right: 20.0,top: 30,left: 20,bottom: 0),
              child: Align(alignment: Alignment.center,
                child: Text(
                  "Lorem Ipsum is simple dummy text of the printing and industry ipsum has been the industry",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: intello_level_color,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),

            SizedBox(height: 40,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Center(
                  child: _buildSelectCreditCartItem(iconLink: "assets/images/icon_credit_cart.png"),
                )),
                Expanded(child: Center(
                  child: _buildSelectMobileMoneyItem(iconLink: "assets/images/icon_mobile_money.png"),
                )),




              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectCreditCartItem({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left:15.0, right: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkResponse(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => TopUpAmountPageScreen(
                  ),),
              );
            },
            child: Container(

              // padding: const EdgeInsets.only(left: 18.0, right: 18.0,top: 18,bottom: 18),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.25),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      2.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              height: 130,
              width: 130,
              child: Center(
                child: Container(
                  height: 80,
                  width: 80,
                  // padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
                  decoration: new BoxDecoration(
                    color: notification_image_bg_color,
                    borderRadius: BorderRadius.circular(40),

                  ),
                  child:

                  Center(
                    child:  Image.asset(
                      iconLink,
                      height: 45,
                      width: 45,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),

          SizedBox(height: 15,),
          Text(
            "Credit Cart",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildSelectMobileMoneyItem({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          InkResponse(
            onTap: (){
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     settings: RouteSettings(name: "Foo"),
              //     builder: (BuildContext context) => TransferMoneyCongratsScreen(
              //     ),),
              // );
            },
            child: Container(

              // padding: const EdgeInsets.only(left: 18.0, right: 18.0,top: 18,bottom: 18),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.25),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      2.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              height: 130,
              width: 130,
              child: Center(
                child: Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.only(left: 5.0, right: 0.0,top: 0,bottom: 0),
                  decoration: new BoxDecoration(
                    color: notification_image_bg_color,
                    borderRadius: BorderRadius.circular(40),

                  ),
                  child:

                  Center(
                    child:  Image.asset(
                      iconLink,
                      height: 45,
                      width: 40,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),
          SizedBox(height: 15,),
          Text(
            "Mobile Money",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        ],
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
        textColor: Colors.black,
        fontSize: 16.0);
  }

}



