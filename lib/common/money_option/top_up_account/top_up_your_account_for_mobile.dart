
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/common/money_option/send_money/send_money_message_page.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_service/api_service.dart';
import '../../../api_service/sharePreferenceDataSaveName.dart';
import '../../log_in/login_loading_page.dart';
import '../../static/toast.dart';
import '../top_up_account/select_top_up.dart';


class TopUpYourAccountPageScreen extends StatefulWidget {


  @override
  State<TopUpYourAccountPageScreen> createState() => _TopUpYourAccountPageScreenState();
}

class _TopUpYourAccountPageScreenState extends State<TopUpYourAccountPageScreen> {

  _TopUpYourAccountPageScreenState();

  TextEditingController? _phoneNumberController = TextEditingController();
  String _userId = "";
  String _currencyId = "0";


  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {

          // _getCurrentBalanced();
        });
      }
      else{
      }
    });
  }

  double _currentBalance=0.00;
  int _inputAmountGatterThanStatus=0;

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
                                      "Top up your account",
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
                        const SizedBox(
                          height: 10,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                                child: Center(

                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Mobile Money",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                            ),

                          ],
                        ),

                        SizedBox(
                          height: 110,
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Mobile money number",
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400)
                            ),
                          ),
                        ),
                        Align(alignment: Alignment.topCenter,
                          child: userInputAmountField(_phoneNumberController!, 'Phone Number', TextInputType.text),
                        ),

                        Expanded(child:  Align(alignment: Alignment.bottomCenter,
                          child: InkResponse(
                            onTap: (){
                              String amountTxt = _phoneNumberController!.text;

                              if (amountTxt.isEmpty) {
                                Fluttertoast.cancel();
                                _showToast("amount can't empty");
                                return;
                              }
                              if (double.parse(amountTxt)<=0) {
                                Fluttertoast.cancel();
                                _showToast("please input valid amount!");
                                return;
                              }
                              if (double.parse(amountTxt)>_currentBalance) {
                                Fluttertoast.cancel();
                                _showToast("your current balance is not enough!");
                                return;
                              }
                              if (_currencyId==""||_currencyId.isEmpty) {
                                Fluttertoast.cancel();
                                _showToast("select currency!");
                                return;
                              }

                              // Navigator.push(context,MaterialPageRoute(builder: (context)=>SendMoneyMessagePageScreen(
                              //   currentBalance:_currentBalance.toString(),
                              //   inputBalance:double.parse(amountTxt).toString(),
                              //   currencyId:_currencyId,
                              //   receiverId: _receiverId,
                              //   receiverName: _receiverName,
                              //   currencySymbol: _currencySymbol,
                              // )));
                              //
                            },
                            child: _buildContinueButton(),
                          ),
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

  Widget userInputAmountField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(

      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 30,right: 30,top: 15),
      decoration: BoxDecoration(
          color:search_send_money_box_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: EdgeInsets.only(left: 10.0, top: 13,bottom: 13, right: 10),
          child: Row(
            children: [

              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: Stack(children: <Widget>[
                      Image.asset("assets/images/orange_money_logo.png")
                      // FadeInImage.assetNetwork(
                      //   height: 120,
                      //   width: 120,
                      //   fit: BoxFit.fill,
                      //   placeholder: 'assets/images/loading.png',
                      //   image:
                      //   "https://technofaq.org/wp-content/uploads/2017/03/image00-21.jpg",
                      //   imageErrorBuilder: (context, url, error) =>
                      //       Image.asset(
                      //         'assets/images/loading.png',
                      //         fit: BoxFit.fill,
                      //       ),
                      // ),


                    ]),
                  )),

              Expanded(child:  Column(
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    controller: userInput,
                    textInputAction: TextInputAction.done,
                    autocorrect: false,
                    enableSuggestions: false,
                    cursorColor:intello_input_text_color,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))],
                    //
                    style: TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),

                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: hintTitle,
                      hintStyle:  TextStyle(fontSize: 20,
                          color:novalexxa_hint_text_color,
                          // color: Colors.intello_hint_color,
                          fontStyle: FontStyle.normal),
                    ),

                  ),
                ],
              ),),

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
  // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginLoadingScreen()));

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

  loadUserIdFromSharePref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        _userId = sharedPreferences.getString(pref_user_id)!;
        // _login_status_check = sharedPreferences.getString(pref_login_status)!;

      });
    } catch(e) {
      //code
    }

  }

  String getCurrency(String currencyCode) {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: currencyCode);
    return format.currencySymbol;
  }

}

