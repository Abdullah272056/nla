import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:page_transition/page_transition.dart';

import '../common/create_account_particular_company.dart';
import '../common/log_in.dart';

class SplashScreen4 extends StatefulWidget {
  const SplashScreen4({Key? key}) : super(key: key);

  @override
  State<SplashScreen4> createState() => _SplashScreen4State();
}

class _SplashScreen4State extends State<SplashScreen4> {
  String countryName="en",countryIcon="icon_country.png";


  String _genderDropDownSelectedValue = "English";
  final List<String> _countryNameList = ["English", "French", "Spanish","Italian",
    "German","Indonesia","Portugues","Romana","Arabics"];
  final List<String> _countryNameIcon = ["icon_country.png", "icon_country.png", "icon_country.png","icon_country.png",
    "German","icon_country.png","icon_country.png","icon_country.png","icon_country.png"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Flex(
            direction: Axis.vertical,
            children: [
              SizedBox(
                height: 45,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 30),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 0, top: 0, right: 15, bottom: 0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 100,
                            height: 40,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0)),
                              border: Border.all(
                                color: novalexxa_rounded_border_color, //                   <--- border color
                                width: 1.0, //                   <--- border width here
                              ),

                            ),
                            child:Align(
                              alignment: Alignment.center,
                              child: _buildDropDownMenu(),
                            ),
                          ),
                        ),
                      ),
                      Container(

                        margin:EdgeInsets.only(right:15.0,top: 50,left: 15,
                          bottom: 50,
                        ),
                        child:DelayedWidget(

                          delayDuration: Duration(milliseconds: 100),// Not required
                          animationDuration: Duration(milliseconds: 500),// Not required
                          animation: DelayedAnimations.SLIDE_FROM_LEFT,// Not required
                          child: Image.asset(
                            "assets/images/vector3.png",
                            // width: 81,
                            //height: 230,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
                        child:  Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Send Money Fastly around\nthe World",
                            textAlign: TextAlign.center,

                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
                        child:  Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dunt ut labore et dolore magna aliqua",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20, top: 50, right: 20, bottom: 0),
                        child:  Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //Center Column contents vertically,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                                decoration: const BoxDecoration(
                                  color: novalexxa_next_page_circle_color,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0),
                                    bottomLeft: Radius.circular(4.0),
                                  ),
                                ),
                                height: 8,
                                width: 8,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                                decoration: const BoxDecoration(
                                  color: novalexxa_next_page_circle_color,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0),
                                    bottomLeft: Radius.circular(4.0),
                                  ),
                                ),
                                height: 8,
                                width: 8,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                                decoration: const BoxDecoration(
                                  color: novalexxa_color,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0),
                                    bottomLeft: Radius.circular(4.0),
                                  ),
                                ),
                                height: 8,
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 40, top: 40, right: 40, bottom: 0),
                        child:  Align(
                          alignment: Alignment.topCenter,
                          child: _buildSignUpButton(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 0),
                        child:  Align(
                          alignment: Alignment.topCenter,
                          child:  _buildLogInButton(),
                        ),
                      ),



                    ],
                  ))

            ],
          ) /* add child content here */,
        ),
      ),
    );
  }



  Widget _buildSignUpButton() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child: ElevatedButton(
        onPressed: () {

         Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateAccountParticularAndCompanyScreen()));
          // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SplashScreen4()));

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
              "Sign Up",
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

  Widget _buildLogInButton() {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));

      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  Text(
          "LogIn",
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


  Widget _buildDropButton() {
    return Container(
      padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
      child: InkResponse(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Container(
           // padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              //direction: Axis.horizontal,
              children: [
                Align(
                  alignment: Alignment.center,
                  child:  Image.asset(
                    "assets/images/$countryIcon",
                    height: 18,
                    width: 18,
                  ),
                ),


                SizedBox(width: 5,),
                Align(
                  alignment: Alignment.center,
                  child:   Text(
                    countryName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: novalexxa_hint_text_color,
                    ),
                  ),
                ),


                SizedBox(width: 0,),
                Align(
                  alignment: Alignment.center,
                  child:Icon(
                    Icons.arrow_drop_down_sharp,
                    color: novalexxa_hint_text_color,
                    size: 18.0,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Drop Down Menu
  Widget _buildDropDownMenu() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(

        customButton: Container(
          child: _buildDropButton(),
        ),
        // openWithLongPress: true,
        customItemsIndexes: const [4],
        customItemsHeight: 8,
        items: [
          ...MenuItems.firstItems.map(
                (item) =>
                DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
        ],
        onChanged: (value) {
          switch (value as MenuItem) {
            case MenuItems.English:
              setState(() {
                countryName="en";
              });

              //Do something
              break;
            case MenuItems.French:
              setState(() {
                countryName="fr";
              });
              //Do something
              break;
            case MenuItems.Spanish:
              setState(() {
                countryName="es";
              });
              break;
            case MenuItems.Italian:
              setState(() {
                countryName="it";
              });
              break;
          }
          // MenuItems.onChanged(context, value as MenuItem);
        },
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 10, right: 10),
        //dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 0),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 0),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final String imageLink;

  const MenuItem({
    required this.text,
    required this.imageLink,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [English, French, Spanish,Italian];


  static const English = MenuItem(text: 'en', imageLink: "assets/images/icon_country.png" );
  static const French = MenuItem(text: 'fr', imageLink: "assets/images/icon_country.png");
  static const Spanish = MenuItem(text: 'es', imageLink: "assets/images/icon_country.png");
  static const Italian = MenuItem(text: 'it', imageLink: "assets/images/icon_country.png");


  static Widget buildItem(MenuItem item) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Image.asset(
          "assets/images/icon_country.png",
          height: 20,
          width: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          item.text,

          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.English:
      //countryName="en";
      //Do something
        break;
      case MenuItems.French:
      //Do something
        break;
      case MenuItems.Spanish:
      //Do something
        break;
      case MenuItems.Italian:
      //Do something
        break;
    }
  }
}
