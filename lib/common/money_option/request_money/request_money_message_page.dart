
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/money_option/request_money/request_money_swipe_to_pay_page.dart';
import 'package:nova_lexxa/common/static/Colors.dart';


class RequestMoneyMessagePageScreen extends StatefulWidget {

  String receiverId;
  String currencyId;
  String receiverName;
  double inputBalance;

  RequestMoneyMessagePageScreen({
    required this.inputBalance,
    required this.receiverId,
    required this.receiverName,
    required this.currencyId,
  });
  // const SendMoneyMessagePageScreen({Key? key}) : super(key: key);



  @override
  State<RequestMoneyMessagePageScreen> createState() => _RequestMoneyMessagePageScreenState(
     this.inputBalance,
     this.receiverId,
     this.receiverName,
     this.currencyId,
  );
}

class _RequestMoneyMessagePageScreenState extends State<RequestMoneyMessagePageScreen> {


  String _receiverId;
  String _currencyId;
  String _receiverName;
  double _inputBalance;

  _RequestMoneyMessagePageScreenState(
     this._inputBalance,
     this._receiverId,
     this._receiverName,
     this._currencyId,
  );

  TextEditingController? _sendMoneyMessageController = TextEditingController();
  String _alertMessage="There are many variations of passages of Lorem Ipsum available, "
      "but the majority have suffered alteration in some form, by injected humour, or "
      "randomised words which don't look even slightly believable. If you are going to "
      "use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing"
      " hidden in the middle of text.";


  //TextEditingController? _userMessage = TextEditingController();



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

                        //image section
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

                        //amount section
                        Align(alignment: Alignment.topCenter,
                          child: userAmountSection(),
                        ),
                        SizedBox(height: 30,),
                        //message section
                        Align(alignment: Alignment.topCenter,
                          child:  Text(
                            "Add custom Message to Recipient",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        userInputMessage(_sendMoneyMessageController!, 'Enter your message', TextInputType.text,),



                        Expanded(child:  Align(alignment: Alignment.bottomCenter,
                          child: _buildContinueButton(),
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

  Widget userAmountSection() {
    return Container(

      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 30,right: 30,top: 25),
      decoration: BoxDecoration(
          color:search_send_money_box_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 25,bottom: 25, right: 10),
        child: Row(
          children: [

            Expanded(child:  InkResponse(
              onTap: (){
                Navigator.of(context).pop();
              },
            child:Align(
              alignment: Alignment.topCenter,
              child: Text(
                _inputBalance.toString()+"€",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: novalexxa_text_color,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),

            ),

            ),




          ],
        )
        
        
      ),
    );
  }

  Widget userInputMessage(TextEditingController _controller, String hintTitle, TextInputType keyboardType,) {
    return  Container(
      margin: new EdgeInsets.only(left: 30,right: 30,top: 20),
      decoration: BoxDecoration(
          color:search_send_money_box_color,

          borderRadius: BorderRadius.circular(10)),
      child:  Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 0,bottom: 0, right: 20),
          child: TextField(
            minLines: 6,
            maxLines: 30,
            keyboardType: TextInputType.multiline,
            controller: _controller,
            autocorrect: false,
            enableSuggestions: false,
            cursorColor:intello_input_text_color,
            style: TextStyle(
                color:intello_input_text_color,
                fontSize: 17,
            ),
            autofocus: false,

            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTitle,
              hintStyle: const TextStyle(fontSize: 15, color:hint_color, fontStyle: FontStyle.normal),
            ),

          )

      ),
    );
  }


  Widget _buildContinueButton() {
    return InkResponse(
      onTap: (){
        String messageTxt = _sendMoneyMessageController!.text;
        if (messageTxt.isEmpty) {
          messageTxt="";

          // Fluttertoast.cancel();
          // _showToast("message can't empty");
          // return;
        }


        Navigator.push(context,MaterialPageRoute(builder: (context)=>RequestMoneySwipeToPayPageScreen(
          inputBalance: _inputBalance.toString(),
          message: messageTxt,
          receiverId:_receiverId,
          currencyId: _currencyId,
          receiverName: _receiverName,

        )));

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



}

