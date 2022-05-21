import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../common/Colors.dart';



class ScanDocFrontParticularScreen extends StatefulWidget {
  const ScanDocFrontParticularScreen({Key? key}) : super(key: key);

  @override
  State<ScanDocFrontParticularScreen> createState() => _ScanDocFrontParticularScreenState();
}

class _ScanDocFrontParticularScreenState extends State<ScanDocFrontParticularScreen> {
  String countryName="en",countryIcon="icon_country.png";


  String _genderDropDownSelectedValue = "English";
  final List<String> _countryNameList = ["English", "French", "Spanish","Italian",
    "German","Indonesia","Portugues","Romana","Arabics"];
  final List<String> _countryNameIcon = ["icon_country.png", "icon_country.png", "icon_country.png","icon_country.png",
    "German","icon_country.png","icon_country.png","icon_country.png","icon_country.png"];

int _particular_company_selected_status=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body:Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
            child:   LinearPercentIndicator(
              // width: MediaQuery.of(context).size.width - 80,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 1000,
              percent: 0.85,
              center: Text("85%"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              fillColor:Colors.white,
              backgroundColor: novalexxa_indicator_unselected_color,
              progressColor: novalexxa_color,
            ),
          ),

          SizedBox(
            height: 50,
          ),


          Container(
            margin: EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
            child:   userInputEmail(),
          ),
          Expanded(child: Column(
            children: [
              Flex(direction: Axis.horizontal,
                children: [
                  Container(
                      height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                              color: Colors.green,
                              width: 5,

                            ),
                            top: BorderSide(
                              color: Colors.indigo,
                              width: 7,
                            ),
                            right: BorderSide(
                              color: Colors.black45,
                              width: 5,
                            ),
                            bottom: BorderSide(
                              color: Colors.orange,
                              width: 20,
                            ))),
                  ),

                ],

              )


            ],

          )),

          SizedBox(
            height: 50,
          ),

          Container(
            child: _buildNextButton(),
          ),

          SizedBox(height: 25,),
          Container(
            child: _buildRetryButton(),
          ),



        ],
      ),
    );
  }


  Widget userInputEmail() {
    return Container(
      height: 110,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color:scan_text_box_color, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 0,bottom: 0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Scan Document",
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Scan the front of your document",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: novalexxa_hint_text_color,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ],

        ),
      ),
    );
  }


  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if(_particular_company_selected_status==1){

            Navigator.push(context,MaterialPageRoute(builder: (context)=>PrivacyPolicyForParticularScreen()));
          }
          else{
            Navigator.push(context,MaterialPageRoute(builder: (context)=>PrivacyPolicyForCompanyScreen()));
          }

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [novalexxa_color,novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
              "Next",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRetryButton() {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SplashScreen4()));
      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  Text(
          "Retry",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 20,
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

