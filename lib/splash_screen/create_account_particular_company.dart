import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/splash_screen/privacy_policy_for_company.dart';
import 'package:nova_lexxa/splash_screen/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CreateAccountParticularAndCompanyScreen extends StatefulWidget {
  const CreateAccountParticularAndCompanyScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountParticularAndCompanyScreen> createState() => _CreateAccountParticularAndCompanyScreenState();
}

class _CreateAccountParticularAndCompanyScreenState extends State<CreateAccountParticularAndCompanyScreen> {
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
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(
              height: 55,
            ),
            Padding(
                padding:
                const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
                child: Column(
                  children: [
                    new LinearPercentIndicator(
                      // width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1000,
                      percent: 0.1,
                      center: Text("10%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      fillColor:Colors.white,
                      backgroundColor: Colors.novalexxa_indicator_unselected_color,
                      progressColor: Colors.novalexxa_color,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Create Account as",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: Colors.novalexxa_text_color,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dunt ut labore et dolore magna aliqua",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.novalexxa_hint_text_color,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                    if(_particular_company_selected_status==1)...[
                      _buildParticularSelectedSection(),

                    ]else...{
                      _buildCompanySelectedSection(),
                    },
                    SizedBox(
                      height: 50,
                    ),

                    DelayedWidget(

                      delayDuration: Duration(milliseconds: 100),// Not required
                      animationDuration: Duration(milliseconds: 1000),// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child:Flex(direction: Axis.vertical,
                        children: [
                          _buildNextButton(),
                          _buildHaveAnAccountButton()
                        ],
                      ),
                    )

                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildParticularSelectedSection() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child:Stack(
        children: [
          Container(
              margin:EdgeInsets.only(right:00.0,top: 10,left: 142,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                  setState(() {
                    _particular_company_selected_status=2;
                  });
                },
                child: Image.asset(
                  "assets/images/company_unselected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )
          ),


          Container(
              margin:EdgeInsets.only(right:00.0,top: 10,left: 00,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                  setState(() {
                    _particular_company_selected_status=1;
                  });

                },
                child:  Image.asset(
                  "assets/images/particular_selected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildCompanySelectedSection() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child:Stack(
        children: [
          Container(
              margin:EdgeInsets.only(right:00.0,top: 10,left: 00,
                bottom: 20,
              ),
              child: InkResponse(
                onTap: (){
                  //_showToast("particular");
                  setState(() {
                    _particular_company_selected_status=1;
                  });

                },
                child: Image.asset(
                  "assets/images/particular_unselected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )

          ),
          Container(
              margin:EdgeInsets.only(right:00.0,top: 10,left: 142,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                 // _showToast("company");
                  setState(() {
                    _particular_company_selected_status=2;
                  });

                },
                child: Image.asset(
                  "assets/images/company_selected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )




          ),

        ],
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

          _showToast(_particular_company_selected_status.toString());
         // Navigator.push(context,MaterialPageRoute(builder: (context)=>SplashScreen4()));
          // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SplashScreen4()));

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.novalexxa_color, Colors.novalexxa_color],
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

  Widget _buildHaveAnAccountButton() {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SplashScreen4()));
      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  Text(
          "I have an Account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.novalexxa_text_color,
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
        backgroundColor: Colors.intello_bd_color_dark,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}

