
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/Particular/particular_information2.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_congrats.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_details_particular2.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../api_service/api_service.dart';


class TransferMoneyDetailForParticularFromMobileScreen extends StatefulWidget {
  const TransferMoneyDetailForParticularFromMobileScreen({Key? key}) : super(key: key);

  @override
  State<TransferMoneyDetailForParticularFromMobileScreen> createState() => _TransferMoneyDetailForParticularFromMobileScreenState();
}

class _TransferMoneyDetailForParticularFromMobileScreenState extends State<TransferMoneyDetailForParticularFromMobileScreen> {

  String _firstCountryCode = "IT";
  String _secondCountryCode = "CA";



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
                          "Transfer Money",
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
            SizedBox(
              height: 25,
            ),

            Container(
              margin: EdgeInsets.only(left:20, top: 10, right: 20, bottom: 00),
              child: new LinearPercentIndicator(
                // width: MediaQuery.of(context).size.width - 80,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 1000,
                percent: 0.6,
                center: Text("60%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                fillColor:Colors.white,
                backgroundColor: novalexxa_indicator_unselected_color,
                progressColor: novalexxa_color,
              ),
            ),


            _buildDollarExchangeRate(),


            Container(
              margin:EdgeInsets.only(right: 20.0,top: 50,left: 30,bottom: 0),
              child: Align(alignment: Alignment.centerLeft,
                child: Text(
                  "Select the recipient Mobile Operator",
                  textAlign: TextAlign.left,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
              SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSelectMobileMoneyTelecomItalia(iconLink: "assets/images/icon_telecom_italia.png"),
                _buildSelectMobileMoneyVodafone(iconLink: "assets/images/icon_vodafone.png"),
                _buildSelectMobileMoneyIliadTelecom(iconLink: "assets/images/icon_Iliad.png"),

              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }


  Widget _buildDollarExchangeRate() {
    return Container(
      height: 115,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0,top: 60),
      padding: const EdgeInsets.only(left: 00.0, right: 00.0),
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

      child: Stack(
        children: [
          Expanded(child: Align(alignment: Alignment.topRight,
          child: InkWell(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyDetailForParticularScreen2(
                  ),),
              );
            },
            child: Container(
              height: 24,
              width: 24,
              margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
              decoration: new BoxDecoration(
                color: notification_image_bg_color,
                borderRadius: BorderRadius.circular(27),

              ),
              child:

              Center(
                child:  Icon(
                  Icons.edit,
                  color:hint_color,
                  size: 15.0,
                ),
              ),

            ),
          )


          )),


          Row(
            children: [
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:   ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Flag.fromString(_firstCountryCode, height: 23, width: 32, fit: BoxFit.fill ),
                    ),
                  ),

                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.center,
                    child:   Text(
                      "250.00",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: intello_input_text_color,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  SizedBox(height: 5,),
                  Align(
                    alignment: Alignment.center,
                    child:   Text(
                      "Transfer Fees: 3.8 €",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: intello_level_color,
                          fontSize: 9,
                          fontWeight: FontWeight.normal),
                    ),
                  ),

                ],
              )),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:   ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Flag.fromString(_secondCountryCode, height: 23, width: 32, fit: BoxFit.fill ),
                    ),
                  ),

                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.center,
                    child:   Text(
                      "382.24",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: intello_input_text_color,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  SizedBox(height: 5,),
                  Align(
                    alignment: Alignment.center,
                    child:   Text(
                      "Exchange Rate: 1 € = 1.53 CAD",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: intello_level_color,
                          fontSize: 9,
                          fontWeight: FontWeight.normal),
                    ),
                  ),

                ],
              )),
            ],
          ),
        ],
      )

    );
  }

  Widget _buildSelectMobileMoneyTelecomItalia({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkResponse(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyCongratsScreen(
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
              height: 92,
              width: 92,
              child: Center(
                child: Container(
                  height: 54,
                  width: 54,
                  // padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
                  decoration: new BoxDecoration(
                    color: notification_image_bg_color,
                    borderRadius: BorderRadius.circular(27),

                  ),
                  child:

                  Center(
                    child:  Image.asset(
                      iconLink,
                      height: 24,
                      width: 27,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),

          SizedBox(height: 15,),
          Text(
            "Telecom Italia",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }


  Widget  _buildSelectMobileMoneyVodafone({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          InkResponse(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyCongratsScreen(
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
              height: 92,
              width: 92,
              child: Center(
                child: Container(
                  height: 54,
                  width: 54,
                  // padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
                  decoration: new BoxDecoration(
                    color: notification_image_bg_color,
                    borderRadius: BorderRadius.circular(27),

                  ),
                  child:

                  Center(
                    child:  Image.asset(
                      iconLink,
                      height: 28,
                      width: 28,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),
          SizedBox(height: 15,),
          Text(
            "Vodafone",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildSelectMobileMoneyIliadTelecom({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          InkResponse(
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyCongratsScreen(
                  ),),
              );
            },
            child:  Container(

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
              height: 92,
              width: 92,
              child: Center(
                child: Container(
                  height: 54,
                  width: 54,
                  padding: const EdgeInsets.only(left: 5.0, ),
                  decoration: new BoxDecoration(
                    color: notification_image_bg_color,
                    borderRadius: BorderRadius.circular(27),

                  ),
                  child:

                  Center(
                    child:  Image.asset(
                      iconLink,
                      height: 14,
                      width: 32,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),
          SizedBox(height: 15,),
          Text(
            "Iliad Telecom",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 13,
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

