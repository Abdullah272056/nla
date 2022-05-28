import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/Particular/particular_information.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'home_page.dart';
import 'navigation_bar_page.dart';
import 'notifications_deleted.dart';



class NotificationsDetailsScreen extends StatefulWidget {
  String _notificationId;

  NotificationsDetailsScreen(
      this._notificationId); //  const NotificationsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsDetailsScreen> createState() => _NotificationsDetailsScreenState(this._notificationId);
}

class _NotificationsDetailsScreenState extends State<NotificationsDetailsScreen> {
  String _notificationId;
  _NotificationsDetailsScreenState(
      this._notificationId);

  String _messageFullText="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt "
      "ut labore et dolore magna aliqua. Ut enim ad minim veniam,"
      " quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in"
      " repre henderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat "
      "cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis"
      " unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa "
      "quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."
      " Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni "
      "dolores eos qui ratione voluptatem sequi nesciunt.";
  String _timeTxt="06 Jun,2020 at 04:10 Pm";


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
                      child: InkWell(

                        onTap: () {

                          _showToast("cog");
                        },
                        child:Text(
                          "cog",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),

                Stack(
                  children: [
                    _buildMessageSection(),
                    Container(
                      margin:  EdgeInsets.only(left: 40, right: 10,bottom: 0,top: 0),
                      padding: EdgeInsets.only(right: 15.0,top: 15,bottom: 15,left: 15),

                      width: 80,
                      height: 80,
                      decoration: new BoxDecoration(
                        color: notification_image_bg_color,
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
                  ],
                ),

                _buildBottomButtonSection()




              ],
            ),
          ),
        ],
      )



    );
  }

  Widget _buildMessageSection() {
    return InkResponse(
      onTap: (){
        //Navigator.push(context,MaterialPageRoute(builder: (context)=>TeacherProfileViewScreen()));

      },
      child: Container(
        margin:  EdgeInsets.only(right: 30.0, top: 40, bottom: 10, left: 30),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.35),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: const Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        //   height: 150,
        child: Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0,top: 60),
          child: Column(
            children: [
              //teacher profile


              Container(
                margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 15,bottom: 0),
                child: Text(
                    _messageFullText,
                  style: TextStyle(
                      color:novalexxa_text_color,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Align(alignment: Alignment.bottomLeft,
              child:Container(
                margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 20,bottom: 20),
                child: Text(
                  _timeTxt,
                  style: TextStyle(
                      color:intello_level_color,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ),
              )

            ],
          ),
        ),
      ),

    );
  }

  Widget _buildBottomButtonSection() {
    return Flex(direction: Axis.horizontal,
      children: [
        Expanded(child: _buildGotToHomeButton()),
        _buildTrashAltButton()
      ],
    );
  }

  Widget _buildGotToHomeButton() {
    return InkResponse(
      onTap: (){

        Navigator.push(context,MaterialPageRoute(builder: (context)=>NavigationBarScreen(0,HomePageScreen())));
      },
      child:  Container(
        margin:  EdgeInsets.only(left: 30, right: 10,bottom: 0,top: 20),
        //width: 80,
        height: 45,
        decoration: new BoxDecoration(
          color: novalexxa_color,
          borderRadius: BorderRadius.circular(10),

        ),
        //   height: 150,
        child: Center(
          child:  Text(
            "Go to Home",
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
    );


  }

  Widget _buildTrashAltButton() {
    return InkResponse(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsDeletedScreen()));

      },

      child: Container(
        margin:  EdgeInsets.only(left: 10, right: 30,bottom: 0,top: 20),
        padding:  EdgeInsets.only(left: 30, right:30,bottom: 0,top: 0),
        //width: 80,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.35),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: const Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        //   height: 150,
        child: Center(
          child:  Text(
            "trash-alt",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color:novalexxa_color,
            ),
          ),
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

}

