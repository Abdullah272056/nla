
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

TextEditingController? _topUpMoneyAmountController = TextEditingController();
  double keyboardfontSize= 25;
  double keyboardfontTopPadding= 13;
  double keyboardfontBottomPadding= 13;
  String inputText="";
  TextStyle keyboardTextStyle= TextStyle(
      color: novalexxa_text_color,
      fontSize: 26,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w500
  );

String _userId = "";
String _currencyId = "0";

String _inputAmountBalance="";
int _inputAmountGatterThanStatus=0;
String _currencySymbol = "";
String _transferFee = "0.00";
List _currencyTypeList = [];

String _alertMessage="Please complete the operation by dailing *150*50# on your phone."
    " The operation is handled by our local service provider Evveress Tech.";

  double _maximumTopUpAmountBalance=500000;


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
                if(_inputAmountGatterThanStatus!=0)...{
                  DelayedWidget(
                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginLoadingScreen()));
                    delayDuration: Duration(milliseconds: 0),// Not required
                    animationDuration: Duration(milliseconds: 700),// Not required
                    animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
                    child: scanMessageSection(),
                  )
                },

                Align(alignment: Alignment.topCenter,
                  child: userInputAmountField(_topUpMoneyAmountController!, '00', TextInputType.text),
                ),

                Expanded(
                  child:  Align(alignment: Alignment.bottomCenter,
                  child: _buildBottomDesign(),
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
            "You can not top up more than 500000 XAF",
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
                  showCursor: true,
                  readOnly: true,
                  cursorColor: Colors.transparent,
                  cursorWidth: 0,
                  //   textInputAction: TextInputAction.search,
                  autocorrect: false,
                  enableSuggestions: false,
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
                            // Icon(
                            //   Icons.arrow_drop_down,
                            //   color: intello_level_color,
                            //   size: 15.0,
                            // ),
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
  return InkResponse(
    onTap: (){
      String amountTxt = _topUpMoneyAmountController!.text;

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

      if(double.parse(amountTxt)>_maximumTopUpAmountBalance){
          Fluttertoast.cancel();
          _showToast("can not more than 500000 XAF");
        return;
      }
       // _showToast(_inputAmountBalance);
      _mobileTopUpTransfer(userId: _userId,mainAmount: amountTxt,mobileNumber: _phoneNumber,
          paymentMethodTypeId: _paymentMethodId);
    },
    child: Container(
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

    ),
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

  Widget _buildBottomDesign() {
    return Container(

        height: 328,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [BoxShadow(

              color:Colors.grey.withOpacity(.3),
              //  blurRadius: 20.0, // soften the shadow
              blurRadius:20, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset:Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              )
          )],

        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 00, top: 15, right: 00, bottom: 0),
            child: Column(
              children: [


                Expanded(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(

                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("1");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "1",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("2");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "2",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("3");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "3",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),

                            ],
                          ),
                        ),

                        Container(

                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("4");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "4",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("5");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "5",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("6");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "6",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),

                            ],
                          ),
                        ),
                        Container(

                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("7");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "7",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("8");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "8",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("9");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "9",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),

                            ],
                          ),
                        ),
                        Container(

                          child: Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard(".");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    ".",
                                    textAlign: TextAlign.center,

                                    style: TextStyle(
                                        color: novalexxa_text_color,
                                        fontSize: 27,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("0");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 00, bottom: keyboardfontBottomPadding),
                                  child: Text(
                                    "0",
                                    textAlign: TextAlign.center,

                                    style: keyboardTextStyle,
                                  ),
                                ),
                              ),),
                              Expanded(child:InkWell(
                                onTap: (){
                                  typeKeyboard("x");
                                },
                                child: Container(
                                  padding:EdgeInsets.only(left: 00, top: keyboardfontTopPadding, right: 10, bottom: keyboardfontBottomPadding),
                                  child:Image.asset('assets/images/icon_backspace.png',
                                    height: 20,
                                    width: 30,
                                  ),
                                  // Text(
                                  //   "x",
                                  //   textAlign: TextAlign.center,
                                  //
                                  //   style: keyboardTextStyle,
                                  // ),
                                ),
                              ),),

                            ],
                          ),
                        ),

                      ],
                    )

                ),


                SizedBox(height: 15,),
                Align(alignment: Alignment.bottomCenter,
                  child: _buildContinueButton(),
                )

              ],
            )));
  }
  void typeKeyboard(String typeKey){
    setState(() {

      if(inputText.isNotEmpty){
        String value=inputText+typeKey;


        if(typeKey=="."){
          if(_inputAmountGatterThanStatus==1){

          }else{
            if (inputText.contains(".")) {
              //_showToast("Already use!");
            }
            else {
              if(inputText!=null&& inputText.isNotEmpty){
                double inputAmountDouble=double.parse(inputText);
                if (inputAmountDouble<=0) {
                  inputText = "0"+typeKey;
                  //_sendMoneyAmountController?.text = typeKey;

                }
                else {
                  inputText = inputText+typeKey;
                  // _sendMoneyAmountController?.text = getOldText+typeKey;

                }
              }else{
                inputText = "0"+typeKey;
              }

            }

          }


        }

        else if(typeKey=="x") {
          if (inputText != null && inputText.length > 1) {
            inputText = inputText.substring(0, inputText.length - 1);

            if(inputText!="."&& inputText!=".0"){
              _inputAmountGatterThanStatus=0;
            }else{
              double inputAmountDouble=double.parse(inputText);

              if(inputAmountDouble>_maximumTopUpAmountBalance){
                _inputAmountGatterThanStatus=1;
              }
              else{
                _inputAmountGatterThanStatus=0;

              }
            }

          }
          else{
            inputText="";
          }

        }

        else{
          //String getOldText = _sendMoneyAmountController!.text;

          if(inputText=="0"){
            inputText=typeKey;
          }
          else{

            if(inputText=="0."||inputText=="."||inputText==".0"||inputText=="0.0"){
              if((inputText=="0.0"&&typeKey=="0") || (inputText==".0"&&typeKey=="0")){

              }else{
                inputText = inputText+typeKey;
              }

            }
            else{
              String value=inputText+typeKey;
              String value1=inputText+typeKey;
              double inputAmountDouble=double.parse(value);

              // String str = "Tom.Hanks";
              if(value1.contains(".")){
                String separator =".";
                int a=0;
                int sepPos = value1.indexOf(separator);

                if (sepPos == -1) {
                  a=0;
                  // System.out.println("");
                }
                else{
                  a= value1.substring(sepPos +separator.length).length;
                }

                if(a>2){
                  // _showToast("getter 2");
                  return;
                }
              }




              if(_inputAmountGatterThanStatus==0){
                if(inputAmountDouble>_maximumTopUpAmountBalance){
                  _inputAmountGatterThanStatus=1;
                  inputText = inputText+typeKey;
                  // _showToast("not possible");
                }
                else{
                  _inputAmountGatterThanStatus=0;

                  if (inputAmountDouble<=0) {
                    inputText=typeKey;
                    //_sendMoneyAmountController?.text = typeKey;

                  }
                  else {
                    inputText = inputText+typeKey;
                    // _sendMoneyAmountController?.text = getOldText+typeKey;

                  }
                }
              }

            }

          }



        }

      }

      else{
        if(typeKey!="x"){
          inputText =typeKey;
        }else{
          inputText ="";
        }

      }
      _topUpMoneyAmountController?.text = inputText;

      if(inputText==""||inputText==null||inputText.isEmpty){
        setState(() {
          _transferFee="0.00";
        });
      }else{
        if(inputText!=""){
          _getTransferFee(inputAmount:inputText );

        }
      }

    });


  }

  void typeKeyboard1(String typeKey){
    setState(() {

      if(inputText.isNotEmpty){
        String value=inputText+typeKey;

        if(typeKey=="."){

          if (inputText.contains(".")) {
            //_showToast("Already use!");
          }
          else {
            if(inputText!=null&& inputText.isNotEmpty){
              double inputAmountDouble=double.parse(inputText);
              if (inputAmountDouble<=0) {
                inputText = "0"+typeKey;
                //_sendMoneyAmountController?.text = typeKey;

              }
              else {
                inputText = inputText+typeKey;
                // _sendMoneyAmountController?.text = getOldText+typeKey;

              }
            }else{
              inputText = "0"+typeKey;
            }

          }

        }
        else if(typeKey=="x") {
          if (inputText != null && inputText.length > 1) {
            inputText = inputText.substring(0, inputText.length - 1);
          }
          else{
            inputText="";
          }

        }
        else{
          //String getOldText = _sendMoneyAmountController!.text;

          if(inputText=="0"){
            inputText=typeKey;
          }
          else{

            if(inputText=="0."||inputText=="."||inputText==".0"||inputText=="0.0"){

              if((inputText=="0.0"&&typeKey=="0") || (inputText==".0"&&typeKey=="0")){
                return;
              }else{
                inputText = inputText+typeKey;
              }

            }
            else{
              String value=inputText+typeKey;
              String value1=inputText+typeKey;
              double inputAmountDouble=double.parse(value);

              //maximum two charater after "." character
              if(value1.contains(".")){
                String separator =".";
                int afterDotCharacterNumber=0;
                int sepPos = value1.indexOf(separator);

                if (sepPos == -1) {
                  afterDotCharacterNumber=0;
                  // System.out.println("");
                }
                else{
                  afterDotCharacterNumber= value1.substring(sepPos +separator.length).length;
                }

                if(afterDotCharacterNumber>2){
                  // _showToast("getter 2");
                  return;
                }
              }

              if (inputAmountDouble<=0) {
                inputText=typeKey;
              }
              else {
                inputText = inputText+typeKey;

              }

            }

          }

        }

      }

      else{
        if(typeKey!="x"){
          inputText =typeKey;
        }else{
          inputText ="";
        }

      }


      _topUpMoneyAmountController?.text = inputText;

      if(inputText==""||inputText==null||inputText.isEmpty){
        setState(() {
          _transferFee="0.00";
        });
      }else{
        if(inputText!=""){
          _getTransferFee(inputAmount:inputText );

        }
      }



    });


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
              'currency_id': "5",
            });

        if (response.statusCode == 200) {
          setState(() {
            // shimmerStatus=false;
            var data = jsonDecode(response.body);
            topUpMobileTransferStatusCheck(data["response_json_data"]["payToken"].toString(),mainAmount);




          });

        }
       else if (response.statusCode == 400) {
          Navigator.of(context).pop();
          var data = jsonDecode(response.body);
          _showToast(data['message']);
         // _showToast("insufficient balance!");
        }
        else {
          Navigator.of(context).pop();
          var data = jsonDecode(response.body);
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


  topUpMobileTransferStatusCheck(String payToken,String mainBalanced) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {

        //  loading();
          Response response =
          await get(Uri.parse('$BASE_URL_API$SUB_URL_API_TOP_UP_MOBILE_TRANSFER_STATUS_CHECK$payToken/'),);

          //_showToast(response.statusCode.toString());



          //  _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            Navigator.of(context).pop();
            setState(() {
              // shimmerStatus=false;
              var data = jsonDecode(response.body);
              //  _transferFee=data["transfer_fee"].toString();

              Navigator.push(context,MaterialPageRoute(builder: (context)=>
                  TopUpMoneyCongratsMobileScreen(sendAmount: mainBalanced,)));
            });



          }
         else if (response.statusCode == 202) {
            setState(() {
              topUpMobileTransferStatusCheck(payToken,mainBalanced);

            });

          }
          else {
            Navigator.of(context).pop();
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>
                TryAgainTopUPScreen()));

          }
        } catch (e) {
          Navigator.of(context).pop();
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

