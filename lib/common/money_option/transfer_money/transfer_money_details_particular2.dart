
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/Particular/particular_information2.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_congrats.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_details_From_mobile.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_service/api_service.dart';
import '../../../api_service/sharePreferenceDataSaveName.dart';
import '../../static/loding_dialog.dart';
import '../../static/toast.dart';


class TransferMoneyDetailForParticularScreen2 extends StatefulWidget {
  String name,surName,countryId;
  var response;


  TransferMoneyDetailForParticularScreen2({
    required  this.name,required this.surName, required this.countryId,required this.response
      }
     );

  @override
  State<TransferMoneyDetailForParticularScreen2> createState() => _TransferMoneyDetailForParticularScreen2State(this.name, this.surName, this.countryId, this.response);
}

class _TransferMoneyDetailForParticularScreen2State extends State<TransferMoneyDetailForParticularScreen2> {

  String _receiverInputName,_receiverInputSurName,_receiverInputCountryId;
  var _receiverResponse;
  _TransferMoneyDetailForParticularScreen2State(
      this._receiverInputName, this._receiverInputSurName, this._receiverInputCountryId, this._receiverResponse);


  TextEditingController? _transferMoneyAmountController = TextEditingController();

  String _countryBirthDay="Enter Birthday";
  String select_your_country="Enter Birthday";

  double _switchButtonWidth = 40;
  double _switchButtonHeight = 25;
  double _buttonToggleSize = 20;
  bool _switchButtonStatus = false;
  String _countryName = "Select your country";
  String _countryNameId = "0";
  String _countryCode = "IT";

  String _transferFee = "0.00";


  TextEditingController? _searchController = TextEditingController();

  String _userTransferMoneyTxt="";
  //receiver info
  String _receiverId = "";
  String _receiverEmail = "";
  List _currencyTypeListForRecever = [];
  String _receiverCountryName="";
  String _receiverCurrencyName="";
  String _receiverCurrencyId="";
  String _receiverCurrencySymbol="";
  String _receiverCountryCode = "";
  String _receiverReceivedMoney = "0.00";
  String _exchangeRate = "0.0";


