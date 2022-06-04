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
import 'package:nova_lexxa/common/pay_with_qr_code/pay_with_qr_send_money_congrats.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/send_money/send_money_congrats.dart';
import 'package:nova_lexxa/common/transaction_details.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:slidable_button/slidable_button.dart';

import '../customer_services.dart';
import '../navigation_page/money_option.dart';
import '../navigation_page/navigation_bar_page.dart';
import '../notification/notification.dart';

class PayQRMoneySwipeToPayPageScreen extends StatefulWidget {

  String inputBalance;

  PayQRMoneySwipeToPayPageScreen({
    required this.inputBalance,

});
  // const SendMoneyMessagePageScreen({Key? key}) : super(key: key);

  @override
  State<PayQRMoneySwipeToPayPageScreen> createState() => _PayQRMoneySwipeToPayPageScreenState(
      this.inputBalance);
}

class _PayQRMoneySwipeToPayPageScreenState extends State<PayQRMoneySwipeToPayPageScreen> {


  String _inputBalance;
  _PayQRMoneySwipeToPayPageScreenState(this._inputBalance);


  TextEditingController? _sendMoneyAmountController = TextEditingController();
  String _alertMessage="There are many variations of passages of Lorem Ipsum available, "
      "but the majority have suffered alteration in some form, by injected humour, or "
      "randomised words which don't look even slightly believable. If you are going to "
      "use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing"
      " hidden in the middle of text.";

  Color _button_bg_color=slide_button_start_bg_color;
  Color _slide_button_color=slide_button_start_color;
  int _buttonLeftRightStatus=1;


  TextEditingController? _userMessage = TextEditingController();

  @override
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

                        //image section
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
                            "Anna Lain",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 26,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //amount section
                            Align(alignment: Alignment.topCenter,
                              child: userAmountSection(),
                            ),

                            SizedBox(height: 60,),
                            //slide button
                            Align(alignment: Alignment.center,
                              child:Row(
                                children: [
                                  Expanded(child: userSlideButtonSection() )
                                ],
                              ),


                            ),
                            SizedBox(height: 30,),
                          ],
                        )),

                        _buildPayLaterButton(),
                        SizedBox(height: 50,),
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

  Widget userAmountSection() {
    return Container(

      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 30,right: 30,top: 25),
      decoration: BoxDecoration(
          color:search_send_money_box_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 25,bottom: 25, right: 10),
        child: Column(
          children: [
            Row(
              children: [

                Expanded(child:  Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Do you want to send",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: novalexxa_hint_text_color,
                        fontSize: 26,
                        fontWeight: FontWeight.normal),
                  ),
                ),

                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [

                Expanded(child:  Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    _inputBalance.toString()+"€ to "+ "Anna Lain",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                ),
              ],
            ),
          ],
        )

        
        
      ),
    );
  }

  Widget userSlideButtonSection() {
    return Container(
      height: 64,
      margin: EdgeInsets.only(left: 40,right: 40,top: 0,bottom: 0),
      decoration: BoxDecoration(
          color: _button_bg_color,
          borderRadius: BorderRadius.all(Radius.circular(32))
      ),

      padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
      child: SlidableButton(
        height: 50,
        //  buttonWidth: 54.0,
        // color: ,
        buttonColor: _slide_button_color,
        dismissible: false,
        label: Center(
            child:Wrap(
              children: [
                if(_buttonLeftRightStatus==1)...[
                  Text('Swipe\nto pay',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )
                ]
                else...[
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ]
              ],
            )



        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 0),
          child: Center(
            child:Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              height: 8,
              //width: 200,

            ),
          ),
        ),
        onChanged: (position) {
          setState(() {
            if (position == SlidableButtonPosition.right) {
              _button_bg_color=slide_button_end_bg_color;
              _slide_button_color=slide_button_end_color;
              _buttonLeftRightStatus=2;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    settings: RouteSettings(name: "Foo"),
                    builder: (BuildContext context) => PayWithQRSendMoneyCongratsScreen(
                      receiverName: "Anna Lain",
                      sendAmount: _inputBalance.toString(),
                    ),),
              );


            } else {
              _button_bg_color=slide_button_start_bg_color;
              _slide_button_color=slide_button_start_color;
              _buttonLeftRightStatus=1;
              //result = 'Button is on the left';
            }
          });
        },
      ),
    );
  }


  Widget _buildPayLaterButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {

          Route route = MaterialPageRoute(builder: (context) => NavigationBarScreen(2,MoneyOptionScreen()));
          Navigator.pushReplacement(context, route);


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
              "Pay Later",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 15,
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
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }



}

