
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/Particular/particular_information2.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_congrats.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_details_particular2.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../api_service/api_service.dart';
import '../../static/loding_dialog.dart';


class TransferMoneyDetailForParticularFromMobileScreen extends StatefulWidget {
  String senderUserId,senderUserSendAmount,transferFees,senderUserCountryId,senderCurrencyId,
      receiverUserId,receiverName,receiverSurname,receiverEmail,receiverCurrencyId,receiverUserCountryId,
      receiverUserReceivedMoney,exchangeRate;


  TransferMoneyDetailForParticularFromMobileScreen(
         {
           required this.senderUserId,
           required this.senderUserSendAmount,
           required this.transferFees,
           required this.senderUserCountryId,
           required this.senderCurrencyId,
           required this.receiverUserId,
           required this.receiverName,
           required this.receiverSurname,
           required this.receiverEmail,
           required this.receiverCurrencyId,
           required this.receiverUserCountryId,
           required this.receiverUserReceivedMoney,
           required this.exchangeRate,
        }
      );

  @override
  State<TransferMoneyDetailForParticularFromMobileScreen> createState() => _TransferMoneyDetailForParticularFromMobileScreenState(
     this.senderUserId,
     this.senderUserSendAmount,
     this.transferFees,
     this.senderUserCountryId,
     this.senderCurrencyId,
     this.receiverUserId,
     this.receiverName,
     this.receiverSurname,
     this.receiverEmail,
     this.receiverCurrencyId,
     this.receiverUserCountryId,
     this.receiverUserReceivedMoney,
     this.exchangeRate,
  );
}

class _TransferMoneyDetailForParticularFromMobileScreenState extends State<TransferMoneyDetailForParticularFromMobileScreen> {
  String _senderUserId,_senderUserSendAmount,_transferFees,_senderUserCountryId,_senderCurrencyId,
      _receiverUserId,_receiverName,_receiverSurname,_receiverEmail,_receiverCurrencyId,_receiverUserCountryId,
      _receiverUserReceivedMoney,_exchangeRate;
  _TransferMoneyDetailForParticularFromMobileScreenState(
         this._senderUserId,
         this._senderUserSendAmount,
         this._transferFees,
         this._senderUserCountryId,
         this._senderCurrencyId,
         this._receiverUserId,
         this._receiverName,
         this._receiverSurname,
         this._receiverEmail,
         this._receiverCurrencyId,
         this._receiverUserCountryId,
         this._receiverUserReceivedMoney,
         this._exchangeRate,
      );


  String _firstCountryCode = "IT";
  String _secondCountryCode = "CA";



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
                          "Transfer Money",
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
            SizedBox(
              height: 25,
            ),

