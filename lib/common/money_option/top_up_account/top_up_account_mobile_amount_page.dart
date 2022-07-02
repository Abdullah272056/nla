
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_details_particular.dart';

import '../../static/Colors.dart';


class TopUpAccountMobileAmountPageScreen extends StatefulWidget {
  const TopUpAccountMobileAmountPageScreen({Key? key}) : super(key: key);

  @override
  State<TopUpAccountMobileAmountPageScreen> createState() => _TopUpAccountMobileAmountPageScreenState();


}

class _TopUpAccountMobileAmountPageScreenState extends State<TopUpAccountMobileAmountPageScreen> {

int _particular_company_selected_status=1;

TextEditingController? _sendMoneyAmountController = TextEditingController();
String _userId = "";
String _currencyId = "0";

double _currentBalance=0.00;
int _inputAmountGatterThanStatus=0;
String _currencySymbol = "";
List _currencyTypeList = [];

String _alertMessage="Please complete the operation by dailing *150*50# on your phone."
    " The operation is handled by our local service provider Evveress Tech.";

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
                        showDialog(context: context,
                            barrierDismissible:false,
                            builder: (BuildContext context){
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(10.0)),
                                child:Wrap(
                                  children: [
                                    Container(
                                      padding:EdgeInsets.only(left: 18.0, right: 18.0,top: 18,bottom: 18),
                                      child: Column(

                                        children: [


                                          SizedBox(
                                            height: 15,
                                          ),

                                          Image.asset(
                                            "assets/images/information.png",
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.fill,
                                            color: novalexxa_color1,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text("Confirm Transaction",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:novalexxa_text_color,
                                                fontSize: 17,
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
                              "Fees:00 Fcfa ",
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
              fontSize: 20,
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
      Container(
        child:  SpinKitCircle(
          size: 70,
          color: novalexxa_color,



        ),

        height: 70,
        width: 70,

      ),
      SizedBox(height: 10,),
      // SpinKitSquareCircle(
      //   color: Colors.white,
      //   size: 50.0,
      //  // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
      // ),
      Text(
        "Loading",
        //textAlign: TextAlign.center,

        style: TextStyle(
            color:Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w400),
      )




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


}

