
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/common/money_option/top_up_account/top_up_credit_card/save_card.dart';

import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_service/api_service.dart';
import '../../../../api_service/sharePreferenceDataSaveName.dart';
import '../../../static/toast.dart';



class TopUpAmountPageScreen extends StatefulWidget {
  const TopUpAmountPageScreen({Key? key}) : super(key: key);

  @override
  State<TopUpAmountPageScreen> createState() => _TopUpAmountPageScreenState();
}

class _TopUpAmountPageScreenState extends State<TopUpAmountPageScreen> {
  TextEditingController? _sendMoneyAmountController = TextEditingController();
  @override
  String _alertMessage="There are many variations of passages of Lorem Ipsum available, "
      "but the majority have suffered alteration in some form, by injected humour, or "
      "randomised words which don't look even slightly believable. If you are going to "
      "use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing"
      " hidden in the middle of text.";

  double _currentBalance=0.00;
  int _inputAmountGatterThanStatus=0;

  String _currencySymbol = "";
  List _currencyTypeList = [];

  String _userId = "";
  String _currencyId = "0";


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

  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {
          _getUserCurrencyTypeList1();
          // _getCurrentBalanced();
        });
      }
      else{
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:

            Column(

              children: [
                Expanded(child:
                Stack(
                  children: [

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

                        SizedBox(height: 70,),

                        Align(alignment: Alignment.topCenter,
                          child:  Text(
                            "Top Up Account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 23,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        Align(alignment: Alignment.topCenter,
                          child: userInputAmountField(_sendMoneyAmountController!, '00', TextInputType.text),
                        ),

                        Expanded(child:  Align(alignment: Alignment.bottomCenter,
                          child: _buildBottomDesign(),
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
      margin: new EdgeInsets.only(left: 30,right: 30,top: 25),
      decoration: BoxDecoration(
          color:search_send_money_box_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 13,bottom: 13, right: 10),
        child: Row(
          children: [
            Expanded(child:  Column(
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
                    // if(double.parse(text)>_currentBalance){
                    //   setState(() {
                    //     _inputAmountGatterThanStatus=1;
                    //   });
                    //
                    //  // _showToast("not possible");
                    // }else{
                    //   setState(() {
                    //     _inputAmountGatterThanStatus=0;
                    //   });
                    // }

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
                              "Current Currency is = "+ _currencySymbol,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: intello_level_color,
                                  fontSize: 12,
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
                          _getUserCurrencyTypeList();
                        },
                      )
                    ],
                  ),
                ),

              ],
            ),),




          ],
        )
        
        
      ),
    );
  }

  Widget _buildBottomDesign() {
    return InkResponse(
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

        Navigator.push(context,MaterialPageRoute(builder: (context)=>SaveCardsScreen(currencyId: _currencyId,inputBalance: amountTxt,)));


      },
      child: Container(

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
              ))),
    );
  }

  void typeKeyboard(String typeKey){
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

      _sendMoneyAmountController?.text = inputText;

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
                          backgroundColor: novalexxa_color,
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

  _getUserCurrencyTypeList() async {
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
              _currencyTypeList = data["data"];
              _showAlertDialog(context, _currencyTypeList);
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

  _getUserCurrencyTypeList1() async {
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
              _currencyTypeList = data["data"];
              if(_currencyTypeList.length>0){
                _currentBalance=double.parse(_currencyTypeList[0]['current_balance'].toString());
                // _currencySymbol= _currencyTypeList[0]['currency_information']['currency_symbol'].toString();
                _currencySymbol= getCurrency(_currencyTypeList[0]['currency_information']['currency_name'].toString());
                _currencyId=_currencyTypeList[0]['currency_information']['country_id'].toString();
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

  void _showAlertDialog(BuildContext context, List _currencyTypeListData) {
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

                              _currentBalance=double.parse(_currencyTypeListData[index]['current_balance'].toString());
                              _currencySymbol= getCurrency(_currencyTypeListData[index]['currency_information']['currency_name'].toString());
                              _currencyId=_currencyTypeListData[index]['currency_information']['country_id'].toString();


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
                                    // Text(
                                    //   _currencyTypeListData[index]['current_balance']
                                    //       .toString(),
                                    //   style: TextStyle(
                                    //     fontSize: 17,
                                    //     color: Colors.black,
                                    //     fontWeight: FontWeight.normal,
                                    //   ),
                                    //   softWrap: false,
                                    //   overflow: TextOverflow.clip,
                                    //   maxLines: 1,
                                    // ),
                                    Text(
                                      getCurrency(_currencyTypeListData[index]['currency_information']['currency_name'].toString()),
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

  String getCurrency(String currencyCode) {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: currencyCode);
    return format.currencySymbol;
  }


}
