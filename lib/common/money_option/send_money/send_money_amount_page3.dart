
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
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
import '../../static/toast.dart';
import '../top_up_account/top_up_credit_card/select_top_up.dart';


class SendMoneyAmountPageScreen3 extends StatefulWidget {
  String receiverId;
  String receiverName;
  SendMoneyAmountPageScreen3(this.receiverId,this.receiverName);

  @override
  State<SendMoneyAmountPageScreen3> createState() => _SendMoneyAmountPageScreenState3(this.receiverId,this.receiverName);
}

class _SendMoneyAmountPageScreenState3 extends State<SendMoneyAmountPageScreen3> {
  String _receiverId;
  String _receiverName;
  _SendMoneyAmountPageScreenState3(this._receiverId,this._receiverName);


  TextEditingController? _sendMoneyAmountController = TextEditingController();
  String _userId = "";
  String _currencyId = "0";
  //
  // @override
  // @mustCallSuper
  // initState() {
  //   super.initState();
  //   loadUserIdFromSharePref().then((_) {
  //     if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
  //       setState(() {
  //         _getCurrentBalanced();
  //       });
  //     }
  //     else{
  //     }
  //   });
  // }

  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId.isNotEmpty&&_userId!=""){
        setState(() {
          _getUserCurrencyTypeList1();
          // _getCurrentBalanced();
        });
      }
      else{
      }
    });
  }


  String _alertMessage="There are many variations of passages of Lorem Ipsum available, "
      "but the majority have suffered alteration in some form, by injected humour, or "
      "randomised words which don't look even slightly believable. If you are going to "
      "use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing"
      " hidden in the middle of text.";

  double _currentBalance=0.00;
  int _inputAmountGatterThanStatus=0;
  String _currencySymbol = "";
  List _currencyTypeList = [];

 //

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
                    SizedBox(
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
                              margin: const EdgeInsets.only(left: 30),
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),

                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 60),
                                  child: const Align(
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

                        const SizedBox(height: 10,),
                        const Align(alignment: Alignment.topCenter,
                          child:  Text(
                            "Send Money to",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: intello_level_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Align(alignment: Alignment.topCenter,
                          child:  Text(
                            _receiverName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 26,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        Align(alignment: Alignment.topCenter,
                          child: userInputAmountField(_sendMoneyAmountController!, '00', TextInputType.text),
                        ),

                        if(_inputAmountGatterThanStatus==1)...{
                          DelayedWidget(
                          // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginLoadingScreen()));
                            delayDuration: const Duration(milliseconds: 0),// Not required
                            animationDuration: const Duration(milliseconds: 700),// Not required
                            animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
                            child:InkResponse(
                              onTap: (){

                                Navigator.push(context,MaterialPageRoute(builder: (context)=>const TopUpScreenScreen()));
                              },
                             child: Container(
                               margin: const EdgeInsets.only(top: 20,right: 20,left: 20),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   const Expanded(child: Text("Your current balance is not enough",
                                     textAlign: TextAlign.center,
                                     style: TextStyle(
                                         color:novalexxa_text_color,
                                         fontSize: 12,
                                         fontWeight: FontWeight.normal),
                                   ),),

                                   Container(
                                       padding: const EdgeInsets.only(left: 15,right: 15),
                                       margin: const EdgeInsets.only(left: 17,right: 0),
                                       decoration: BoxDecoration(
                                           gradient: const LinearGradient(colors: [novalexxa_color, novalexxa_color],
                                             begin: Alignment.centerLeft,
                                             end: Alignment.centerRight,
                                           ),
                                           borderRadius: BorderRadius.circular(18.0)
                                       ),
                                       height: 36,
                                       alignment: Alignment.center,
                                       child:const Text(
                                         "Top up my account",
                                         textAlign: TextAlign.center,
                                         style: TextStyle(
                                           fontFamily: 'PT-Sans',
                                           fontSize: 12,
                                           fontWeight: FontWeight.normal,
                                           color: Colors.white,
                                         ),
                                       )

                                   )
                                 ],

                               ),
                             ),
                            )
                          )

                        },

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

                              Navigator.push(context,MaterialPageRoute(builder: (context)=>SendMoneyMessagePageScreen(
                                currentBalance:_currentBalance.toString(),
                                inputBalance:double.parse(amountTxt).toString(),
                                currencyId:_currencyId,
                                receiverId: _receiverId,
                                receiverName: _receiverName,
                                currencySymbol: _currencySymbol,
                              )));
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
      margin: const EdgeInsets.only(left: 30,right: 30,top: 25),
      decoration: BoxDecoration(
          color:search_send_money_box_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 13,bottom: 13, right: 10),
          child: Row(
            children: [
              Expanded(child:  Column(
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    controller: userInput,
                    textInputAction: TextInputAction.search,
                    autocorrect: false,
                    enableSuggestions: false,
                    cursorColor:intello_input_text_color,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))],
                    style: const TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                    onChanged: (text) {
                      if(double.parse(text)>_currentBalance){
                        setState(() {
                          _inputAmountGatterThanStatus=1;
                        });

                        // _showToast("not possible");
                      }else{
                        setState(() {
                          _inputAmountGatterThanStatus=0;
                        });
                      }

                    },
                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: hintTitle,
                      hintStyle:  const TextStyle(fontSize: 22,
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
                               "Current balance is "+_currentBalance.toString()+ _currencySymbol,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: intello_level_color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              const Icon(
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

              IconButton(
                icon: Image.asset(
                  "assets/images/information.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                // color: Colors.white,
                onPressed: () {
                  showDialog(context: context,
                      barrierDismissible:false,
                      builder: (BuildContext context){
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(10.0)),
                          child:Wrap(
                            children: [
                              Container(
                                padding:const EdgeInsets.only(left: 18.0, right: 18.0,top: 18,bottom: 18),
                                child: Column(

                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: Align(
                                            alignment: Alignment.topRight,
                                            child: InkResponse(
                                              onTap: (){
                                                Navigator.of(context).pop();
                                              },
                                              child: const Icon(
                                                Icons.cancel_outlined,
                                                size: 25,
                                              ),
                                            )

                                        ))

                                      ],
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Image.asset(
                                      "assets/images/information.png",
                                      height: 30,
                                      width: 30,
                                      fit: BoxFit.fill,
                                      color: novalexxa_color1,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Lorem Ipsum Title",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:novalexxa_text_color,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Text(_alertMessage,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color:novalexxa_text_color,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),


                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  );

                },
              )


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
          gradient: const LinearGradient(colors: [novalexxa_color, novalexxa_color],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0)
      ),
      height: 65,
      alignment: Alignment.center,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
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
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 30, bottom: 30),
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const CircularProgressIndicator(
                          backgroundColor: novalexxa_color,
                          strokeWidth: 5,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          _message,
                          style: const TextStyle(fontSize: 25),
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
    } on SocketException {
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
    } on SocketException {
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
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: const Text(
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
                            margin: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [

                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _currencyTypeListData[index]['currency_information']['currency_name'].toString(),
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                    ),
                                    const Text(
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

