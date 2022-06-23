
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../api_service/api_service.dart';
import '../../api_service/sharePreferenceDataSaveName.dart';
import '../money_option/pay_nfc/pay_nfc.dart';
import '../money_option/pay_with_qr_code/pay_with_qr_code.dart';
import '../money_option/request_money/request_money_page.dart';
import '../money_option/schedule_a_payment/schedule_a_payment.dart';
import '../money_option/send_money/send_money_page.dart';
import '../money_option/transfer_money/transfer_money_for_selected.dart';
import '../static/loding_dialog.dart';
import '../static/toast.dart';




class ContactSupportMessageScreen extends StatefulWidget {
  String receiverId;
  ContactSupportMessageScreen({required this.receiverId});

  @override
  State<ContactSupportMessageScreen> createState() => _ContactSupportMessageScreenState(this.receiverId);
}

class _ContactSupportMessageScreenState extends State<ContactSupportMessageScreen> {
  String _receiverId;
  _ContactSupportMessageScreenState(this._receiverId);

  TextEditingController? _inputMessageController = TextEditingController();
 // String _senderId="";
  int sendIconVisibility=0;
  List _messageList = [];
  String _inputMessage="";
  String _file="";
  String _senderId = "";
  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {

      if(_senderId!=null &&!_senderId.isEmpty&&_senderId!=""){
        setState(() {
          _sendMessage(sender: _senderId,file: _file,message: _inputMessage,receiver: _receiverId);
          // _receiverId= _receiverResponse["data"]["id"].toString();
          // _getCurrentBalanced();
        });
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:Column(

        children: [
          const SizedBox(
            height: 55,
          ),

          Row(

            children: [
              Container(
                margin: new EdgeInsets.only(left: 25),
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
              Container(
                width: 50,
                height: 50,


                margin:const EdgeInsets.only(left:10, top: 00, right: 15, bottom: 00),
                // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(27.5),
                  child: Container(
                      height: 50,
                      width: 50,
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
              Expanded(child:Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child:Text(
                      "Chatbot Message",
                      style: TextStyle(
                          color: novalexxa_text_color,
                          fontSize: 22,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w600),
                    ),
                  ) ,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Available",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: novalexxa_hint_text_color,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  )


                ],
              )),
              Container(
                margin: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(
                    Icons.more_vert_outlined,
                    color: novalexxa_text_color,
                    size: 25,
                  ),
                  color: novalexxa_text_color,
                  onPressed: () {
                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsSettingsScreen()));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),

          Expanded(child:  ListView.builder(
              padding: EdgeInsets.zero,
              //itemCount: 5,
              itemCount: _messageList==null||_messageList.length<=0?0
                  :_messageList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context,index) {
                if(_senderId==_messageList[index]["sender"].toString()){
                  sendIconVisibility=0;
                  return _buildMessageListItem(_messageList[index]);
                }
                else{

                  if(sendIconVisibility==1){
                    sendIconVisibility=0;
                  }else{
                    sendIconVisibility=1;
                  }

                  return _buildMessageListItem1(_messageList[index],sendIconVisibility);
                }

              }),),

          const SizedBox(
            height: 10,
          ),
          userInputMessageField(_inputMessageController!, 'Type of message...', TextInputType.text),
          const SizedBox(
            height: 15,
          ),
        ],
      ),

    );

  }

