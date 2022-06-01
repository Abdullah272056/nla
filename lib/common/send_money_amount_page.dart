import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/Particular/particular_information.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/common/transaction_details.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'customer_services.dart';
import 'notification.dart';

class SendMoneyAmountPageScreen extends StatefulWidget {
  const SendMoneyAmountPageScreen({Key? key}) : super(key: key);

  @override
  State<SendMoneyAmountPageScreen> createState() => _SendMoneyAmountPageScreenState();
}

class _SendMoneyAmountPageScreenState extends State<SendMoneyAmountPageScreen> {
  TextEditingController? _searchController = TextEditingController();
  @override
  String _alertMessage="There are many variations of passages of Lorem Ipsum available, "
      "but the majority have suffered alteration in some form, by injected humour, or "
      "randomised words which don't look even slightly believable. If you are going to "
      "use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing"
      " hidden in the middle of text.";


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(

              children: [
                Expanded(child:
                Stack(
                  children: [
                    //bg
                    Container(
                      height: 185,

                      child: Image.asset(
                        "assets/images/header_bg.png",
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    //content dsign
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const SizedBox(
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
                                  color: Colors.white,
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
                                      "Send Money",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                            ),

                          ],
                        ),
                        Align(alignment: Alignment.topCenter,
                          child: Container(
                            width: 90,
                            height: 90,

                            margin:const EdgeInsets.only(left:0, top: 40, right: 0, bottom: 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(46),
                              child: Container(
                                  height: 90,
                                  width: 90,
                                  color:hint_color,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.fill,
                                    placeholder: 'assets/images/empty.jpg',
                                    image: "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                                    imageErrorBuilder: (context, url, error) =>
                                        Image.asset(
                                          'assets/images/empty.jpg',
                                          fit: BoxFit.fill,
                                        ),
                                  )),
                            ),

                          ),
                        ),
                        SizedBox(height: 10,),
                        Align(alignment: Alignment.topCenter,
                          child:  Text(
                            "Send Money to",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: intello_level_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Align(alignment: Alignment.topCenter,
                          child:  Text(
                            "Anna Lain",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 26,
                                fontWeight: FontWeight.w600),
                          ),
                        ),


                        Align(alignment: Alignment.topCenter,
                          child: userInputSearchField(_searchController!, '00', TextInputType.text),
                        ),
                        Expanded(child:  Align(alignment: Alignment.bottomCenter,
                          child: _buildContinueButton(),
                        ),)






                      ],
                    )
                  ],
                )
                )

              ],
            ),
          ),
        ],
      )



    );
  }

  Widget userInputSearchField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(

      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 30,right: 30,top: 25),
      decoration: BoxDecoration(
          color:search_send_money_box_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 13,bottom: 13, right: 10),
        child: Row(
          children: [
            Expanded(child:  Column(
              children: [
                TextField(
                  textAlign: TextAlign.center,
                  controller: userInput,
                  textInputAction: TextInputAction.search,
                  autocorrect: false,
                  enableSuggestions: false,
                  cursorColor:intello_input_text_color,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))],
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: hintTitle,
                    hintStyle:  TextStyle(fontSize: 22,
                        color:novalexxa_hint_text_color,
                        // color: Colors.intello_hint_color,
                        fontStyle: FontStyle.normal),
                  ),

                ),
                Align(
                  alignment: Alignment.topCenter,
                  child:  Text(
                    "Current balance is 42€",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: intello_level_color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),

              ],
            ),),
            IconButton(
              icon: Image.asset(
                "assets/images/information.png",
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              // color: Colors.white,
              onPressed: () {
                showDialog(context: context,
                    barrierDismissible:false,
                    builder: (BuildContext context){
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(10.0)),
                        child:Wrap(
                          children: [
                            Container(
                              padding:EdgeInsets.only(left: 18.0, right: 18.0,top: 18,bottom: 18),
                              child: Column(

                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Align(
                                          alignment: Alignment.topRight,
                                          child: InkResponse(
                                            onTap: (){
                                              Navigator.of(context).pop();
                                            },
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              size: 25,
                                            ),
                                          )

                                      ))

                                    ],
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  Image.asset(
                                    "assets/images/information.png",
                                    height: 30,
                                    width: 30,
                                    fit: BoxFit.fill,
                                    color: novalexxa_color1,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("Lorem Ipsum Title",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:novalexxa_text_color,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Text(_alertMessage,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:novalexxa_text_color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),


                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                );

              },
            )


          ],
        )
        
        
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

  Widget _buildContinueButton() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0)
      ),
      height: 65,
      alignment: Alignment.center,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Continue",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10,),
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 25.0,
          ),
        ],
      )

    );
  }

}

