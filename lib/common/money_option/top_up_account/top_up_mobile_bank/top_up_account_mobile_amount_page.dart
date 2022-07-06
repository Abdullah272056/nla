
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/money_option/top_up_account/top_up_mobile_bank/top_up_money_congrats_mobile.dart';
import 'package:nova_lexxa/common/money_option/top_up_account/top_up_mobile_bank/top_up_try_again.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_details_particular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_service/api_service.dart';
import '../../../../api_service/sharePreferenceDataSaveName.dart';
import '../../../static/Colors.dart';
import '../../../static/loding_dialog.dart';


class TopUpAccountMobileAmountPageScreen extends StatefulWidget {
  String paymentMethodId,phoneNumber;

  TopUpAccountMobileAmountPageScreen({required this.paymentMethodId, required this.phoneNumber});

  @override
  State<TopUpAccountMobileAmountPageScreen> createState() => _TopUpAccountMobileAmountPageScreenState(this.paymentMethodId, this.phoneNumber);


}

class _TopUpAccountMobileAmountPageScreenState extends State<TopUpAccountMobileAmountPageScreen> {
  String _paymentMethodId,_phoneNumber;
  _TopUpAccountMobileAmountPageScreenState(
      this._paymentMethodId, this._phoneNumber);

  int _particular_company_selected_status=1;

TextEditingController? _sendMoneyAmountController = TextEditingController();
String _userId = "";
String _currencyId = "0";

String _inputAmountBalance="";
int _inputAmountGatterThanStatus=0;
String _currencySymbol = "";
String _transferFee = "0.00";
List _currencyTypeList = [];

String _alertMessage="Please complete the operation by dailing *150*50# on your phone."
    " The operation is handled by our local service provider Evveress Tech.";

  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref();
  }

@override
Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:Column(

              children: [
                SizedBox(
                  height: 55,
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      margin: new EdgeInsets.only(left:30),
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
                              "Top Up Account",
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
                  height: 50,
                ),

                scanMessageSection(),
                Align(alignment: Alignment.topCenter,
                  child: userInputAmountField(_sendMoneyAmountController!, '00', TextInputType.text),
                ),

                Expanded(child:  Align(alignment: Alignment.bottomCenter,
                  child: InkResponse(
                    onTap: (){
                      String amountTxt = _sendMoneyAmountController!.text;

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
                      // if (double.parse(amountTxt)>_currentBalance) {
                      //   Fluttertoast.cancel();
                      //   _showToast("your current balance is not enough!");
                      //   return;
                      // }
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
                    },
                    child:InkWell(
                      child:  _buildContinueButton(),
                      onTap: (){
                        _mobileTopUpTransfer(userId: _userId,mainAmount: _inputAmountBalance,mobileNumber: _phoneNumber,
                        paymentMethodTypeId: _paymentMethodId);

                      },
                    ),





                  ),
                ),)
              ],
            ),
          ),
        ],
      ),


    );
  }

Widget scanMessageSection() {
  return Container(
    height: 110,
    margin: new EdgeInsets.only(left: 30,right: 30,top: 0,bottom: 15),
    alignment: Alignment.center,

    decoration: BoxDecoration(color:scan_text_box_color, borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 0,bottom: 0, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "You cannot top up more than 500000 XAF",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: novalexxa_hint_text_color,
                fontSize: 25,
                fontWeight: FontWeight.w400),
          ),

        ],

      ),
    ),
  );
}

Widget userInputAmountField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
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
            Expanded(
              child:Column(
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
                  onChanged: (text) {
                    _inputAmountBalance=text;

                    if(text==""||text==null||text.isEmpty){
                      setState(() {
                        _transferFee="0.00";
                      });
                    }else{
                      if(text!=""){
                        _getTransferFee(inputAmount:_inputAmountBalance );

                      }
                    }


                  },
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        child:  Wrap(
                          children: [
                            Text(
                              "Fees:$_transferFee",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: top_up_mobile_fees_text_color,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: intello_level_color,
                              size: 15.0,
                            ),
                          ],
                        ),
                        onTap: (){
                          //_getUserCurrencyTypeList();
                        },
                      )
                    ],
                  ),
                ),

              ],
            ),
            ),




          ],
        )


    ),
  );
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
            "Top Up now",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),

        ],
      )

  );
}

Widget _buildLoadingView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(height: 30,),
      Container(
        child:  SpinKitCircle(
          size: 50,
          color: novalexxa_color,
        ),

        height: 50,
        width: 50,

      ),
      SizedBox(height: 10,),

      Text(
        "Loading",
        //textAlign: TextAlign.center,

        style: TextStyle(
            color:Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400),
      ),




    ],

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

void loading(){
  showDialog(context: context,
      barrierDismissible:false,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(10.0)),
          child:Wrap(
            children: [
              Container(
                padding:EdgeInsets.only(left: 18.0, right: 18.0,top: 30,bottom: 30),
                child: Column(

                  children: [

                    Image.asset(
                      "assets/images/confirm_transaction_icon.png",
                      height: 86,
                      width: 86,
                      fit: BoxFit.fill,
                      //color: novalexxa_color1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Confirm Transaction",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:novalexxa_text_color,
                          fontSize: 20,
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

                    _buildLoadingView()
                  ],
                ),
              )
            ],
          ),
        );
      }
  );
}

_getTransferFee({
      required String inputAmount,
    }) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      try {
        Response response =
        await post(Uri.parse('$BASE_URL_API$SUB_URL_API_TOP_UP_MOBILR_TRANSFER_FEE'),
            body: {
              'amount': inputAmount,

            });

        //  _showToast(response.statusCode.toString());
        if (response.statusCode == 200) {
          setState(() {
            // shimmerStatus=false;
            var data = jsonDecode(response.body);
           _transferFee=data["transfer_fee"].toString();
          });
        }

        else {
          var data = jsonDecode(response.body.toString());
          _showToast(data['message']);
        }
      } catch (e) {
       // Navigator.of(context).pop();
        print(e.toString());
      }
    }
  } on SocketException catch (_) {
    Fluttertoast.cancel();
    _showToast("No Internet Connection!");
  }
}


_mobileTopUpTransfer({
  required String paymentMethodTypeId,
  required String mobileNumber,
  required String userId,
  required String mainAmount,

}) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      try {

        loading();
        Response response =
        await post(Uri.parse('$BASE_URL_API$SUB_URL_API_TOP_UP_MOBILR_TRANSFER'),
            body: {

              'payment_method_type_id': paymentMethodTypeId,
              'mobile_number': mobileNumber,
              'user_id': userId,
              'amount': mainAmount,
              // 'transfer_fee': transferFee,
              // 'sub_amount': subAmount,

            });


        Navigator.of(context).pop();
        //  _showToast(response.statusCode.toString());

        if (response.statusCode == 200) {
          setState(() {
            // shimmerStatus=false;
            var data = jsonDecode(response.body);
          //  _transferFee=data["transfer_fee"].toString();

            Navigator.push(context,MaterialPageRoute(builder: (context)=>
                TopUpMoneyCongratsMobileScreen(sendAmount: mainAmount,)));
          });

        }

        else {
          var data = jsonDecode(response.body.toString());
          _showToast(data['message']);
          Navigator.push(context,MaterialPageRoute(builder: (context)=>
              TryAgainTopUPScreen()));

        }
      } catch (e) {
        // Navigator.of(context).pop();
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
}