  Widget _buildMessageListItem(var response) {
    return Align(
      alignment:_senderId==response["sender"].toString()?Alignment.topRight:Alignment.topLeft ,
      child: Wrap(
        children: [
          Container(

            decoration: BoxDecoration(
              color:_senderId==response["sender"].toString()?novalexxa_color1:receiver_message_bg_color ,
              borderRadius: _senderId==response["sender"].toString()?BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(00.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)):
              BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(00.0))
              ,
            ),



            margin: EdgeInsets.only(right: 30.0, top: 5, bottom: 5, left: 30),
            padding: EdgeInsets.only(right: 15.0, top: 12, bottom: 12, left: 15),
            child: Text(
               convertText(response["message"].toString())
              ,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color:_senderId==response["sender"].toString()?Colors.white:novalexxa_text_color ,
                  // color: Colors.intello_text_color,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              softWrap: false,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageListItem1(var response,int imageVisiable) {
    return Align(
      alignment:_senderId==response["sender"].toString()?Alignment.topRight:Alignment.topLeft ,
      child: Wrap(
        children: [

          if(imageVisiable==1)...{
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(right: 00.0, top: 5, bottom: 5, left: 30),
              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    width: 30,
                    height: 30,
                    color:hint_color,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/empty.jpg',
                      image: "$BASE_URL"+response["sender_info"]["image"].toString(),
                      imageErrorBuilder: (context, url, error) =>
                          Image.asset(
                            'assets/images/empty.jpg',
                            fit: BoxFit.fill,
                          ),
                    )),
              ),

            ),


          }
          else...{
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(right: 00.0, top: 5, bottom: 5, left: 30),
            )
          },

          Container(
            decoration: BoxDecoration(
              color:_senderId==response["sender"].toString()?novalexxa_color1:receiver_message_bg_color ,
              borderRadius: _senderId==response["sender"].toString()?BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(00.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)):
              BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(00.0))
              ,
            ),
            margin: EdgeInsets.only(right: 30.0, top: 5, bottom: 5, left: 20),
            padding: EdgeInsets.only(right: 15.0, top: 12, bottom: 12, left: 15),
            child: Text(
              response["message"].toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color:_senderId==response["sender"].toString()?Colors.white:novalexxa_text_color ,
                  // color: Colors.intello_text_color,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              softWrap: false,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget userInputMessageField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          color:search_send_money_box_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.search,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor:intello_input_text_color,
          style: TextStyle(color:novalexxa_text_color,),
          autofocus: false,
          onChanged: (text){
            if(text.isNotEmpty){
              setState(() {
                sendIconVisibility=1;
              });

            }else{
              setState(() {
                sendIconVisibility=0;
              });

            }

          },
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
              // color: Colors.intello_input_text_color,
                icon: Image.asset(
                  "assets/images/happiness.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,

                ),
                onPressed: () {
                  setState(() {
                    //  searchBoxVisible=0;
                  });
                }),

            suffixIcon: IconButton(
              // color: Colors.intello_input_text_color,
                icon: Image.asset(sendIconVisibility==0?
                  "assets/images/attachment.png":"assets/images/send_icon.png",
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
                onPressed: () {
                  _inputMessage = _inputMessageController!.text;
                  if (_inputMessage.isEmpty) {
                    Fluttertoast.cancel();
                    validation_showToast("message can't empty");
                    return;
                  }

                  setState(() {
                    clearText();
                    sendIconVisibility=0;
                    _sendMessage(sender: _senderId,file: _file,message: _inputMessage,receiver: _receiverId);

                  });
                }),

            hintText: hintTitle,

            hintStyle:  TextStyle(fontSize: 15,
                color:novalexxa_hint_text_color,
                // color: Colors.intello_hint_color,
                fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  _sendMessage(
      {
        required String sender,
        required String receiver,
        required String message,
        required String file,
      }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //  showLoadingDialog(context,"Checking...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_CHAT_WITH_US_SEND_MESSAGE'),
              body: {
                'sender': sender,
                'receiver': receiver,
                'message': message,
              //  'message': message,
                'file': file,
              });
         // Navigator.of(context).pop();
        // _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body.toString());
              _messageList=data["data"];
              //_showToast(_messageList.length.toString());

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
        _senderId = sharedPreferences.getString(pref_user_id)!;
        // _login_status_check = sharedPreferences.getString(pref_login_status)!;

      });
    } catch(e) {
      //code
    }

  }

  void clearText() {
    _inputMessageController!.clear();

  }
   convertText(String data) {


    return data;
  }
}

