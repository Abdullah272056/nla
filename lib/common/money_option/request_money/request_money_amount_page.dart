
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/money_option/request_money/request_money_message_page.dart';

import 'package:nova_lexxa/common/static/Colors.dart';


class RequestMoneyAmountPageScreen extends StatefulWidget {
  String receiverId;
  String receiverName;
  RequestMoneyAmountPageScreen(this.receiverId,this.receiverName);

  @override
  State<RequestMoneyAmountPageScreen> createState() => _RequestMoneyAmountPageScreenState(this.receiverId,this.receiverName);
}

class _RequestMoneyAmountPageScreenState extends State<RequestMoneyAmountPageScreen> {

  String _receiverId;
  String _receiverName;
  _RequestMoneyAmountPageScreenState(this._receiverId,this._receiverName);

  String _currencyId = "1";

  TextEditingController? _requestMoneyAmountController = TextEditingController();
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
                Expanded(child: Stack(
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
                                      "Request Money",
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
                        SizedBox(height: 10,),
                        Align(alignment: Alignment.topCenter,
                          child:  Text(
                            "Request Money to",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: intello_level_color,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Align(alignment: Alignment.topCenter,
                          child:  Text(
                            _receiverName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 26,
                                fontWeight: FontWeight.w600),
                          ),
                        ),


                        Align(alignment: Alignment.topCenter,
                          child: userInputSearchField(_requestMoneyAmountController!, '00 €', TextInputType.text),
                        ),
                        SizedBox(height: 50,),


                        Expanded(child:  Align(alignment: Alignment.bottomCenter,
                          child: InkResponse(
                            onTap: (){
                              String amountTxt = _requestMoneyAmountController!.text;

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


                              Navigator.push(context,MaterialPageRoute(builder: (context)=>RequestMoneyMessagePageScreen(
                                inputBalance:double.parse(amountTxt),
                                currencyId:_currencyId,
                                receiverId: _receiverId,
                                receiverName: _receiverName,
                              )));
                            },
                            child: _buildContinueButton(),
                          ),
                        ),)

                        // Expanded(child:  Align(alignment: Alignment.bottomCenter,
                        //   child: _buildContinueButton(),
                        // ),)






                      ],
                    )
                  ],
                ))

              ],
            ),
          ),
        ],
      )
      
      
      

    );
  }

  Widget userInputSearchField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
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
            Expanded(child:Column(
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

