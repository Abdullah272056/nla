
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
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_details_From_mobile.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../api_service/api_service.dart';


class TransferMoneyDetailForParticularScreen2 extends StatefulWidget {
  const TransferMoneyDetailForParticularScreen2({Key? key}) : super(key: key);

  @override
  State<TransferMoneyDetailForParticularScreen2> createState() => _TransferMoneyDetailForParticularScreen2State();
}

class _TransferMoneyDetailForParticularScreen2State extends State<TransferMoneyDetailForParticularScreen2> {


  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _surnameController = TextEditingController();
  TextEditingController? _birthDayController = TextEditingController();
  String _countryBirthDay="Enter Birthday";
  String select_your_country="Enter Birthday";

  double _switchButtonWidth = 40;
  double _switchButtonHeight = 25;
  double _buttonToggleSize = 20;
  bool _switchButtonStatus = false;
  String _countryName = "Select your country";
  String _countryNameId = "0";
  String _countryCode = "IT";
  List _countryList = [];
  TextEditingController? _searchController = TextEditingController();


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

              SizedBox(height: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child:   Text(
                  "250.00",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: slide_button_end_color,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),

              SizedBox(height: 5,),
              Align(
                alignment: Alignment.centerLeft,
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
          Expanded(child:Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [

              Container(
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Text(
                      "Italy",
                      style: TextStyle(
                          color: intello_level_color,
                          fontSize: 11,
                          fontWeight: FontWeight.normal),
                    ),

                    SizedBox(height: 5,),
                    Text(
                      "Euro €",
                      style: TextStyle(
                          color: novalexxa_text_color,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Flag.fromString(_countryCode, height: 28, width: 32, fit: BoxFit.fill ),
              )

            ],
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
                  _switchButtonStatus==true? "James will receive?":'James will receive Exactly?',
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
                  "382.24",
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
                child:   Text(
                  "Exchange Rate: 1 € = 1.53 CAD",
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
                    _getCountryDataList();

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
                              "Italy",
                              style: TextStyle(
                                  color: intello_level_color,
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal),
                            ),

                            SizedBox(height: 5,),
                            Text(
                              "Euro €",
                              style: TextStyle(
                                  color: novalexxa_text_color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Flag.fromString(_countryCode, height: 28, width: 32, fit: BoxFit.fill ),
                      ),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyCongratsScreen(
                  ),),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyCongratsScreen(
                  ),),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => TransferMoneyDetailForParticularFromMobileScreen(
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
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  void _showAlertDialog(BuildContext context, List _countryListData) {
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
                      itemCount: _countryList == null ? 0 : _countryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();
                              _countryName = _countryListData[index]
                              ['country_name']
                                  .toString();
                              _countryCode = _countryListData[index]
                              ['country_code_name']
                                  .toString();
                              _countryNameId = _countryListData[index]
                              ['country_id']
                                  .toString();
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
                                        _countryListData[index]
                                        ['country_code_name']
                                            .toString(),
                                        height: 25,
                                        width: 25),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _countryListData[index]['country_name']
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

}

