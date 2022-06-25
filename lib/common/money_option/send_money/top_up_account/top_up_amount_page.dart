
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/money_option/send_money/send_money_message_page.dart';
import 'package:nova_lexxa/common/money_option/send_money/top_up_account/save_card.dart';
import 'package:nova_lexxa/common/static/Colors.dart';

import 'save_card2.dart';
import 'no_credit_cart.dart';


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

  double _currentBalance=1050;
  int _inputAmountGatterThanStatus=0;


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

                              Navigator.push(context,MaterialPageRoute(builder: (context)=>SaveCardsScreen(currencyId: "1",inputBalance: amountTxt,)));
                           //   Navigator.push(context,MaterialPageRoute(builder: (context)=>NoCreditCardScreen()));
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

}

