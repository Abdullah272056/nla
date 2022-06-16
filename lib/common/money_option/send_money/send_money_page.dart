
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/money_option/send_money/send_money_amount_page.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_service/api_service.dart';
import '../../../api_service/sharePreferenceDataSaveName.dart';
import '../../static/toast.dart';



class SendMoneyPageScreen extends StatefulWidget {
  const SendMoneyPageScreen({Key? key}) : super(key: key);

  @override
  State<SendMoneyPageScreen> createState() => _SendMoneyPageScreenState();
}

class _SendMoneyPageScreenState extends State<SendMoneyPageScreen> {
  TextEditingController? _searchController = TextEditingController();
  String _userId = "";

  List _recentlyContactUserList = [];

  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {
          _getRecentlyContactList();

        });
      }
      else{
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:SingleChildScrollView(
        child: Column(
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
                          "Send Money",
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
            const SizedBox(
              height: 40,
            ),

            userInputSearchField(_searchController!, 'Search here...', TextInputType.text),

            Align(
              alignment: Alignment.centerLeft,
              child:Container(
                margin:  EdgeInsets.only(left: 30, top: 30, right:10, bottom: 0),
                child: Text(
                  "Recent Contacts",
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 22,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //horizontal list view
            Container(
              margin:  EdgeInsets.only(left: 0, top: 30, right:15, bottom: 0),
              height: 110,
              child:ListView.builder(

                shrinkWrap: true,

                // physics: const NeverScrollableScrollPhysics(),
                //itemCount: offerDataList == null ? 0 : offerDataList.length,
                itemCount: _recentlyContactUserList==null||_recentlyContactUserList.length<=0?0:
                _recentlyContactUserList.length,
                itemBuilder: (context, index) {
                  if(index==0){
                    return recentContactTopListItemDesign(marginLeft: 30,marginRight: 0,response: _recentlyContactUserList[index]);                          }
                  //length
                  if(index==_recentlyContactUserList.length-1){
                    return recentContactTopListItemDesign(marginLeft: 15,marginRight: 30,response: _recentlyContactUserList[index]);
                  }
                  else{
                    return recentContactTopListItemDesign(marginLeft: 15,marginRight: 0,response: _recentlyContactUserList[index]);
                  }
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            //vertical list view
            Container(
              margin:  EdgeInsets.only(left: 15, top: 30, right:15, bottom: 0),
              child:ListView.builder(
                itemCount: _recentlyContactUserList==null||_recentlyContactUserList.length<=0?0:
                _recentlyContactUserList.length,
                padding: EdgeInsets.zero,
                // itemCount: orderRoomList == null ? 0 : orderRoomList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return recentContactBottomListItemDesign(response:_recentlyContactUserList[index]);
                },
              ),
            ),

          ],
        ),
      )

    );
  }

  Widget recentContactBottomListItemDesign({required var response}){
    return InkResponse(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SendMoneyAmountPageScreen()));
      },
      child:  Container(
        margin: EdgeInsets.only(right:00,top: 0,left: 0,bottom: 25),
        height: 48,
        child: Padding(padding: EdgeInsets.only(right:00,top: 0,left: 20,bottom: 0),
          child:  Column(
            children: [
              Expanded(child: Row(
                children: [

                  Align(
                    alignment: Alignment.topLeft,

                    child: Container(
                      width: 40,
                      height: 40,


                      margin:const EdgeInsets.only(left:0, top: 00, right: 15, bottom: 00),
                      // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(27.5),
                        child: Container(
                            height: 55,
                            width: 55,
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
                  Expanded(child:Text(
                      response["username"].toString(),
                    style: TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500),
                  ),),

                  SizedBox(width: 10,)

                ],
              ),),
              Align(alignment:Alignment.bottomRight,
                child:  Container(
                  margin: EdgeInsets.only(left: 50,right: 15),
                  height: 1.5,
                  color:notification_image_bg_color ,
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  // Navigator.push(context,MaterialPageRoute(builder: (context)=>RequestMoneyAmountPageScreen()));
  Widget recentContactTopListItemDesign({required double marginLeft,required double marginRight,required var response}) {
    return  InkResponse(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>SendMoneyAmountPageScreen()));

      },
      child:Container(
        margin:EdgeInsets.only(right:marginRight,top: 10,left:marginLeft,bottom: 10),
        child: Flex(direction: Axis.vertical,
          children: [
            Container(
              width: 61,
              height: 61,

              // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(31),
                child: Container(
                    height: 55,
                    width: 55,
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

            Container(
                margin:  EdgeInsets.only(left: 0, right: 0,bottom: 00,top: 6),
                child:  Text(
                  response["username"].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                )
            ),
          ],
        ),


        /* add child content here */
      ) ,
    );
  }

  Widget userInputSearchField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 50,
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
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon:  Icon(
              Icons.search,
              color: hint_color,
              size: 30.0,
            ),

            hintText: hintTitle,

            hintStyle:  TextStyle(fontSize: 17,
                color:novalexxa_hint_text_color,
                // color: Colors.intello_hint_color,
                fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
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

  _getRecentlyContactList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_RECENTLY_CONTACT_LIST'),
          );
          Navigator.of(context).pop();
         // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
               var data = jsonDecode(response.body);
               _recentlyContactUserList = data["data"];
              // _showAlertDialog(context, _countryList);
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


}

