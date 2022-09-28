
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../navigation_page/home_page.dart';
import '../../../navigation_page/navigation_bar_page.dart';
import '../../../static/Colors.dart';






class TopUpMoneyCongratsMobileScreen extends StatefulWidget {

  String sendAmount;
  TopUpMoneyCongratsMobileScreen({required this.sendAmount});

  @override
  State<TopUpMoneyCongratsMobileScreen> createState() => _TopUpMoneyCongratsMobileScreenState(this.sendAmount);
}

class _TopUpMoneyCongratsMobileScreenState extends State<TopUpMoneyCongratsMobileScreen> {

  String _sendAmount;


  _TopUpMoneyCongratsMobileScreenState(
      this._sendAmount); //image upload
  PickedFile? _imageFile;
  final ImagePicker _picker=ImagePicker();
  String _imageLink = "";
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
                        "assets/images/top_up_mobile_bank_successfull_icon.png",
                        width: 100,
                        height: 105,
                        fit: BoxFit.fill,
                      ),


                      Container(
                        margin: EdgeInsets.only(left:30, top: 30, right: 30, bottom: 00),
                        child:  Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'You have successfully topped up ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: novalexxa_text_color,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: _sendAmount,
                                style: TextStyle(
                                    height: 1.5,
                                    color: novalexxa_color,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),

                              ),
                              TextSpan(
                                text: ' on your account ',
                                style: TextStyle(
                                    height: 1.5,
                                    color: novalexxa_text_color,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                      ),

                      Container(
                          margin: EdgeInsets.only(left:30, top: 24, right: 30, bottom: 00),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Your new solde is\n",

                                  style: TextStyle(
                                      height: 1.5,
                                      color: novalexxa_text_color,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),

                                ),
                                TextSpan(
                                  text: _sendAmount,

                                  style: TextStyle(
                                      height: 1.5,
                                      color: novalexxa_color,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),

                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          )
                      ),


                      Container(
                        child: _buildBackToHomeButton(),
                      ),
                      SizedBox(height: 25,),


                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )

    );
  }


  Widget _buildBackToHomeButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0,top: 75),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => NavigationBarScreen(0,HomePageScreen()),
            ),
                (route) => false,
          );
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

            height: 47,
            alignment: Alignment.center,
            child:  Text(
              "Back to Home",
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

