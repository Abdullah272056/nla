
import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service/api_service.dart';
import '../../api_service/sharePreferenceDataSaveName.dart';
import '../static/loding_dialog.dart';
import '../static/toast.dart';

class EmailUsPageScreen extends StatefulWidget {
  @override
  State<EmailUsPageScreen> createState() => _EmailUsPageScreenState();
}

class _EmailUsPageScreenState extends State<EmailUsPageScreen> {

  TextEditingController? _sendMoneyMessageController = TextEditingController();
  TextEditingController? _sendTopicController = TextEditingController();
   int _customTopic=0;
   String _topicId="";
  var _emailUsTopicList = [];
  List _data = [];

  String _selectName="";


  String _userId = "";
  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId.isNotEmpty&&_userId!=""){
        setState(() {
          _getEmailTopicList();

        });
      }
      else{
      }
    });
  }
  var dropdownvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:  Column(
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
                      margin: const EdgeInsets.only(left: 30,right: 20),
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: intello_input_text_color,
                          size: 30.0,
                        ),
                      ),
                    ),

                    Expanded(
                        child: toolBarDesign()
                    ),

                  ],
                ),
                userInputSelectTopic(),


                // Container(
                //
                //   alignment: Alignment.center,
                //   margin: new EdgeInsets.only(left: 30,right: 30,top: 50),
                //   decoration: BoxDecoration(
                //       color:search_send_money_box_color,
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Padding(
                //       padding: EdgeInsets.only(left: 10.0, top: 15,bottom: 15, right: 10),
                //       child:Align(alignment: Alignment.topCenter,
                //         child: _buildDropDownMenu(),
                //       )
                //   ),
                // ),


                if(_customTopic==1)...{
                  const SizedBox(height: 30,),
                  userInputCustomTopic(_sendTopicController!, 'Enter your Topic', TextInputType.text,),
                },

                const SizedBox(height: 30,),
                //message section

                userInputMessage(_sendMoneyMessageController!, 'Enter your message', TextInputType.text,),

                Expanded(child:  Align(
                    alignment: Alignment.bottomCenter,
                    child: Wrap(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40, top: 40, right: 40, bottom: 0),
                          child:  Align(
                            alignment: Alignment.topCenter,
                            child: _buildSendMessageButton(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 0),
                          child:  Align(
                            alignment: Alignment.topCenter,
                            child:  _buildCancelButton(),
                          ),
                        ),
                        Container(height: 20,)
                      ],
                    )
                ),)

              ],
            ),
          ),
        ],
      )

    );
  }

  Widget toolBarDesign() {
    return Padding(padding: const EdgeInsets.only(right:00,top: 10,left: 00,bottom: 10),
      child:  Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 42,
              height: 42,


              margin:const EdgeInsets.only(left:0, top: 00, right: 15, bottom: 00),
              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(27.5),
                child: Container(
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
          Expanded(child:Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child:Text(
                  "Send us message",
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w600),
                ),
              ),

              Flex(direction: Axis.horizontal,
                children: const [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Lorem Ipsum is simply",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.4,
                          color: novalexxa_hint_text_color,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                ],
              )

            ],
          ),),

          const SizedBox(width: 10,)

        ],
      ),
    );
  }

  Widget userTopicDropDownSection() {
    return Row(
      children: [

        Expanded(child:Center(
          child: Text(
              dropdownvalue==null?"Select Topic":dropdownvalue.toString()
          ),)
        ),

        const Icon(
          Icons.arrow_drop_down,
          color:intello_input_text_color,
          size: 25.0,
        ),


      ],
    );
  }

  Widget userInputSelectTopic() {
    return Container(
        height: 55,

        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 30,right: 30,top: 50,bottom: 15,),

        decoration: BoxDecoration(
            color:search_send_money_box_color,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(child: DropdownButton2(


              //   menuMaxHeight:55,
              value: _selectName != null && _selectName.isNotEmpty ? _selectName : null,
              underline:const SizedBox.shrink(),
              hint:Row(
                children: const [
                  SizedBox(width: 20,),
                  Text("Select Your Topic",
                      style: TextStyle(
                          color: intello_input_text_color,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                ],
              ),
              isExpanded: true,

             /// icon: SizedBox.shrink(),
              buttonPadding: const EdgeInsets.only(left: 0, right: 14),

              items:
              _data.map((list) {
                return DropdownMenuItem(



                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      const SizedBox(width: 20,),
                      Expanded(child: Text(
                          list["topic_name"].toString(),
                          style: const TextStyle(
                              color: intello_input_text_color,
                              //color: intello_text_color,
                              fontSize: 18,
                              fontWeight: FontWeight.normal)),),


                      const SizedBox(width: 20,),

                    ],
                  ),

                  // Text(list["country_name"].toString()),
                  value: list["topic_id"].toString(),
                );

              },
              ).toList(),
              onChanged: (String? value) {
                //_getCountryDataList1();
                setState((){
                  _selectName=value.toString();
                 // _showToast(_selectName);
                });

              },

            ),)
          ],
        )
    );
  }

  Widget userInputMessage(TextEditingController _controller, String hintTitle, TextInputType keyboardType,) {
    return  Container(
      margin: const EdgeInsets.only(left: 30,right: 30,top: 20),
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
            style: const TextStyle(
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

  Widget userInputCustomTopic(TextEditingController _controller, String hintTitle, TextInputType keyboardType,) {
    return  Container(
      margin: const EdgeInsets.only(left: 30,right: 30,top: 20),
      decoration: BoxDecoration(
          color:search_send_money_box_color,

          borderRadius: BorderRadius.circular(10)),
      child:  Padding(
          padding: const EdgeInsets.only(left: 25.0, top: 0,bottom: 0, right: 20),
          child: TextField(
            minLines: 1,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            controller: _controller,
            autocorrect: false,
            enableSuggestions: false,
            cursorColor:intello_input_text_color,
            style: const TextStyle(
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

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Widget _buildDropDownMenu() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Container(
          child:userTopicDropDownSection(),
        ),
        hint: const Text('hooseNumber'),
        items: _emailUsTopicList.map((item) {
          return DropdownMenuItem(
            value:item["topic_name"]+"~"+item["topic_id"].toString(),
            // value: item['topic_name'].toString(),
            child: _buildDropDownItemDesign(item)
          );
        }).toList(),
        buttonHeight: 8,
        // customItemsHeight: 8,
        itemHeight: 55.0,
        itemPadding: const EdgeInsets.only(left: 10, right: 10),
        //dropdownWidth: 160,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 0),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        offset: const Offset(0, 0),
        onChanged: (newVal) {
          setState(() {
            String abc=newVal.toString();
            String separator ="~";
            int sepPos = abc.indexOf(separator);
            _topicId=abc.substring(sepPos + separator.length);
           // _topicId="1";
            dropdownvalue =newVal;
          });
        },
        value: dropdownvalue,
      ),
    );
  }

  Widget _buildDropDownItemDesign(var response) {
    return SizedBox(
      height: 55,
      child: Column(
        children: [
          Expanded(child:Row(
            children: [
              const SizedBox(width: 10,),
              Align(
                alignment: Alignment.centerLeft,
                child:  Text(
                  response["topic_name"],
                  style: const TextStyle(
                    color: intello_input_text_color,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          )),
          Container(color: select_country_search_box_border_color,
            height: 1,
          )
        ],
      ),
    );
  }

  Widget _buildSendMessageButton() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child: ElevatedButton(
        onPressed: () {

          String messageTxt = _sendMoneyMessageController!.text;

          if (_selectName.isEmpty) {
            Fluttertoast.cancel();
            validation_showToast("Select topic!");
            return;
          }

            if (messageTxt.isEmpty) {
              Fluttertoast.cancel();
              validation_showToast("message can't empty");
              return;
            }

          _sendEmail(
            user_id: _userId,
            send_message: messageTxt,
            topic_id: _selectName
          );


        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [novalexxa_color, novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  const Text(
              "Send Message",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return InkWell(
      onTap: (){
       // Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));
        Navigator.of(context).pop();
      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  const Text(
          "Cancel",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: novalexxa_text_color,
          ),
        ),
      ),
    );
  }

  _getEmailTopicList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_EMAIL_TOPIC_LIST'),

          );
          Navigator.of(context).pop();
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _emailUsTopicList=data["data"];
              _data=data["data"];
             // _showToast(_emailUsTopicList.toString());

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

  _sendEmail(
      {
        required String topic_id,
        required String user_id,
        required String send_message,

      }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_EMAIL_SEND'),
              body: {
                'topic_id': topic_id,
                'user_id': user_id,
                'send_message': send_message,
              });
          Navigator.of(context).pop();

          if (response.statusCode == 201) {
            _showToast("send successfully!");
            var data = jsonDecode(response.body.toString());
            Navigator.of(context).pop();
          }
          else {
            var data = jsonDecode(response.body);
            _showToast(data['message']);
          }
        } catch (e) {
          Navigator.of(context).pop();
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }


}


