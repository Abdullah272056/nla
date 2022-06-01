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
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/send_money/send_money_amount_page.dart';
import 'package:nova_lexxa/common/transaction_details.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../customer_services.dart';
import '../notification/notification.dart';

class SendMoneyPageScreen extends StatefulWidget {
  const SendMoneyPageScreen({Key? key}) : super(key: key);

  @override
  State<SendMoneyPageScreen> createState() => _SendMoneyPageScreenState();
}

class _SendMoneyPageScreenState extends State<SendMoneyPageScreen> {
  TextEditingController? _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:SingleChildScrollView(
        child: Column(
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
                          "Send Money",
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
            const SizedBox(
              height: 40,
            ),

            userInputSearchField(_searchController!, 'Search here...', TextInputType.text),

            Align(
              alignment: Alignment.centerLeft,
              child:Container(
                margin:  EdgeInsets.only(left: 30, top: 30, right:10, bottom: 0),
                child: Text(
                  "Recent Contacts",
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 22,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //horizontal list view
            Container(
              margin:  EdgeInsets.only(left: 0, top: 30, right:15, bottom: 0),
              height: 110,
              child:ListView.builder(

                shrinkWrap: true,

                // physics: const NeverScrollableScrollPhysics(),
                //itemCount: offerDataList == null ? 0 : offerDataList.length,
                itemCount: 10,
                itemBuilder: (context, index) {
                  if(index==0){
                    return recentContactTopListItemDesign(marginLeft: 30,marginRight: 0);                          }
                  //length
                  if(index==9){
                    return recentContactTopListItemDesign(marginLeft: 15,marginRight: 30);
                  }
                  else{
                    return recentContactTopListItemDesign(marginLeft: 15,marginRight: 0);
                  }
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            //vertical list view
            Container(
              margin:  EdgeInsets.only(left: 15, top: 30, right:15, bottom: 0),
              child:ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.zero,
                // itemCount: orderRoomList == null ? 0 : orderRoomList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return recentContactBottomListItemDesign();
                },
              ),
            ),

          ],
        ),
      )

    );
  }

  Widget recentContactBottomListItemDesign(){
    return InkResponse(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SendMoneyAmountPageScreen()));
      },
      child:  Container(
        margin: EdgeInsets.only(right:00,top: 0,left: 0,bottom: 25),
        height: 48,
        child: Padding(padding: EdgeInsets.only(right:00,top: 0,left: 20,bottom: 0),
          child:  Column(
            children: [
              Expanded(child: Row(
                children: [

                  Align(
                    alignment: Alignment.topLeft,

                    child: Container(
                      width: 40,
                      height: 40,


                      margin:const EdgeInsets.only(left:0, top: 00, right: 15, bottom: 00),
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
                  Expanded(child:Text(
                    "Tech Italy",
                    style: TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500),
                  ),),

                  SizedBox(width: 10,)

                ],
              ),),
              Align(alignment:Alignment.bottomRight,
                child:  Container(
                  margin: EdgeInsets.only(left: 50,right: 15),
                  height: 1.5,
                  color:notification_image_bg_color ,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  // Navigator.push(context,MaterialPageRoute(builder: (context)=>RequestMoneyAmountPageScreen()));
  Widget recentContactTopListItemDesign({required double marginLeft,required double marginRight}) {
    return  InkResponse(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SendMoneyAmountPageScreen()));

      },
      child:Container(
        margin:EdgeInsets.only(right:marginRight,top: 10,left:marginLeft,bottom: 10),
        child: Flex(direction: Axis.vertical,
          children: [
            Container(
              width: 61,
              height: 61,

              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(31),
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

            Container(
                margin:  EdgeInsets.only(left: 0, right: 0,bottom: 00,top: 6),
                child:  Text(
                  "Harry",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                )
            ),
          ],
        ),


        /* add child content here */
      ) ,
    );
  }

  Widget userInputSearchField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
      color:search_send_money_box_color,
      borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.search,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor:intello_input_text_color,
          style: TextStyle(color:novalexxa_text_color,),
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon:  Icon(
              Icons.search,
              color: hint_color,
              size: 30.0,
            ),

            hintText: hintTitle,

            hintStyle:  TextStyle(fontSize: 17,
                color:novalexxa_hint_text_color,
                // color: Colors.intello_hint_color,
                fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
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
        textColor: Colors.black,
        fontSize: 16.0);
  }

}

