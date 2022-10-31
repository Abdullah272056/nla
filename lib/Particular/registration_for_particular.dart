
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';

import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/log_in/log_in.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../api_service/api_service.dart';
import '../common/static/loding_dialog.dart';
import '../common/static/toast.dart';
import 'confirm_number_particular.dart';

class SignUpForParticularScreen extends StatefulWidget {
  const SignUpForParticularScreen({Key? key}) : super(key: key);

  @override
  State<SignUpForParticularScreen> createState() => _SignUpForParticularScreenState();
}

class _SignUpForParticularScreenState extends State<SignUpForParticularScreen> {
  String countryName="en",countryIcon="icon_country.png";


  TextEditingController? _emailController = TextEditingController();
  TextEditingController? _phoneController = TextEditingController();
  TextEditingController? _countryController = TextEditingController();
  TextEditingController? _promoCodeController = TextEditingController();

  String _countryName="Select your country";
  String select_your_country="Select your country";
  String _countryNameId = "0";

  //String _countryCode="IT";
  String _countryCode = "IT";
  String _countryCodeForPhone = "";


  //var homeSearchResultData;
  List _countryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body: SingleChildScrollView(
        child: Column(

          children: [
            const SizedBox(
              height: 55,
            ),
            Padding(
                padding:
                const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      // width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1000,
                      percent: 0.3,
                      center: const Text("30%"),
                      barRadius: const Radius.circular(10),
                      fillColor:Colors.white,
                      backgroundColor: novalexxa_indicator_unselected_color,
                      progressColor: novalexxa_color,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin:const EdgeInsets.only(right: 20.0,top: 00,left: 10),
                      child:Align(alignment: Alignment.topLeft,
                          child:Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(0, 2), // changes position of shadow
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
                      margin:const EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: const Align(alignment: Alignment.topLeft,
                        child: Text(
                          "Register",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.only(right: 20.0,top: 10,left: 10,bottom: 0),
                      child: const Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Register with your email address and password.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_hint_text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Email',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: novalexxa_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),

                            ],
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 0,
                    ),
                    userInputEmail(_emailController!, 'Email', TextInputType.emailAddress),


                    //country
                    const SizedBox(
                      height: 20,
                    ),


                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Country',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: novalexxa_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),

                            ],
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    userInputCountry(_countryController!, 'Country', TextInputType.text),
                    Container( color: novalexxa_hint_text_color,
                      margin:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
                      height: .6,
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Phone Number',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: novalexxa_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),

                            ],
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),



                    userInputPhoneNumber(_phoneController!, 'Phone Number', TextInputType.phone),

                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Promo code',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: ' (optional)',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400)
                              ),

                            ],
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 0,
                    ),
                    userPromoCode(_promoCodeController!, 'Promo code', TextInputType.text),
                    const SizedBox(
                      height: 35,
                    ),

