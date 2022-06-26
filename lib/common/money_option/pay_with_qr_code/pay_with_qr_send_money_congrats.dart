
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../navigation_page/money_option.dart';
import '../../navigation_page/navigation_bar_page.dart';
import '../../static/Colors.dart';



class PayWithQRSendMoneyCongratsScreen extends StatefulWidget {

  String sendAmount,receiverName;
  PayWithQRSendMoneyCongratsScreen({required this.sendAmount, required this.receiverName});

  @override
  State<PayWithQRSendMoneyCongratsScreen> createState() => _PayWithQRSendMoneyCongratsScreenState(this.sendAmount, this.receiverName);
}

class _PayWithQRSendMoneyCongratsScreenState extends State<PayWithQRSendMoneyCongratsScreen> {

  String _sendAmount,_receiverName;

  _PayWithQRSendMoneyCongratsScreenState(
      this._sendAmount, this._receiverName
      ); //image upload

  File? imageFile;

 // String _sendAmount="30",_receiverName="Simon Lewis";

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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: 55,),


                      Image.asset(
                        "assets/images/undraw_wallet_aym5.png",
                        width: 240,
                        height: 160,
                        fit: BoxFit.fill,
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      Text(
                        "Congratulations!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: congratulation_text_color,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),

                      Container(
                        margin: EdgeInsets.only(left:30, top: 18, right: 30, bottom: 00),
                        child:Text(
                          "You send $_sendAmount to",

                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.5,
                              color: novalexxa_text_color,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:30, top: 5, right: 30, bottom: 00),
                        child:Text(
                          _receiverName,

                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.5,
                              color: novalexxa_text_color,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ),


                      const SizedBox(
                        height: 40,
                      ),

                      Container(
                        child: _buildSendMoreMoneyButton(),
                      ),
                      SizedBox(height: 25,),


                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      )

    );
  }

  Widget _buildSendMoreMoneyButton() {
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
              "Send More Money",
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

