

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../static/Colors.dart';



class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsSettingsScreen> createState() => _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState extends State<NotificationsSettingsScreen> {

  //image upload
  PickedFile? _imageFile;
  final ImagePicker _picker=ImagePicker();
  String _imageLink = "";
  File? imageFile;


  bool _generalSettingItem1=false;
  bool _generalSettingItem2=false;
  bool _generalSettingItem3=false;
  bool _generalSettingItem4=false;
  bool _pushSettingItem1=false;
  bool _pushSettingItem2=false;

  double _switchButtonWidth=45;
  double _switchButtonHeight=27;
  double _buttonToggleSize=20;


  @override
  @mustCallSuper
  initState() {
    super.initState();
    // Timer(Duration(milliseconds: 1500), () {
    //   setState(() {
    //    Navigator.push(context,MaterialPageRoute(builder: (context)=>NoNotificationsScreen()));
    //
    //   });
    //
    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white,
      body:Center(
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
                      margin: new EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Notifications Settings",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                ),


              ],
            ),



            Expanded(child:

            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(alignment: Alignment.topLeft,
                 child:Container(
                   margin:  EdgeInsets.only(right: 30.0, top: 40, bottom: 0, left: 30),
                   child:Text(
                     "General Settings",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         color: novalexxa_text_color,
                         fontSize: 20,
                         fontWeight: FontWeight.w500),
                   ),
                 )


                ),
                generalOptionSection(),
                Align(alignment: Alignment.topLeft,
                    child:Container(
                      margin:  EdgeInsets.only(right: 30.0, top: 30, bottom: 0, left: 30),
                      child:Text(
                        "Push Notification",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: novalexxa_text_color,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    )


                ),
                pushNotificationOptionSection()




              ],
            ))


          ],
        ),
      ),
    );
  }



  Widget generalOptionSection() {
    return  Container(
      margin:  EdgeInsets.only(right: 30.0, top: 40, bottom: 10, left: 30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.35),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      //   height: 150,
      child: Container(
        padding: const EdgeInsets.only(left: 0.0, right: 0.0,top: 0,bottom: 0),
        child: Column(
          children: [
            //teacher profile

            Container(
              height: 60,
              child: g_option_item1("Option Item 1"),
            ),
            Container(
              height: 1,
              color: intello_level_color,
            ),

            Container(
              height: 60,
              child: g_option_item2("Option Item 2"),
            ),
            Container(
              height: 1,
              color: intello_level_color,
            ),
            Container(
              height: 60,
              child: g_option_item3("Option Item 3"),
            ),
            Container(
              height: 1,
              color: intello_level_color,
            ),
            Container(
              height: 60,
              child:  g_option_item4("Option Item 4"),
            ),

          ],
        ),
      ),
    );
  }



  Widget g_option_item1(String optionsName) {
    return  Padding(
      padding: EdgeInsets.only(left: 20.0, top: 0, bottom: 0, right: 20),
      child: Flex(
        direction: Axis.horizontal,
        children: [

          Expanded(
              child: Text(optionsName,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal))),
          FlutterSwitch(
            width: _switchButtonWidth,
            height: _switchButtonHeight,
            toggleSize: 20.0,
            activeColor:novalexxa_color,
            inactiveColor: intello_level_color,

            value: _generalSettingItem1,
            borderRadius: 15.0,
            padding: 5.0,
            //showOnOff: true,
            onToggle: (val) {
              setState(() {
                _generalSettingItem1 = val;
              });
            },
          ),


        ],
      ),
    );
  }
  Widget g_option_item2(String optionsName) {
    return  Padding(
      padding: EdgeInsets.only(left: 20.0, top: 0, bottom: 0, right: 20),
      child: Flex(
        direction: Axis.horizontal,
        children: [

          Expanded(
              child: Text(optionsName,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal))),
          FlutterSwitch(
            width: _switchButtonWidth,
            height: _switchButtonHeight,
            toggleSize: _buttonToggleSize,
            activeColor:novalexxa_color,
            inactiveColor: intello_level_color,

            value: _generalSettingItem2,
            borderRadius: 15.0,
            padding: 5.0,
            //showOnOff: true,
            onToggle: (val) {
              setState(() {
                _generalSettingItem2 = val;
              });
            },
          ),


        ],
      ),
    );
  }
  Widget g_option_item3(String optionsName) {
    return  Padding(
      padding: EdgeInsets.only(left: 20.0, top: 0, bottom: 0, right: 20),
      child: Flex(
        direction: Axis.horizontal,
        children: [

          Expanded(
              child: Text(optionsName,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal))),
          FlutterSwitch(
            width: _switchButtonWidth,
            height: _switchButtonHeight,
            toggleSize: _buttonToggleSize,
            activeColor:novalexxa_color,
            inactiveColor: intello_level_color,

            value: _generalSettingItem3,
            borderRadius: 15.0,
            padding: 5.0,
            //showOnOff: true,
            onToggle: (val) {
              setState(() {
                _generalSettingItem3 = val;
              });
            },
          ),


        ],
      ),
    );
  }
  Widget g_option_item4(String optionsName) {
    return  Padding(
      padding: EdgeInsets.only(left: 20.0, top: 0, bottom: 0, right: 20),
      child: Flex(
        direction: Axis.horizontal,
        children: [

          Expanded(
              child: Text(optionsName,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal))),
          FlutterSwitch(
            width: _switchButtonWidth,
            height:_switchButtonHeight,
            toggleSize:_buttonToggleSize,
            activeColor:novalexxa_color,
            inactiveColor: intello_level_color,

            value: _generalSettingItem4,
            borderRadius: 15.0,
            padding: 5.0,
            //showOnOff: true,
            onToggle: (val) {
              setState(() {
                _generalSettingItem4 = val;
              });
            },
          ),


        ],
      ),
    );
  }
  Widget pushNotificationOptionSection() {
    return  Container(
      margin:  EdgeInsets.only(right: 30.0, top: 30, bottom: 10, left: 30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.35),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      //   height: 150,
      child: Container(
        padding: const EdgeInsets.only(left: 0.0, right: 0.0,top: 0,bottom: 0),
        child: Column(
          children: [
            //teacher profile

            Container(
              height: 60,
              child: pn_option_item1("Option Item 1"),
            ),
            Container(
              height: 1,
              color: intello_level_color,
            ),

            Container(
              height: 60,
              child: pn_option_item2("Option Item 2"),
            ),


          ],
        ),
      ),
    );
  }
  Widget pn_option_item1(String optionsName) {
    return  Padding(
      padding: EdgeInsets.only(left: 20.0, top: 0, bottom: 0, right: 20),
      child: Flex(
        direction: Axis.horizontal,
        children: [

          Expanded(
              child: Text(optionsName,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal))),
          FlutterSwitch(
            width: _switchButtonWidth,
            height: _switchButtonHeight,
            toggleSize:_buttonToggleSize,
            activeColor:novalexxa_color,
            inactiveColor: intello_level_color,

            value: _pushSettingItem1,
            borderRadius: 15.0,
            padding: 5.0,
            //showOnOff: true,
            onToggle: (val) {
              setState(() {
                _pushSettingItem1 = val;
              });
            },
          ),


        ],
      ),
    );
  }
  Widget pn_option_item2(String optionsName) {
    return  Padding(
      padding: EdgeInsets.only(left: 20.0, top: 0, bottom: 0, right: 20),
      child: Flex(
        direction: Axis.horizontal,
        children: [

          Expanded(
              child: Text(optionsName,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal))),
          FlutterSwitch(
            width: _switchButtonWidth,
            height: _switchButtonHeight,
            toggleSize: _buttonToggleSize,
            activeColor:novalexxa_color,
            inactiveColor: intello_level_color,

            value: _pushSettingItem2,
            borderRadius: 15.0,
            padding: 5.0,
            //showOnOff: true,
            onToggle: (val) {
              setState(() {
                _pushSettingItem2 = val;
              });
            },
          ),


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

