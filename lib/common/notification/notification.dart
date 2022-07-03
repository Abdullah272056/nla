
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../api_service/api_service.dart';
import '../../api_service/sharePreferenceDataSaveName.dart';
import '../static/toast.dart';
import 'notification_details.dart';
import 'notifications_settings.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _userId = "";
  List _notificationList = [];
  bool shimmerStatus=true;
  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {

      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {
          _getUserNotificationList();
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
      body: Column(

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
                    margin: new EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Notifications",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: novalexxa_text_color,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
              ),

              Container(
                margin: const EdgeInsets.only(right: 30),
                child:IconButton(
                  icon: const Icon(Icons.settings,
                  size: 25,
                  ),
                  color: novalexxa_text_color,
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsSettingsScreen()));

                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),



          if(shimmerStatus==false)...{
            Expanded(child:
            ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _notificationList==null||_notificationList.length<=0?0
                    :_notificationList.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _buildNotificationItemForList(_notificationList[index]);
                })
              ,)
          }else...{
            Expanded(child:  ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _buildNotificationItemForShimmer();
                }),)
          }

        ],
      ),
    );
  }

  Widget _buildNotificationItemForList(var response) {
    return Container(
      margin: EdgeInsets.only(right: 20.0, top: 10, bottom: 10, left: 20),
      //width: 180,
      decoration: new BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(

            color:Colors.grey.withOpacity(.25),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            )
        )],
      ),
      child: InkResponse(
        onTap: (){
          setState(() {

            Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsDetailsScreen("12",response["content"].toString(),response["created_at"].toString())));

          });

        },
        child: SlidableAutoCloseBehavior(
          child: Slidable(

            // Specify a key if the Slidable is dismissible.
            key: ValueKey(0),


            endActionPane:ActionPane(
             extentRatio: .25,
              motion:DrawerMotion(),
              children: [

                SlidableAction(
                  autoClose: true,

                  padding: EdgeInsets.only(left: 10,right: 10),
                  onPressed: (BuildContext context) {

                    setState(() {
                      //_showToast(index.toString() +"Delete");
                    });

                  },
                  flex: 1,

                  borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),

                      ),


                  backgroundColor: novalexxa_start_bg_color,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_rounded,
                  label: 'Delete',
                ),
              ],
            ),


            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child:Container(
              margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 10),
              //color: Colors.white,
              child: SizedBox(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      //  margin:  EdgeInsets.only(left: 10, right: 10,bottom: 10,top: 10),
                      padding: EdgeInsets.only(right: 12.0,top: 12,bottom: 12,left: 12),

                      width: 65,
                      height: 65,
                      decoration: new BoxDecoration(
                        color:notification_image_bg_color,
                        borderRadius: BorderRadius.circular(10),

                      ),
                      //   height: 150,
                      child:Image.asset("assets/images/idea.png",
                        fit: BoxFit.fill,
                      ),

                      // FadeInImage.assetNetwork(
                      //   fit: BoxFit.fill,
                      //   placeholder: 'assets/images/loading.png',
                      //   image:
                      //   "https://technofaq.org/wp-content/uploads/2017/03/image00-21.jpg",
                      //   imageErrorBuilder: (context, url, error) =>
                      //       Image.asset(
                      //         'assets/images/loading.png',
                      //         fit: BoxFit.fill,
                      //       ),
                      // ) ,
                    ),

                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children:  [
                                    Expanded(
                                      child: Text(

                                        response["content"].toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color:novalexxa_text_color,
                                            // color: Colors.intello_text_color,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                        softWrap: false,
                                        maxLines: 2,
                                      ),


                                    ),
                                  ],
                                ),

                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Align(
                                alignment: Alignment.centerLeft,
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children:  [
                                    Expanded(
                                      child: Text(
                                         _dateTimeConvert(response["created_at"].toString()),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(

                                            color:intello_level_color,
                                            // color: Colors.intello_text_color,
                                            fontSize: 11,
                                            fontWeight: FontWeight.normal),
                                        softWrap: false,
                                        maxLines: 2,
                                      ),


                                    ),
                                  ],
                                ),

                              ),

                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  Widget _buildNotificationItemForShimmer() {
    return Container(
      margin: EdgeInsets.only(right: 20.0, top: 10, bottom: 10, left: 20),
      //width: 180,
      decoration: new BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [BoxShadow(
        //
        //     color:Colors.grey.withOpacity(.25),
        //     //  blurRadius: 20.0, // soften the shadow
        //     blurRadius:20, // soften the shadow
        //     spreadRadius: 0.0, //extend the shadow
        //     offset: Offset(
        //       2.0, // Move to right 10  horizontally
        //       1.0, // Move to bottom 10 Vertically
        //     )
        // )],
      ),
      child: Container(
        margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 10),
        //color: Colors.white,
        child: SizedBox(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Shimmer.fromColors(
                baseColor:shimmer_baseColor,
                highlightColor:shimmer_highlightColor,
                child:Container(
                  //  margin:  EdgeInsets.only(left: 10, right: 10,bottom: 10,top: 10),
                  padding: EdgeInsets.only(right: 12.0,top: 12,bottom: 12,left: 12),
                  width: 65,
                  height: 65,
                  decoration: new BoxDecoration(
                    color: shimmer_baseColor,
                    borderRadius: BorderRadius.circular(10),

                  ),

                ),
              ),


              SizedBox(
                width: 5,
              ),
              Expanded(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      Align(
                        alignment: Alignment.centerLeft,
                        child: Flex(
                          direction: Axis.horizontal,
                          children:  [
                            Expanded(
                              child: Shimmer.fromColors(
                                baseColor:shimmer_baseColor,
                                highlightColor:shimmer_highlightColor,
                                child:Container(
                                  margin: EdgeInsets.only(right: 5.0,left: 5,bottom: 0),
                                  decoration: BoxDecoration(
                                    color: shimmer_baseColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6.0),

                                    ),
                                  ),
                                  height: 35,
                                  width: double.infinity,


                                ),
                              ),


                            ),
                          ],
                        ),

                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Flex(
                          direction: Axis.horizontal,
                          children:  [
                            Expanded(
                              child: Shimmer.fromColors(
                                baseColor:shimmer_baseColor,
                                highlightColor:shimmer_highlightColor,
                                child:Container(
                                  margin: EdgeInsets.only(right: 80.0,left: 5,bottom: 00),
                                  decoration: BoxDecoration(
                                    color: shimmer_baseColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(6.0),

                                    ),
                                  ),
                                  height: 20,
                                  width: double.infinity,


                                ),
                              ),


                            ),
                          ],
                        ),

                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    )

    ;
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

  _getUserNotificationList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       // shimmerStatus=true;
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_NOTIFICATION_LIST$_userId/'),
          );
         // Navigator.of(context).pop();
          // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              shimmerStatus=false;
              var data = jsonDecode(response.body);

              _notificationList = data["data"];
              //showToast(_notificationList.length.toString());


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
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 30, bottom: 30),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircularProgressIndicator(
                          backgroundColor: novalexxa_start_bg_color,
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

  _dateTimeConvert(String dateString) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateString);
    String outputDateFormat = DateFormat('dd MMM,yyyy').format(parseDate);
    String outputTimeFormat = DateFormat('hh:mm a').format(parseDate);
    return outputDateFormat+" at "+outputTimeFormat;
  }

}

