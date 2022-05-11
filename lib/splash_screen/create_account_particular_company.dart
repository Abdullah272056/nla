import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/splash_screen/privacy_policy_for_particular.dart';
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
                      backgroundColor: Colors.intello_page_unselected_tab_color,
                      progressColor: Colors.novalexxa_color,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Create Account as",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: Colors.intello_easylearn_bold_text_color_,
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
                          color: Colors.intello_hint_color,
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

  Widget _buildBottomDesign() {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 36, top: 10, right: 36, bottom: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                ),
                Text(
                  "Easily learn what you want,\n where you want",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: Colors.intello_easylearn_bold_text_color_,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and type setting industry when and the "
                      "unknown printer took a gallery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.intello_small_text_color_,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 2.0, right: 2.0),
                      decoration: const BoxDecoration(
                        color: Colors.intello_bd_color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                      ),
                      height: 2,
                      width: 11,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 2.0, right:2.0),
                      decoration: const BoxDecoration(
                        color: Colors.intello_page_unselected_tab_color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                      ),
                      height: 2,
                      width: 11,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 2.0, right: 2.0),
                      decoration: const BoxDecoration(
                        color: Colors.intello_page_unselected_tab_color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                      ),
                      height: 2,
                      width: 11,
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                _buildNextButton()
              ],
            )));
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
        _showToast("have an account");
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
            color: Colors.black,
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
                      color: Colors.hint_color,
                    ),
                  ),
                ),


                SizedBox(width: 0,),
                Align(
                  alignment: Alignment.center,
                  child:Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.hint_color,
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
