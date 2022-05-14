
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/common/log_in.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'confirm_number_particular.dart';

class SignUpForParticularScreen extends StatefulWidget {
  const SignUpForParticularScreen({Key? key}) : super(key: key);

  @override
  State<SignUpForParticularScreen> createState() => _SignUpForParticularScreenState();
}

class _SignUpForParticularScreenState extends State<SignUpForParticularScreen> {
  String countryName="en",countryIcon="icon_country.png";

  String _genderDropDownSelectedValue = "English";
  final List<String> _countryNameList = ["English", "French", "Spanish","Italian",
    "German","Indonesia","Portugues","Romana","Arabics"];
  final List<String> _countryNameIcon = ["icon_country.png", "icon_country.png", "icon_country.png","icon_country.png",
    "German","icon_country.png","icon_country.png","icon_country.png","icon_country.png"];

  int _particular_company_selected_status=1;
  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _phoneController = TextEditingController();
  TextEditingController? _countryController = TextEditingController();
  TextEditingController? _promoCodeController = TextEditingController();
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
                      percent: 0.3,
                      center: Text("30%"),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      fillColor:Colors.white,
                      backgroundColor: novalexxa_indicator_unselected_color,
                      progressColor: novalexxa_color,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 20.0,top: 00,left: 10),
                      child:Align(alignment: Alignment.topLeft,
                          child:Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/images/logo_icon.png",
                              width: 71,
                              height: 71,
                              fit: BoxFit.fill,
                            ),
                          )


                      ),
                    ),


                    Container(
                      margin:EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.topLeft,
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color: Colors.intello_easylearn_bold_text_color_,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 20.0,top: 10,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Register with your email address and password.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_hint_text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),


                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Email",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 0,
                    ),
                    userInputEmail(_emailController!, 'Email', TextInputType.emailAddress),


                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Phone Number",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    userInputPhoneNumber(_phoneController!, 'Phone Number', TextInputType.phone),
                    //country
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Country",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    userInputCountry(_countryController!, 'Country', TextInputType.text),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Promo code",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    userPromoCode(_promoCodeController!, 'Prome code', TextInputType.text),
                    SizedBox(
                      height: 35,
                    ),

                    DelayedWidget(

                      delayDuration: Duration(milliseconds: 100),// Not required
                      animationDuration: Duration(milliseconds: 1000),// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child:Flex(direction: Axis.vertical,
                        children: [
                          _buildNextButton(),
                          Container(
                            margin:EdgeInsets.only(right: 20.0,top: 15,left: 10,bottom: 0),
                            child: Flex(direction: Axis.horizontal,
                              children: [
                                Text(
                                  "Already have an account?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PT-Sans',
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                InkResponse(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>const LogInScreen()));
                                  },
                                  child: Align(alignment: Alignment.centerLeft,
                                    child:  Text(
                                      " Sign In",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'PT-Sans',
                                        decoration: TextDecoration.underline,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),),

                                )
                              ],
                            ),
                          ),


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

  Widget userInputEmail(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.,

            focusedBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),

            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon:  Icon(
              Icons.email,
              color: Colors.intello_hint_color,
              size: 22.0,
            ),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: novalexxa_text_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget userInputPhoneNumber(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.none,
            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            focusedBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),
            suffixIcon:  Icon(
              Icons.phone_iphone,
              color: Colors.intello_hint_color,
              size: 22.0,
            ),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: novalexxa_text_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget userInputCountry(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.none,
            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            focusedBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),
            suffixIcon:Image(
              image: AssetImage(
                "assets/images/icon_country.png",
              ),
              height: 15,
              width: 18,
              fit: BoxFit.fill,
            ),


            hintText: hintTitle,
            hintStyle:  TextStyle(fontSize: 17, color: novalexxa_text_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget userPromoCode(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.done,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.none,
            suffixIconConstraints: BoxConstraints(
              minHeight: 12,
              minWidth: 12,
            ),
            suffixIcon: Image(
              image: AssetImage(
                "assets/images/promo_code_icon.png",

              ),

              height: 18,
              width: 18,
              fit: BoxFit.fill,
            ),
            focusedBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),
            hintText: hintTitle,
            hintStyle:  TextStyle(fontSize: 17, color: novalexxa_text_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {

          //_showToast(_particular_company_selected_status.toString());
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ConfirmNumberForParticularScreen()));
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

