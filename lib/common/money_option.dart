import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/Particular/particular_information.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';



class MoneyOptionScreen extends StatefulWidget {
  const MoneyOptionScreen({Key? key}) : super(key: key);

  @override
  State<MoneyOptionScreen> createState() => _MoneyOptionScreenState();
}

class _MoneyOptionScreenState extends State<MoneyOptionScreen> {

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
            Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,

                  child: Container(
                    width: 55,
                    height: 55,


                    margin:const EdgeInsets.only(left:20, top: 00, right: 15, bottom: 00),
                   // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(27.5),
                      child: Container(
                          height: 55,
                          width: 55,
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
                Expanded(child:Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child:Text(
                        "Simon Lewis",
                        style: TextStyle(
                            color: novalexxa_text_color,
                            fontSize: 23,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold),
                      ),
                    ) ,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "IT60 X054 2811 1010 0000 0123 456",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: novalexxa_hint_text_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    )


                  ],
                )
               )

              ],
            ),


            Container(
              padding:const EdgeInsets.only(left:20, top: 50, right: 20, bottom: 00),
              child:Align(alignment: Alignment.topLeft,
                child:Text(
                  "Select Payment Method",
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 25,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Container(
              margin:EdgeInsets.only(right: 20.0,top: 10,left: 20,bottom: 30),
              child: Align(alignment: Alignment.topLeft,
                child: Text(
                  "Please select what you wish to do.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: novalexxa_hint_text_color,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),),
            ),

            Flex(direction: Axis.horizontal,
            children: [
              Expanded(child:
              InkResponse(
                onTap: (){
                  _showToast("Working...");
                },
                child: cardItemDesign(marginLeft: 20,marginRight: 10,bg_image_link: "assets/images/send_to_pay_friend_card_bg.png",
                    icon_link: "assets/images/send_to_pay_friend_icon.png",item_name_text: "Send to\nPay Friend"
                ),

              )

              ),

              Expanded(child:
              InkResponse(
                onTap: (){
                  _showToast("Working...");
                },
                child: cardItemDesign(marginLeft: 10,marginRight: 20,bg_image_link: "assets/images/request_money_card_bg.png",
                    icon_link: "assets/images/request_money_icoon.png",item_name_text: "Request\nMoney"
                )

              )

              ),
            ],
            ),

            Flex(direction: Axis.horizontal,
              children: [
                Expanded(child:
                InkResponse(
                  onTap: (){
                    _showToast("Working...");
                  },
                  child: cardItemDesign(marginLeft: 20,marginRight: 10,bg_image_link: "assets/images/pay_with_qr_code_card_bg.png",
                      icon_link: "assets/images/pay_with_qr_code_icon.png",item_name_text: "Pay With\nQR Code"
                  )

                )

                ),

                Expanded(child:
                InkResponse(
                    onTap: (){
                      _showToast("Working...");
                    },
                    child: cardItemDesign(marginLeft: 10,marginRight: 20,bg_image_link: "assets/images/pay_with_nfc_card_bg.png",
                        icon_link: "assets/images/pay_with_nfc_icon.png",item_name_text: "Pay With\nNFC"
                    )

                )

                ),

              ],
            ),

            Flex(direction: Axis.horizontal,
              children: [
                Expanded(child:
                InkResponse(
                    onTap: (){
                      _showToast("Working...");
                    },
                    child: cardItemDesign(marginLeft: 20,marginRight: 10,bg_image_link: "assets/images/transfer_money_card_bg.png",
                        icon_link: "assets/images/transfer_money_icon.png",item_name_text: "Transfer\nMoney"
                    )

                )

                ),

                Expanded(child:
                InkResponse(
                    onTap: (){
                      _showToast("Working...");
                    },
                    child: cardItemDesign(marginLeft: 10,marginRight: 20,bg_image_link: "assets/images/schedule_card_item_bg.png",
                        icon_link: "assets/images/schedule_payment_icon.png",item_name_text: "Schedule\na Payment"
                    )

                )

                ),


              ],
            )
          ],
        ),
      ),
    );
  }


  Widget cardItemDesign({required double marginLeft,required double marginRight,
    required String bg_image_link,required String icon_link,required String item_name_text,
  }) {
    return  Container(
      margin:EdgeInsets.only(right: marginRight,top: 10,left: marginLeft,bottom: 10),
      height: 150,
      width: 150,

      decoration: BoxDecoration(

        image: DecorationImage(
          image: AssetImage(bg_image_link),
          fit: BoxFit.fill,
        ),
      ),

      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,

            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(22.0),
                    bottomRight: Radius.circular(22.0),
                    topLeft: Radius.circular(22.0),
                    bottomLeft: Radius.circular(22.0)),
              ),

              margin:const EdgeInsets.only(left:20, top: 20, right: 10, bottom: 00),
              padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: Image.asset(icon_link,
                fit: BoxFit.fill,
              ),

            ),
          ),


          Container(
            padding:const EdgeInsets.only(left:20, top: 20, right: 5, bottom: 00),
            child:Align(alignment: Alignment.topLeft,
              child:Text(
                item_name_text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),


      /* add child content here */
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