            Container(
              margin: EdgeInsets.only(left:20, top: 10, right: 20, bottom: 00),
              child: new LinearPercentIndicator(
                // width: MediaQuery.of(context).size.width - 80,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 1000,
                percent: 0.6,
                center: Text("60%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                fillColor:Colors.white,
                backgroundColor: novalexxa_indicator_unselected_color,
                progressColor: novalexxa_color,
              ),
            ),


            _buildDollarExchangeRate(),


            Container(
              margin:EdgeInsets.only(right: 20.0,top: 50,left: 30,bottom: 0),
              child: Align(alignment: Alignment.centerLeft,
                child: Text(
                  "Select the recipient Mobile Operator",
                  textAlign: TextAlign.left,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
              SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSelectMobileMoneyTelecomItalia(iconLink: "assets/images/icon_telecom_italia.png"),
                _buildSelectMobileMoneyVodafone(iconLink: "assets/images/icon_vodafone.png"),
                _buildSelectMobileMoneyIliadTelecom(iconLink: "assets/images/icon_Iliad.png"),

              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }


  Widget _buildDollarExchangeRate() {
    return Container(
      height: 115,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0,top: 60),
      padding: const EdgeInsets.only(left: 00.0, right: 00.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.25),
            blurRadius: 20.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),

      child: Stack(
        children: [
          Expanded(child: Align(alignment: Alignment.topRight,
          child: InkWell(
            onTap: (){
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     settings: RouteSettings(name: "Foo"),
              //     builder: (BuildContext context) => TransferMoneyDetailForParticularScreen2(
              //     ),),
              // );
            },
            child: Container(
              height: 24,
              width: 24,
              margin: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
              decoration: new BoxDecoration(
                color: notification_image_bg_color,
                borderRadius: BorderRadius.circular(27),

              ),
              child:

              Center(
                child:  Icon(
                  Icons.edit,
                  color:hint_color,
                  size: 15.0,
                ),
              ),

            ),
          )


          )),


          Row(
            children: [
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:   ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Flag.fromString(_firstCountryCode, height: 23, width: 32, fit: BoxFit.fill ),
                    ),
                  ),

                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.center,
                    child:   Text(
                      "250.00",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: intello_input_text_color,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  SizedBox(height: 5,),
                  Align(
                    alignment: Alignment.center,
                    child:   Text(
                      "Transfer Fees: 3.8 €",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: intello_level_color,
                          fontSize: 9,
                          fontWeight: FontWeight.normal),
                    ),
                  ),

                ],
              )),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child:   ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Flag.fromString(_secondCountryCode, height: 23, width: 32, fit: BoxFit.fill ),
                    ),
                  ),

                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.center,
                    child:   Text(
                      "382.24",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: intello_input_text_color,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

                  SizedBox(height: 5,),
                  Align(
                    alignment: Alignment.center,
                    child:   Text(
                      "Exchange Rate: 1 € = 1.53 CAD",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: intello_level_color,
                          fontSize: 9,
                          fontWeight: FontWeight.normal),
                    ),
                  ),

                ],
              )),
            ],
          ),
        ],
      )

    );
  }

  Widget _buildSelectMobileMoneyTelecomItalia({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkResponse(
            onTap: (){
              _transferMoney(
                  exchangeRate: _exchangeRate,
                  receiverCurrencyId: _receiverCurrencyId,
                  receiverEmail: _receiverEmail,
                  receiverName:_receiverName,
                  receiverSurname: _receiverSurname,
                  receiverUserCountryId:_receiverUserCountryId,
                  receiverUserId: _receiverUserId,
                  receiverUserReceivedMoney: _receiverUserReceivedMoney,
                  senderCurrencyId: _senderCurrencyId,
                  senderUserCountryId: _senderUserCountryId,
                  senderUserId: _senderUserId,
                  senderUserSendAmount: _senderUserSendAmount,
                  transferFees: _transferFees
              );
            },
            child: Container(

              // padding: const EdgeInsets.only(left: 18.0, right: 18.0,top: 18,bottom: 18),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.25),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      2.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              height: 92,
              width: 92,
              child: Center(
                child: Container(
                  height: 54,
                  width: 54,
                  // padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
                  decoration: new BoxDecoration(
                    color: notification_image_bg_color,
                    borderRadius: BorderRadius.circular(27),

                  ),
                  child:

                  Center(
                    child:  Image.asset(
                      iconLink,
                      height: 24,
                      width: 27,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),

          SizedBox(height: 15,),
          Text(
            "Telecom Italia",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }


  Widget  _buildSelectMobileMoneyVodafone({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          InkResponse(
            onTap: (){
              _transferMoney(
                  exchangeRate: _exchangeRate,
                  receiverCurrencyId: _receiverCurrencyId,
                  receiverEmail: _receiverEmail,
                  receiverName:_receiverName,
                  receiverSurname: _receiverSurname,
                  receiverUserCountryId:_receiverUserCountryId,
                  receiverUserId: _receiverUserId,
                  receiverUserReceivedMoney: _receiverUserReceivedMoney,
                  senderCurrencyId: _senderCurrencyId,
                  senderUserCountryId: _senderUserCountryId,
                  senderUserId: _senderUserId,
                  senderUserSendAmount: _senderUserSendAmount,
                  transferFees: _transferFees
              );
            },
            child: Container(

              // padding: const EdgeInsets.only(left: 18.0, right: 18.0,top: 18,bottom: 18),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.25),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      2.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              height: 92,
              width: 92,
              child: Center(
                child: Container(
                  height: 54,
                  width: 54,
                  // padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
                  decoration: new BoxDecoration(
                    color: notification_image_bg_color,
                    borderRadius: BorderRadius.circular(27),

                  ),
                  child:

                  Center(
                    child:  Image.asset(
                      iconLink,
                      height: 28,
                      width: 28,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),
          SizedBox(height: 15,),
          Text(
            "Vodafone",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildSelectMobileMoneyIliadTelecom({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          InkResponse(
            onTap: (){
              _transferMoney(
                  exchangeRate: _exchangeRate,
                  receiverCurrencyId: _receiverCurrencyId,
                  receiverEmail: _receiverEmail,
                  receiverName:_receiverName,
                  receiverSurname: _receiverSurname,
                  receiverUserCountryId:_receiverUserCountryId,
                  receiverUserId: _receiverUserId,
                  receiverUserReceivedMoney: _receiverUserReceivedMoney,
                  senderCurrencyId: _senderCurrencyId,
                  senderUserCountryId: _senderUserCountryId,
                  senderUserId: _senderUserId,
                  senderUserSendAmount: _senderUserSendAmount,
                  transferFees: _transferFees
              );
            },
            child:  Container(

              // padding: const EdgeInsets.only(left: 18.0, right: 18.0,top: 18,bottom: 18),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.25),
                    blurRadius: 20.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      2.0, // Move to right 10  horizontally
                      1.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              height: 92,
              width: 92,
              child: Center(
                child: Container(
                  height: 54,
                  width: 54,
                  padding: const EdgeInsets.only(left: 5.0, ),
                  decoration: new BoxDecoration(
                    color: notification_image_bg_color,
                    borderRadius: BorderRadius.circular(27),

                  ),
                  child:

                  Center(
                    child:  Image.asset(
                      iconLink,
                      height: 14,
                      width: 32,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),
          SizedBox(height: 15,),
          Text(
            "Iliad Telecom",
            textAlign: TextAlign.center,

            style: TextStyle(
                color: novalexxa_text_color,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          )
        ],
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

  _transferMoney({
    required String senderUserId,
    required String senderUserSendAmount,
    required String transferFees,
    required String senderUserCountryId,
    required String senderCurrencyId,
    required String receiverUserId,
    required String receiverName,
    required String receiverSurname,
    required String receiverEmail,
    required String receiverCurrencyId,
    required String receiverUserCountryId,
    required String receiverUserReceivedMoney,
    required String exchangeRate,

  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Transferring...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_TRANSFER_MONEY'),
              body: {

                'sender_user_id': senderUserId,
                'sender_user_send_amount': senderUserSendAmount,
                'transfer_fees': transferFees,
                'sender_user_country_id': senderUserCountryId,
                'sender_currency_id': senderCurrencyId,
                'receiver_user_id': receiverUserId,
                'receiver_name': receiverName,
                'receiver_surname': receiverSurname,
                'receiver_email': receiverEmail,
                'receiver_currency_id': receiverCurrencyId,
                'receiver_user_country_id': receiverUserCountryId,
                'receiver_user_received_money': receiverUserReceivedMoney,
                'exchange_rate': exchangeRate,

              }
          );
          Navigator.of(context).pop();
          if (response.statusCode == 201) {
            _showToast("success");
            //var data = jsonDecode(response.body.toString());

            setState(() {
              var data = jsonDecode(response.body);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyCongratsScreen(
                  ),),
              );

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
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }



}