                    DelayedWidget(

                      delayDuration: const Duration(milliseconds: 100),// Not required
                      animationDuration: const Duration(milliseconds: 1000),// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child:Flex(direction: Axis.vertical,
                        children: [
                          _buildNextButton(),
                          Container(
                            margin:const EdgeInsets.only(right: 20.0,top: 15,left: 10,bottom: 0),
                            child: Flex(direction: Axis.horizontal,
                              children: [
                                const Text(
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
                                  child: const Align(alignment: Alignment.centerLeft,
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


  ///user email input box
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

            focusedBorder:const UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:const UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),

            suffixIconConstraints: const BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon:  const Icon(
              Icons.email,
              color:hint_color,
              size: 22.0,
            ),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  ///user phone input box
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
            suffixIconConstraints: const BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            focusedBorder:const UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:const UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),
            suffixIcon: _countryCodeForPhone.isEmpty?const Icon(
              Icons.phone_iphone,
              color: hint_color,
              size: 22.0,
            ):
            Flag.fromString(_countryCode, height: 18, width: 22, fit: BoxFit.fill),

            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }


  ///user country input box
  Widget userInputCountry(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return InkResponse(
      onTap: (){
        setState(() {
          // _countryName="Bangladesh";
          // _countryCode=FlagsCode.BD;
          _getCountryDataList();
        });
      },
      child: Container(
        height: 52,

        child: Padding(
          padding:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
          child:Flex(direction: Axis.horizontal,
            children: [
              if(_countryName==select_your_country)...{
                Expanded(child: Text(_countryName,
                    style: const TextStyle(
                        color: hint_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              }
              else...{
                Expanded(child: Text(_countryName,
                    style: const TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              },

              Flag.fromString(_countryCode, height: 18, width: 22, fit: BoxFit.fill)
            ],
          ),

        ),
      ),
    );
  }


  ///user Promo Code input box
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
            suffixIconConstraints: const BoxConstraints(
              minHeight: 12,
              minWidth: 12,
            ),
            suffixIcon: const Image(
              image: AssetImage(
                "assets/images/promo_code_icon.png",

              ),

              height: 18,
              width: 18,
              fit: BoxFit.fill,
            ),
            focusedBorder:const UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:const UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),
            hintText: hintTitle,
            hintStyle:  const TextStyle(fontSize: 17, color: hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }


  ///next button for send user data
  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {

          String emailTxt = _emailController!.text;
          String phoneNumberTxt = _phoneController!.text;
          String promoCodeTxt = _promoCodeController!.text;


          if(_inputValidation(email: emailTxt,phone: phoneNumberTxt,countryNameId: _countryNameId,promoCode: promoCodeTxt)==false){
            _userRegistration(email: emailTxt,mobile:phoneNumberTxt,countryId: _countryNameId,promoCode: promoCodeTxt);
          }


        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [novalexxa_color, novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  const Text(
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

  ///get country list api call and receive data
  _getCountryDataList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$GET_COUNTRY_LIST'),
          );
          Navigator.of(context).pop();
          //showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _countryList = data["data"];
              _showAlertDialog(context, _countryList);
            });
          } else {
            Fluttertoast.cancel();
          }
        } catch (e) {
          Fluttertoast.cancel();
        }
      }
    } on SocketException {
      Fluttertoast.cancel();
      showToast("No Internet Connection!");
    }
  }

  ///show all country list data with alert dialog
  void _showAlertDialog(BuildContext context, List _countryListData) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          child: Container(
            // color: Colors.green,
            margin: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: const Text(
                    "Select your country",
                    style: TextStyle(
                      fontSize: 17,
                      color: novalexxa_color,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _countryList == null ? 0 : _countryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();
                              _countryName = _countryListData[index]['country_name'].toString();
                              _countryCode = _countryListData[index]['country_code_name'].toString();
                              _countryCodeForPhone = _countryListData[index]['country_code_name'].toString();
                              _countryNameId = _countryListData[index]['country_id'].toString();

                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Flag.fromString(
                                        _countryListData[index]
                                        ['country_code_name']
                                            .toString(),
                                        height: 25,
                                        width: 25),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _countryListData[index]['country_name']
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        softWrap: false,
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ///loading dialog
  void _showLoadingDialog(BuildContext context, String _message) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          child: Wrap(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 30, bottom: 30),
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const CircularProgressIndicator(
                          backgroundColor: novalexxa_color,
                          strokeWidth: 5,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          _message,
                          style: const TextStyle(fontSize: 25),
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


  ///user input data validation
  _inputValidation({
        required String email,
        required String phone,
        required String promoCode,
        required String countryNameId
  }) {


    if (email.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("email can't empty");
      return;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(email)) {
      validation_showToast("Enter valid email");
      return;
    }

    if (phone.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("phoneNumber can't empty");
      return;
    }

    if (countryNameId.isEmpty || countryNameId == "0") {
      Fluttertoast.cancel();
      validation_showToast("Country name can't empty");
      return;
    }

    // if (promoCode.isEmpty) {
    //   Fluttertoast.cancel();
    //   validation_showToast("promoCode can't empty");
    //   return;
    // }

    return false;
  }

  ///user registration api call
  _userRegistration({
        required String email,
        required String mobile,
        required String countryId,
        required String promoCode,
      }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Creating...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_PERSONAL_REGISTRATION'),
              body: {

                'email': email,
                'phone_number': mobile,
                'country_id': countryId,
                'promo_code': promoCode,
              }
              );
          Navigator.of(context).pop();
          if (response.statusCode == 200) {
            _showToast("success");
            //var data = jsonDecode(response.body.toString());

            setState(() {
              //_showToast("success");
              var data = jsonDecode(response.body);

              Navigator.push(context,MaterialPageRoute(builder: (context)=>ConfirmNumberForParticularScreen(
                 data["data"]["id"].toString(),
                  data["data"]["phone_number"].toString(),


              )));

            });
          }

          else if (response.statusCode == 400) {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }
          else {
            // var data = jsonDecode(response.body.toString());
            // _showToast(data['message']);
          }
        } catch (e) {
          Navigator.of(context).pop();
          _showToast("Try again!");
          //print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }


  ///create toast
  _showToast(String message){

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