  //sender info
  String _userId = "";
  String _currencyId = "0";
  List _currencyTypeListForSender = [];
  String _senderCountryName="";
  String _senderCountryNameId="";
  String _senderCurrencyName="";
  String _senderCurrencyId="";
  String _senderCurrencySymbol="";
  String _senderCountryCode = "";
  String _senderUserCountryId = "";


  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {

      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {
          _receiverId= _receiverResponse["data"]["id"].toString();
          _receiverEmail= _receiverResponse["data"]["email"].toString();
          _getUserCurrencyTypeListForSender1();
          _getUserCurrencyTypeListForReceiver1(_receiverId);
          // _getCurrentBalanced();
        });
      }
      else{
      }

      if(_senderCurrencyName!=""&&_receiverCurrencyName!=""){
        _getExchangeRate(from: _senderCurrencyName,to: _receiverCurrencyName);
      }

    });
  }

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

            Container(
              margin:EdgeInsets.only(right: 20.0,top: 50,left: 20,bottom: 0),
              child: Align(alignment: Alignment.center,
                child: Text(
                  "Where do you want to send money?",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 23,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            _buildSelectDeliveryMethodItemBankDeposit2(),
            _buildSelectDeliveryMethodItemBankDeposit3(),

            Container(
              margin:EdgeInsets.only(right: 20.0,top: 30,left: 30,bottom: 0),
              child: Align(alignment: Alignment.centerLeft,
                child: Text(
                  "Select Delivery Method",
                  textAlign: TextAlign.left,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
              SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSelectDeliveryMethodItemBankDeposit(iconLink: "assets/images/icon_bank_deposit.png"),
                _buildSelectDeliveryMethodItemCashPickup(iconLink: "assets/images/icon_cash_pick_up.png"),
                _buildSelectDeliveryMethodItemMobileMoney(iconLink: "assets/images/icon_mobile_money.png"),

              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }


// sender info
  Widget _buildSelectDeliveryMethodItemBankDeposit2() {
    return Container(
      height: 100,
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
      margin: const EdgeInsets.only(left: 30.0, right: 30.0,top: 30),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:  Text(
                  "You Send?",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              ),


              Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  textAlign: TextAlign.left,
                  controller: _transferMoneyAmountController,
                  textInputAction: TextInputAction.search,
                  autocorrect: false,
                  enableSuggestions: false,
                  cursorColor:slide_button_end_color,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))],
                  style: TextStyle(
                      color: slide_button_end_color,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                  onChanged: (text) {
                    _userTransferMoneyTxt=text;
                    // if(double.parse(text)>_currentBalance){
                    //   setState(() {
                    //     _inputAmountGatterThanStatus=1;
                    //   });
                    //
                    //   // _showToast("not possible");
                    // }
                    // else{
                    //   setState(() {
                    //     _inputAmountGatterThanStatus=0;
                    //   });
                    // }

                    if(text==""||text==null||text.isEmpty){
                      setState(() {
                        _transferFee="0.0";
                        _receiverReceivedMoney="0.00";
                          });
                    }else{
                      if(_senderCountryNameId!=""){
                        _getTransferFees(countryId: _senderCountryNameId,userId: _userId,amount: _userTransferMoneyTxt);
                        _getMoneyConvert(amount:_userTransferMoneyTxt,from: _senderCurrencyName,to: _receiverCurrencyName );
                        _getExchangeRate(from: _senderCurrencyName,to: _receiverCurrencyName);
                        //  _getMoneyConvert(amount:_userTransferMoneyTxt,from: _receiverCurrencyName,to: _senderCurrencyName );

                      }
                    }

                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,

                    hintText: "0.00",
                    hintStyle:  TextStyle(fontSize: 20,
                        color:novalexxa_hint_text_color,
                        // color: Colors.intello_hint_color,
                        fontStyle: FontStyle.normal),
                  ),

                ),

              ),


              Align(
                alignment: Alignment.centerLeft,
                child:   Text(
                  "Transfer Fees: $_transferFee $_senderCurrencyName",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: intello_level_color,
                      fontSize: 9,
                      fontWeight: FontWeight.normal),
                ),
              ),

            ],
          )),
          Expanded(child:InkWell(
            onTap: (){
              _getUserCurrencyTypeListForSender();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                Container(
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _senderCountryName,
                        style: TextStyle(
                            color: intello_level_color,
                            fontSize: 11,
                            fontWeight: FontWeight.normal),
                      ),

                      SizedBox(height: 5,),
                      Text(
                        "$_senderCurrencyName $_senderCurrencySymbol",
                        style: TextStyle(
                            color: novalexxa_text_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),

                if(_senderCountryCode.isNotEmpty&&_senderCountryCode!=null)...{
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Flag.fromString(_senderCountryCode, height: 28, width: 32, fit: BoxFit.fill ),
                  )
                }


              ],
            ),
          ),)
        ],
      ),
    );
  }

  Widget _buildSelectDeliveryMethodItemBankDeposit3() {
    return Container(
      height: 100,
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
      margin: const EdgeInsets.only(left: 30.0, right: 30.0,top: 30),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child:  Text(
                  _switchButtonStatus==true? "$_receiverInputName will receive?":'$_receiverInputName will receive Exactly?',
                  textAlign: TextAlign.left,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              ),

              SizedBox(height: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child:   Text(
                  _receiverReceivedMoney,

                  textAlign: TextAlign.left,

                  style: TextStyle(
                      color: slide_button_end_color,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),

              SizedBox(height: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child:Text(

                  "Exchange Rate: 1 $_senderCurrencyName = $_exchangeRate $_receiverCurrencyName",
                  textAlign: TextAlign.left,

                  style: TextStyle(
                      color: intello_level_color,
                      fontSize: 9,
                      fontWeight: FontWeight.normal),
                ),
              ),

            ],
          )),

          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlutterSwitch(
                      width: _switchButtonWidth,
                      height: _switchButtonHeight,
                      toggleSize: 20.0,
                      activeColor: novalexxa_color,
                      inactiveColor: intello_level_color,

                      value: _switchButtonStatus,
                      borderRadius: 15.0,
                      padding: 5.0,
                      //showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          _switchButtonStatus = val;
                        });
                      },
                    ),
                    Container(width: 10,)
                  ],
                ),


                InkResponse(
                  onTap: (){
                    _getUserCurrencyTypeListForReceiver(_receiverId);

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [

                      Container(
                        margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                            Text(
                              _receiverCountryName,
                              style: TextStyle(
                                  color: intello_level_color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal),
                            ),

                            SizedBox(height: 5,),
                            Text(
                              "$_receiverCurrencyName $_receiverCurrencySymbol",
                              style: TextStyle(
                                  color: novalexxa_text_color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      //
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(5.0),
                      //   child: Flag.fromString(_receiverCountryCode, height: 28, width: 32, fit: BoxFit.fill ),
                      // ),

                      if(_receiverCountryCode.isNotEmpty&&_receiverCountryCode!=null)...{
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Flag.fromString(_receiverCountryCode, height: 28, width: 32, fit: BoxFit.fill ),
                        )
                      },
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        color: novalexxa_text_color,
                        size: 26.0,
                      ),

                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSelectDeliveryMethodItemBankDeposit({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 30.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkResponse(
            onTap: (){
              String sendInputAmountTxt = _transferMoneyAmountController!.text;
              if (sendInputAmountTxt.isEmpty) {
                Fluttertoast.cancel();
                validation_showToast("amount can't empty");
                return;
              }
              if (_exchangeRate=='0.0') {
                Fluttertoast.cancel();
                validation_showToast("exchange rate can't empty");
                return;
              }
              if (_receiverCurrencyId.isEmpty) {
                Fluttertoast.cancel();
                validation_showToast("amount can't empty");
                return;
              }


              _transferMoney(
                exchangeRate: _exchangeRate,
                receiverCurrencyId: _receiverCurrencyId,
                receiverEmail: _receiverEmail,
                receiverName:_receiverInputName,
                receiverSurname: _receiverInputSurName,
                receiverUserCountryId:_receiverInputCountryId,
                receiverUserId: _receiverId,
                receiverUserReceivedMoney: _receiverReceivedMoney,
                senderCurrencyId: _senderCurrencyId,
                senderUserCountryId: _senderCountryNameId,
                senderUserId: _userId,
                senderUserSendAmount: sendInputAmountTxt,
                transferFees: _transferFee
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
                      height: 35,
                      width: 35,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),

          SizedBox(height: 15,),
          Text(
            "Bank Deposit",
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


  Widget _buildSelectDeliveryMethodItemCashPickup({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          InkResponse(
            onTap: (){
              String sendInputAmountTxt = _transferMoneyAmountController!.text;
              if (sendInputAmountTxt.isEmpty) {
                Fluttertoast.cancel();
                validation_showToast("amount can't empty");
                return;
              }
              if (_exchangeRate=='0.0') {
                Fluttertoast.cancel();
                validation_showToast("exchange rate can't empty");
                return;
              }
              if (_receiverCurrencyId.isEmpty) {
                Fluttertoast.cancel();
                validation_showToast("amount can't empty");
                return;
              }

              _transferMoney(
                  exchangeRate: _exchangeRate,
                  receiverCurrencyId: _receiverCurrencyId,
                  receiverEmail: _receiverEmail,
                  receiverName:_receiverInputName,
                  receiverSurname: _receiverInputSurName,
                  receiverUserCountryId:_receiverInputCountryId,
                  receiverUserId: _receiverId,
                  receiverUserReceivedMoney: _receiverReceivedMoney,
                  senderCurrencyId: _senderCurrencyId,
                  senderUserCountryId: _senderCountryNameId,
                  senderUserId: _userId,
                  senderUserSendAmount: sendInputAmountTxt,
                  transferFees: _transferFee
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
                      height: 25,
                      width: 35,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),
          SizedBox(height: 15,),
          Text(
            "Cash Pickup",
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

  Widget _buildSelectDeliveryMethodItemMobileMoney({required String iconLink}) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 30.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          InkResponse(
            onTap: (){
              String sendInputAmountTxt = _transferMoneyAmountController!.text;
              if (sendInputAmountTxt.isEmpty) {
                Fluttertoast.cancel();
                validation_showToast("amount can't empty");
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyDetailForParticularFromMobileScreen(
                      exchangeRate: _exchangeRate,
                      receiverCurrencyId: _receiverCurrencyId,
                      receiverEmail: _receiverEmail,
                      receiverName:_receiverInputName,
                      receiverSurname: _receiverInputSurName,
                      receiverUserCountryId:_receiverInputCountryId,
                      receiverUserId: _receiverId,
                      receiverUserReceivedMoney: _receiverReceivedMoney,
                      senderCurrencyId: _senderCurrencyId,
                      senderUserCountryId: _senderCountryNameId,
                      senderUserId: _userId,
                      senderUserSendAmount: sendInputAmountTxt,
                      transferFees: _transferFee

                  ),),
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
                      height: 35,
                      width: 30,
                      fit: BoxFit.fill,

                    ),
                  ),

                ),
              ),

            ),
          ),
          SizedBox(height: 15,),
          Text(
            "Mobile Money",
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


  void _showLoadingDialog(BuildContext context, String _message) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          child: Wrap(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 30, bottom: 30),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator(
                          backgroundColor: novalexxa_start_bg_color,
                          strokeWidth: 5,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          _message,
                          style: TextStyle(fontSize: 25),
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

  Widget userInputSearchField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 00,right: 00,bottom: 15,top: 15),
      decoration: BoxDecoration(
          color:scan_text_box_color,
          border: Border.all(color: select_country_search_box_border_color,width: 1),
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.search,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor:intello_input_text_color,
          style: TextStyle(color:novalexxa_text_color,fontSize: 16),
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon:  Icon(
              Icons.search,
              color: hint_color,
              size: 25.0,
            ),

            hintText: hintTitle,

            hintStyle:  TextStyle(fontSize: 16,
                color:novalexxa_hint_text_color,
                // color: Colors.intello_hint_color,
                fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  //sender
  _getUserCurrencyTypeListForReceiver(String receiverId) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_USER_CURRENCY_TYPE_LIST$receiverId/'),
          );
          Navigator.of(context).pop();
          // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {

              var data = jsonDecode(response.body);
              _currencyTypeListForRecever = data["data"];
              _showCountryAlertDialogForReceiver(context, _currencyTypeListForRecever);

            });
          } else {
            Fluttertoast.cancel();
          }
        } catch (e) {
          Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      showToast("No Internet Connection!");
    }
  }
  _getUserCurrencyTypeListForReceiver1(String receiverId) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_USER_CURRENCY_TYPE_LIST$receiverId/'),
          );
          Navigator.of(context).pop();
          // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _currencyTypeListForRecever = data["data"];
              if(_currencyTypeListForRecever.length>0){


                _receiverCurrencyName=_currencyTypeListForRecever[0]['currency_information']['currency_name'].toString();
                _receiverCurrencyId=_currencyTypeListForRecever[0]['currency_information']['currency_id'].toString();
                _receiverCurrencySymbol= _currencyTypeListForRecever[0]['currency_information']['currency_symbol'].toString();
                _receiverCountryName=_currencyTypeListForRecever[0]['currency_information']['country_info']["country_name"].toString();
                _receiverCountryCode=_currencyTypeListForRecever[0]['currency_information']['country_info']["country_code_name"].toString();
                _receiverCountryCode=_currencyTypeListForRecever[0]['currency_information']['country_info']["country_code_name"].toString();

                if(_senderCurrencyName!=""&&_receiverCurrencyName!=""){
                  _getExchangeRate(from: _senderCurrencyName,to: _receiverCurrencyName);
                }
              }



            });
          } else {
            Fluttertoast.cancel();
          }
        } catch (e) {
          Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      showToast("No Internet Connection!");
    }
  }
  void _showCountryAlertDialogForReceiver(BuildContext context, List _currencyTypeListData) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
            // color: Colors.green,
            margin: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: Text(
                    "Select your country",
                    style: TextStyle(
                      fontSize: 17,
                      color: novalexxa_text_color,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                userInputSearchField(_searchController!, 'Search country or currency', TextInputType.text),
                Expanded(
                  child: ListView.builder(
                      itemCount: _currencyTypeListData == null ? 0 : _currencyTypeListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();

                              _receiverCurrencyName=_currencyTypeListData[index]['currency_information']['currency_name'].toString();
                              _receiverCurrencyId=_currencyTypeListData[index]['currency_information']['currency_id'].toString();
                              _receiverCurrencySymbol= _currencyTypeListData[index]['currency_information']['currency_symbol'].toString();
                              _receiverCountryName=_currencyTypeListData[index]['currency_information']['country_info']["country_name"].toString();
                              _receiverCountryCode=_currencyTypeListData[index]['currency_information']['country_info']["country_code_name"].toString();
                              if(_userTransferMoneyTxt.isNotEmpty){
                                _getMoneyConvert(amount:_userTransferMoneyTxt,from: _senderCurrencyName,to: _receiverCurrencyName );
                               // _getExchangeRate(from: _senderCurrencyName,to: _receiverCurrencyName);
                              }

                              _getExchangeRate(from: _senderCurrencyName,to: _receiverCurrencyName);

                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Flag.fromString(
                                        _currencyTypeListData[index]['currency_information']['country_info']["country_code_name"].toString(), height: 25, width: 25),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _currencyTypeListData[index]['currency_information']['country_info']["country_name"].toString(),
                                        style: TextStyle(
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

  //get receiver
  _getUserCurrencyTypeListForSender() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_USER_CURRENCY_TYPE_LIST$_userId/'),
          );
          Navigator.of(context).pop();
          // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _currencyTypeListForSender = data["data"];
              _showCountryAlertDialogForSender(context, _currencyTypeListForSender);
            });
          } else {
            Fluttertoast.cancel();
          }
        } catch (e) {
          Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      showToast("No Internet Connection!");
    }
  }
  _getUserCurrencyTypeListForSender1() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_USER_CURRENCY_TYPE_LIST$_userId/'),
          );
          Navigator.of(context).pop();
          // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _currencyTypeListForSender = data["data"];
              if(_currencyTypeListForSender.length>0){
                _senderCurrencyName=_currencyTypeListForSender[0]['currency_information']['currency_name'].toString();
                _senderCurrencyId=_currencyTypeListForSender[0]['currency_information']['currency_id'].toString();
                _senderCurrencySymbol= _currencyTypeListForSender[0]['currency_information']['currency_symbol'].toString();
                _senderCountryName=_currencyTypeListForSender[0]['currency_information']['country_info']["country_name"].toString();
                _senderCountryCode=_currencyTypeListForSender[0]['currency_information']['country_info']["country_code_name"].toString();
                _senderCountryNameId=_currencyTypeListForSender[0]['currency_information']['country_info']["country_id"].toString();
                if(_senderCurrencyName!=""&&_receiverCurrencyName!=""){
                  _getExchangeRate(from: _senderCurrencyName,to: _receiverCurrencyName);
                }
              }



            });
          } else {
            Fluttertoast.cancel();
          }
        } catch (e) {
          Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      showToast("No Internet Connection!");
    }
  }
  void _showCountryAlertDialogForSender(BuildContext context, List _currencyTypeListData) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
            // color: Colors.green,
            margin: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: Text(
                    "Select your country",
                    style: TextStyle(
                      fontSize: 17,
                      color: novalexxa_text_color,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                userInputSearchField(_searchController!, 'Search country or currency', TextInputType.text),
                Expanded(
                  child: ListView.builder(
                      itemCount: _currencyTypeListData == null ? 0 : _currencyTypeListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();
                              _senderCurrencyName=_currencyTypeListData[index]['currency_information']['currency_name'].toString();
                              _senderCurrencyId=_currencyTypeListData[index]['currency_information']['currency_id'].toString();
                              _senderCurrencySymbol= _currencyTypeListData[index]['currency_information']['currency_symbol'].toString();
                              _senderCountryName=_currencyTypeListData[index]['currency_information']['country_info']["country_name"].toString();
                              _senderCountryCode=_currencyTypeListData[index]['currency_information']['country_info']["country_code_name"].toString();
                              _senderCountryNameId=_currencyTypeListData[index]['currency_information']['country_info']["country_id"].toString();
                              if(_userTransferMoneyTxt.isNotEmpty){
                                _getMoneyConvert(amount:_userTransferMoneyTxt,from: _senderCurrencyName,to: _receiverCurrencyName );

                              }
                              _getExchangeRate(from: _senderCurrencyName,to: _receiverCurrencyName);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Flag.fromString(
                                        _currencyTypeListData[index]['currency_information']['country_info']["country_code_name"].toString(), height: 25, width: 25),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _currencyTypeListData[index]['currency_information']['country_info']["country_name"].toString(),
                                        style: TextStyle(
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


//transfer fees api
  _getTransferFees({
    required String userId,
    required String countryId,
    required String amount,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_TRANSFER_MONEY_TRANSFER_FEES'),
              body: {
                'user_id': userId,
                'country_id': countryId,
                'amount': amount,
              });
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);

              if(_userTransferMoneyTxt.isNotEmpty){
                _transferFee=data["transfer_fees"].toString();
              }else{
                _transferFee="0.0";
              }


            });
          }

          else {
            // var data = jsonDecode(response.body.toString());
            // _showToast(data['message']);
          }

        } catch (e) {

       //   _showToast("Try again!");
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }


  _getMoneyConvert({
    required String from,
    required String to,
    required String amount,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_TRANSFER_MONEY_CONVERT'),
              body: {
                'from': from,
                'to': to,
                'amount': amount,
              });
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);

              if(_userTransferMoneyTxt.isNotEmpty){
                _receiverReceivedMoney=data["data"]["result"][to].toString();
              }else{
                _receiverReceivedMoney="0.0";
              }

            //  _transferFee=data["transfer_fees"].toString();

            });
          }

          else {
            // var data = jsonDecode(response.body.toString());
            // _showToast(data['message']);
          }

        } catch (e) {

       //   _showToast("Try again!");
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }


  _getExchangeRate({
    required String from,
    required String to,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_TRANSFER_MONEY_CONVERT'),
              body: {
                'from': from,
                'to': to,
                'amount': "1",
              });
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _exchangeRate=data["data"]["result"]["rate"].toString();
              //  _transferFee=data["transfer_fees"].toString();

            });
          }

          else {
            // var data = jsonDecode(response.body.toString());
            // _showToast(data['message']);
          }

        } catch (e) {

          //   _showToast("Try again!");
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
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



  void _showAlertDialogForSender(BuildContext context, List _currencyTypeListData) {
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
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: Text(
                    "Select your Currency",
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
                      itemCount: _currencyTypeListData == null ? 0 : _currencyTypeListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();

                              _senderCurrencyName=_currencyTypeListForSender[index]['currency_information']['currency_name'].toString();
                              _senderCurrencySymbol= _currencyTypeListForSender[index]['currency_information']['currency_symbol'].toString();
                              _senderCountryName=_currencyTypeListForSender[index]['currency_information']['country_info']["country_name"].toString();
                              _senderCountryCode=_currencyTypeListForSender[index]['currency_information']['country_info']["country_code_name"].toString();



                              // _currentBalance=double.parse(_currencyTypeListData[index]['current_balance'].toString());
                              // _currencySymbol= _currencyTypeListData[index]['currency_information']['currency_symbol'].toString();
                              // _currencyId=_currencyTypeListData[index]['currency_information']['country_id'].toString();


                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [

                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _currencyTypeListData[index]['currency_information']['currency_name'].toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      " - ",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      _currencyTypeListData[index]['current_balance']
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                    ),
                                    Text(

                                      _currencyTypeListData[index]['currency_information']['currency_symbol'].toString(),
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto',
                                      ),

                                      softWrap: false,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                    )
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


}

