
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/money_option/pay_with_qr_code/pay_with_qr_send_money_congrats.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:slidable_button/slidable_button.dart';

import '../../../api_service/api_service.dart';
import '../../../api_service/sharePreferenceDataSaveName.dart';
import '../../navigation_page/money_option.dart';
import '../../navigation_page/navigation_bar_page.dart';
import '../../static/toast.dart';


class PayQRMoneySwipeToPayPageScreen extends StatefulWidget {

  String inputBalance;
  String receiverId;
  String currencyId;
  String receiverName;
  PayQRMoneySwipeToPayPageScreen({
    required this.inputBalance,
    required this.receiverId,
    required this.receiverName,
    required this.currencyId,
  });



  // const SendMoneyMessagePageScreen({Key? key}) : super(key: key);

  @override
  State<PayQRMoneySwipeToPayPageScreen> createState() => _PayQRMoneySwipeToPayPageScreenState(
      this.inputBalance,
     this.receiverId,
     this.receiverName,
     this.currencyId,
  );
}

class _PayQRMoneySwipeToPayPageScreenState extends State<PayQRMoneySwipeToPayPageScreen> {
  String _inputBalance;
  String _receiverId;
  String _currencyId;
  String _receiverName;
  _PayQRMoneySwipeToPayPageScreenState(
     this._inputBalance,
     this._receiverId,
     this._receiverName,
     this._currencyId,
  );


  TextEditingController? _sendMoneyAmountController = TextEditingController();
  String _alertMessage="There are many variations of passages of Lorem Ipsum available, "
      "but the majority have suffered alteration in some form, by injected humour, or "
      "randomised words which don't look even slightly believable. If you are going to "
      "use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing"
      " hidden in the middle of text.";

  Color _button_bg_color=slide_button_start_bg_color;
  Color _slide_button_color=slide_button_start_color;
  int _buttonLeftRightStatus=1;


  TextEditingController? _userMessage = TextEditingController();
  String _userId = "";
  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref();

    //     .then((_) {
    //
    // });
  }


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
                            _receiverName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: novalexxa_text_color,
                                fontSize: 26,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //amount section
                            Align(alignment: Alignment.topCenter,
                              child: userAmountSection(),
                            ),

                            SizedBox(height: 60,),
                            //slide button
                            Align(alignment: Alignment.center,
                              child:Row(
                                children: [
                                  Expanded(child: userSlideButtonSection() )
                                ],
                              ),


                            ),
                            SizedBox(height: 30,),
                          ],
                        )),

                        _buildPayLaterButton(),
                        SizedBox(height: 50,),
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
        child: Column(
          children: [
            Row(
              children: [

                Expanded(child:  Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Do you want to send",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: novalexxa_hint_text_color,
                        fontSize: 26,
                        fontWeight: FontWeight.normal),
                  ),
                ),

                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [

                Expanded(child:  Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    _inputBalance.toString()+"€ to "+ _receiverName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                ),
              ],
            ),
          ],
        )

        
        
      ),
    );
  }

  Widget userSlideButtonSection() {
    return Container(
      height: 64,
      margin: EdgeInsets.only(left: 40,right: 40,top: 0,bottom: 0),
      decoration: BoxDecoration(
          color: _button_bg_color,
          borderRadius: BorderRadius.all(Radius.circular(32))
      ),

      padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 0),
      child: SlidableButton(
        height: 50,
        //  buttonWidth: 54.0,
        // color: ,
        buttonColor: _slide_button_color,
        dismissible: false,
        label: Center(
            child:Wrap(
              children: [
                if(_buttonLeftRightStatus==1)...[
                  Text('Swipe\nto pay',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )
                ]
                else...[
                  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ]
              ],
            )



        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 0,bottom: 0),
          child: Center(
            child:Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3))
              ),
              height: 8,
              //width: 200,

            ),
          ),
        ),
        onChanged: (position) {
          setState(() {
            if (position == SlidableButtonPosition.right) {
              _button_bg_color=slide_button_end_bg_color;
              _slide_button_color=slide_button_end_color;
              _buttonLeftRightStatus=2;

              if(_userId!=""){
                _sendAmountBalanced();
              }

            } else {

              _button_bg_color=slide_button_start_bg_color;
              _slide_button_color=slide_button_start_color;
              _buttonLeftRightStatus=1;
              //result = 'Button is on the left';
            }
          });
        },
      ),
    );
  }


  Widget _buildPayLaterButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {

          Route route = MaterialPageRoute(builder: (context) => NavigationBarScreen(2,MoneyOptionScreen()));
          Navigator.pushReplacement(context, route);


        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),

        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [novalexxa_color,novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
              "Pay Later",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }


  _sendAmountBalanced() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Sending...");
        try {
          var response = await post(
              Uri.parse('$BASE_URL_API$SUB_URL_API_QR_CODE_MONEY_SEND'),
              body: {
                'user_id':_userId,
                'receiver':_receiverId,
                'currency_id':_currencyId,
                'send_amount':_inputBalance,
              }
          );
          Navigator.of(context).pop();
          //showToast(response.statusCode.toString());
          if (response.statusCode == 201) {
            setState(() {
              //  var data = jsonDecode(response.body);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: "Foo"),
                  builder: (BuildContext context) => PayWithQRSendMoneyCongratsScreen(
                    receiverName:_receiverName,
                    sendAmount: _inputBalance.toString(),
                  ),),
              );

            });
          }
          else {
            Fluttertoast.cancel();
          }
        } catch (e) {
          showToast("failed!");
          Fluttertoast.cancel();
        }
      }
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      showToast("No Internet Connection!");
    }
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

