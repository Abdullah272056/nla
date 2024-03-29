import 'dart:convert';
import 'dart:io';

import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service/api_service.dart';
import '../../api_service/sharePreferenceDataSaveName.dart';
import '../static/toast.dart';
import 'contact_support_message.dart';
import 'email_us.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({Key? key}) : super(key: key);

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  String _userId = "";

  List _speakWithUsList = [];
  List _chatWithUsList = [];
  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId.isNotEmpty&&_userId!=""){
        setState(() {
          _getSpeakUserList();
          _getChatUserList();
        });
      }
      else{
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                      color: novalexxa_text_color,
                      size: 30.0,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Contact Support",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
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
              height: 50,
            ),

            //Chat with us
            _build_chat_with_us_section(),


            _build_speak_with_us_section(),


            // email office feedback
            Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkResponse(
                  onTap: (){
                    Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: EmailUsPageScreen()));

                  },
                  child:  _build_email_office_feedback_button(marginLeft:10,marginRight: 5,itemName: "Email us",
                      iconLink: 'assets/images/icon_email_us.png' ),
                ),

                InkResponse(
                  onTap: (){

                  },
                  child:  _build_email_office_feedback_button(marginLeft:5,marginRight: 5,itemName: "Our Office" ,
                      iconLink: 'assets/images/icon_company.png'),
                ),

                InkResponse(
                  onTap: (){

                  },
                  child: _build_email_office_feedback_button(marginLeft:5,marginRight: 10,itemName: "Feedback",
                      iconLink: 'assets/images/icon_feedback.png' ),
                ),

              ],
            ),

            const SizedBox(
              height: 25,
            ),


          ],
        ),
      ),
    );
  }


  Widget _build_email_office_feedback_button({required double marginLeft,required double marginRight,
    required String itemName,required String iconLink}){
    return Container(

      margin:EdgeInsets.only(left: marginLeft, right: marginRight,top: 15),
      child: Column(
        children: [
          Container(

            margin:const EdgeInsets.only(left:5, top: 5, right: 5, bottom:5),
            decoration: BoxDecoration(
              color:contact_with_us_box_color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(

                color:Colors.grey.withOpacity(.35),
                //  blurRadius: 20.0, // soften the shadow
                blurRadius:20, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset:const Offset(
                  2.0, // Move to right 10  horizontally
                  1.0, // Move to bottom 10 Vertically
                ),
              )],
            ),
            width: 90,
            height: 92,
            child: Center(
              child: SizedBox(
                width: 43,
                height: 47,
                child: Image.asset(
                  iconLink,
                  height: 47,
                  width: 47,
                  fit: BoxFit.fill,
                ),

              ),
            ),
            // child:  ,
          ),
          Container(
            margin:const EdgeInsets.only(left:0, top: 10, right: 0, bottom:5),
            child:Text(
              itemName,
              style: const TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }


  Widget _build_chat_with_us_section() {
    return Container(
        margin: const EdgeInsets.only(right: 20, top: 10, left: 20, bottom: 10),
        decoration: BoxDecoration(
          color:contact_with_us_box_color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(

            color:Colors.grey.withOpacity(.35),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset:const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )],
        ),

        child: Column(
          children: [
            Container(
              margin:const EdgeInsets.only(left:15, top: 20, right: 15, bottom: 12),
              child:   Row(
                children: [

                  Align(
                    alignment: Alignment.topLeft,

                    child: Container(
                      width: 50,
                      height: 50,


                      margin:const EdgeInsets.only(left:10, top: 00, right: 15, bottom: 00),
                      // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
                      child: Image.asset(
                        'assets/images/chat.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                        color: Colors.pink,
                      ),

                    ),


                  ),
                  Expanded(child:Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child:Text(
                          "Chat with us",
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flex(direction: Axis.horizontal,
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Lorem Ipsum Dolor...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  color: novalexxa_hint_text_color,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),

                        ],
                      ),
                      Flex(direction: Axis.horizontal,
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Mon - Fri | 9:00 AM - 6:00 PM",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  color: novalexxa_hint_text_color,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),

                        ],
                      ),



                    ],
                  ),),

                  const SizedBox(width: 10,)

                ],
              ),
            ),



            Row(
              children: [
                Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [

                            Container(
                                margin: const EdgeInsets.only(top: 0),
                                height:130.0,

                                // child: _buildRecentlyAddedCourseItem(),
                                child: ListView.builder(
                                  shrinkWrap: true,

                                  // physics: const NeverScrollableScrollPhysics(),
                                  //itemCount: offerDataList == null ? 0 : offerDataList.length,
                                  itemCount: _chatWithUsList.length<=0?0:
                                  _chatWithUsList.length,
                                  itemBuilder: (context, index) {
                                    return _build_chat_with_us_sectionNumberListItem(_chatWithUsList[index]);
                                  },
                                  scrollDirection: Axis.horizontal,
                                )
                            ),



                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        )



    );
  }


  Widget _build_speak_with_us_section() {
    return Container(
      // padding: EdgeInsets.only(right: 10, top: 10, left: 10, bottom: 10),

        margin: const EdgeInsets.only(right: 20, top: 20, left: 20, bottom: 10),
        decoration: BoxDecoration(
          color:contact_with_us_box_color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(

            color:Colors.grey.withOpacity(.35),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset:const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )],
        ),

        child: Column(
          children: [
            Container(
              margin:const EdgeInsets.only(left:15, top: 20, right: 15, bottom: 10),
              child:   Row(
                children: [

                  Align(
                    alignment: Alignment.topLeft,

                    child: Container(
                      width: 35,
                      height: 35,


                      margin:const EdgeInsets.only(left:10, top: 00, right: 15, bottom: 00),
                      // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
                      child: Image.asset(
                        'assets/images/icon_call.png',
                        height: 35,
                        width: 35,
                        fit: BoxFit.fill,
                      ),

                    ),


                  ),
                  Expanded(child:Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child:Text(
                          "Speak with us",
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flex(direction: Axis.horizontal,
                        children: const [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Lorem Ipsum Dolor...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  color: novalexxa_hint_text_color,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),

                        ],
                      ),




                    ],
                  ),),

                  const SizedBox(height: 10,)

                ],
              ),
            ),

            Container(
              margin:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: GridView.builder(
                  itemCount: _speakWithUsList.length<=0?0:
                  _speakWithUsList.length,
                  shrinkWrap: true,
                  padding:const EdgeInsets.only(left:0, top: 00, right: 0, bottom: 0),
                  physics: const ClampingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 10.0,
                      // mainAxisSpacing: 10.0,
                      mainAxisExtent: 52
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return _build_speak_with_us_sectionNumberListItem(_speakWithUsList[index]);
                  }),
            )



          ],
        )



    );
  }

  Widget _build_speak_with_us_sectionNumberListItem(var response) {
    return  InkWell(
      onTap: (){
       // _showToast("ok");

        _callNumber(response["phone_number"].toString());

       // _launchCaller("01994215664");
      },
      child: Container(
        margin: const EdgeInsets.only(right: 5,  left: 10, bottom: 10),
        height: 40,
        decoration: BoxDecoration(
          color:contact_with_us_box_color,
          border: Border.all(width: 1,color:novalexxa_customer_services_tab_border_color),
          boxShadow: [BoxShadow(

            color:Colors.grey.withOpacity(.25),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset:const Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )],
          borderRadius: const BorderRadius.all(Radius.circular(20)),

          shape: BoxShape.rectangle,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(response["country_info"]["country_code_name"].toString()!="" &&
                response["country_info"]["country_code_name"].toString()!="null")...[
              Flag.fromString(response["country_info"]["country_code_name"], height: 20, width: 20,borderRadius:10,fit: BoxFit.fill,),
            ],

            const SizedBox(width: 8,),
            Text(
              response["phone_number"].toString(),
              style: const TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 12,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),

        // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),

      ),
    );
  }

  Widget _build_chat_with_us_sectionNumberListItem(var response) {
    return  InkWell(
      onTap: (){

        Navigator.push(context,MaterialPageRoute(builder: (context)=>ContactSupportMessageScreen(receiverId: response["id"].toString(),)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 4, top: 14, left: 14, bottom: 20),
        child:   Flex(
          direction: Axis.vertical,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4, top: 4, left: 4, bottom: 4),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(width: 2,color: Colors.white),
                boxShadow: [BoxShadow(

                  color:Colors.grey.withOpacity(.25),
                  //  blurRadius: 20.0, // soften the shadow
                  blurRadius:20, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset:const Offset(
                    2.0, // Move to right 10  horizontally
                    1.0, // Move to bottom 10 Vertically
                  ),
                )],
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                shape: BoxShape.rectangle,
              ),

              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),

                child: Container(
                    height: 60,
                    width: 60,
                    color: hint_color,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'assets/images/empty.jpg',
                      image: response["image"].toString(),
                      imageErrorBuilder: (context, url, error) =>
                          Image.asset(
                            'assets/images/empty.jpg',
                            fit: BoxFit.fill,
                          ),
                    )),
              ),
            ),
            Text(
              response["username"].toString() ,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              "Available",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: novalexxa_hint_text_color,
                  fontSize: 9,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }




  _getSpeakUserList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_SPEAK_WITH_US_LIST'),

          );
          Navigator.of(context).pop();
         // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
               var data = jsonDecode(response.body);
               _speakWithUsList=data["data"];
               // _showToast(_speakWithUsList.length.toString());
              // _currentBalance=double.parse(data["amount"].toString());
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

  _getChatUserList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_CHAT_WITH_US_LIST'),

          );
          Navigator.of(context).pop();
           //showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _chatWithUsList=data["data"];
             // _showToast(_chatWithUsList.length.toString());
              // _currentBalance=double.parse(data["amount"].toString());
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
  _callNumber(String number) async{
    // bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
