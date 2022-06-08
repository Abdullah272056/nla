import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:page_transition/page_transition.dart';

import '../notification/notification_details.dart';
import '../notification/notifications_settings.dart';
import 'email_us.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({Key? key}) : super(key: key);

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
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

            SizedBox(
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
            decoration: new BoxDecoration(
              color:contact_with_us_box_color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(

                color:Colors.grey.withOpacity(.35),
                //  blurRadius: 20.0, // soften the shadow
                blurRadius:20, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset:Offset(
                  2.0, // Move to right 10  horizontally
                  1.0, // Move to bottom 10 Vertically
                ),
              )],
            ),
            width: 90,
            height: 92,
            child: Center(
              child: Container(
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
            margin:EdgeInsets.only(left:0, top: 10, right: 0, bottom:5),
            child:Text(
              itemName,
              style: TextStyle(
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
        margin: EdgeInsets.only(right: 20, top: 10, left: 20, bottom: 10),
        decoration: new BoxDecoration(
          color:contact_with_us_box_color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(

            color:Colors.grey.withOpacity(.35),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset:Offset(
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
                      Align(
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
                        children: [
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
                        children: [
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

                  SizedBox(width: 10,)

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
                              margin: EdgeInsets.only(right: 4, top: 14, left: 14, bottom: 20),
                              child:   Flex(
                                direction: Axis.vertical,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 4, top: 4, left: 4, bottom: 4),
                                    width: 60,
                                    height: 60,
                                    decoration: new BoxDecoration(
                                      border: Border.all(width: 2,color: Colors.white),
                                      boxShadow: [BoxShadow(

                                        color:Colors.grey.withOpacity(.25),
                                        //  blurRadius: 20.0, // soften the shadow
                                        blurRadius:20, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset:Offset(
                                          2.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      )],
                                      borderRadius: new BorderRadius.all(Radius.circular(30.0)),
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
                                            image:
                                            "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                                            imageErrorBuilder: (context, url, error) =>
                                                Image.asset(
                                                  'assets/images/empty.jpg',
                                                  fit: BoxFit.fill,
                                                ),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20, right: 15, bottom: 00, top: 10),
                                      child: Text(
                                        "Mario Rossio",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20, right: 15, bottom: 00, top: 3),
                                      child: Text(
                                        "Available",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: novalexxa_hint_text_color,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(right: 4, top: 4, left: 10, bottom: 4),
                              child:   Flex(
                                direction: Axis.vertical,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 4, top: 4, left: 4, bottom: 4),
                                    width: 60,
                                    height: 60,
                                    decoration: new BoxDecoration(
                                      border: Border.all(width: 2,color: Colors.white),
                                      boxShadow: [BoxShadow(

                                        color:Colors.grey.withOpacity(.25),
                                        //  blurRadius: 20.0, // soften the shadow
                                        blurRadius:20, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset:Offset(
                                          2.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      )],
                                      borderRadius: new BorderRadius.all(Radius.circular(30.0)),
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
                                            image:
                                            "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                                            imageErrorBuilder: (context, url, error) =>
                                                Image.asset(
                                                  'assets/images/empty.jpg',
                                                  fit: BoxFit.fill,
                                                ),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20, right: 15, bottom: 00, top: 10),
                                      child: Text(
                                        "Mario Rossio",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20, right: 15, bottom: 00, top: 3),
                                      child: Text(
                                        "Available",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: novalexxa_hint_text_color,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(right: 4, top: 4, left: 10, bottom: 4),
                              child:   Flex(
                                direction: Axis.vertical,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 4, top: 4, left: 4, bottom: 4),
                                    width: 60,
                                    height: 60,
                                    decoration: new BoxDecoration(
                                      border: Border.all(width: 2,color: Colors.white),
                                      boxShadow: [BoxShadow(

                                        color:Colors.grey.withOpacity(.25),
                                        //  blurRadius: 20.0, // soften the shadow
                                        blurRadius:20, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset:Offset(
                                          2.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      )],
                                      borderRadius: new BorderRadius.all(Radius.circular(30.0)),
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
                                            image:
                                            "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                                            imageErrorBuilder: (context, url, error) =>
                                                Image.asset(
                                                  'assets/images/empty.jpg',
                                                  fit: BoxFit.fill,
                                                ),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20, right: 15, bottom: 00, top: 10),
                                      child: Text(
                                        "Mario Rossio",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20, right: 15, bottom: 00, top: 3),
                                      child: Text(
                                        "Available",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: novalexxa_hint_text_color,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(right: 14, top: 4, left: 10, bottom: 4),
                              child:   Flex(
                                direction: Axis.vertical,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 4, top: 4, left: 4, bottom: 4),
                                    width: 60,
                                    height: 60,
                                    decoration: new BoxDecoration(
                                      border: Border.all(width: 2,color: Colors.white),
                                      boxShadow: [BoxShadow(

                                        color:Colors.grey.withOpacity(.25),
                                        //  blurRadius: 20.0, // soften the shadow
                                        blurRadius:20, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset:Offset(
                                          2.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      )],
                                      borderRadius: new BorderRadius.all(Radius.circular(30.0)),
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
                                            image:
                                            "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
                                            imageErrorBuilder: (context, url, error) =>
                                                Image.asset(
                                                  'assets/images/empty.jpg',
                                                  fit: BoxFit.fill,
                                                ),
                                          )),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20, right: 15, bottom: 00, top: 10),
                                      child: Text(
                                        "Mario Rossio",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Container(
                                    // margin: EdgeInsets.only(left: 20, right: 15, bottom: 00, top: 3),
                                      child: Text(
                                        "Available",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: novalexxa_hint_text_color,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w500),
                                      )),
                                ],
                              ),
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
        margin: EdgeInsets.only(right: 20, top: 20, left: 20, bottom: 10),
        decoration: new BoxDecoration(
          color:contact_with_us_box_color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(

            color:Colors.grey.withOpacity(.35),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset:Offset(
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
                      Align(
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
                        children: [
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

                  SizedBox(width: 10,)

                ],
              ),
            ),
            
            Row(
              children: [
                Expanded(
                  child:  Container(
                  margin: EdgeInsets.only(right: 5, top: 10, left: 18, bottom: 21),
                  height: 40,
                  decoration: new BoxDecoration(
                    color:contact_with_us_box_color,
                    border: Border.all(width: 2,color:novalexxa_customer_services_tab_border_color),
                    boxShadow: [BoxShadow(

                      color:Colors.grey.withOpacity(.25),
                      //  blurRadius: 20.0, // soften the shadow
                      blurRadius:20, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset:Offset(
                        2.0, // Move to right 10  horizontally
                        1.0, // Move to bottom 10 Vertically
                      ),
                    )],
                    borderRadius: new BorderRadius.all(Radius.circular(20)),

                    shape: BoxShape.rectangle,
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Flag.fromString("IT", height: 20, width: 20,borderRadius:10,fit: BoxFit.fill,),
                      SizedBox(width: 8,),
                      Text(
                        "+1 (800) 658379",
                        style: TextStyle(
                            color: novalexxa_text_color,
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),

                  // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
                  
                ),

                ),
                Expanded(
                  child:  Container(
                    margin: EdgeInsets.only(right:18, top: 10, left: 5, bottom: 21),
                    height: 40,
                    decoration: new BoxDecoration(
                      color:contact_with_us_box_color,
                      border: Border.all(width: 2,color:novalexxa_customer_services_tab_border_color),
                      boxShadow: [BoxShadow(

                        color:Colors.grey.withOpacity(.25),
                        //  blurRadius: 20.0, // soften the shadow
                        blurRadius:20, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset:Offset(
                          2.0, // Move to right 10  horizontally
                          1.0, // Move to bottom 10 Vertically
                        ),
                      )],
                      borderRadius: new BorderRadius.all(Radius.circular(20)),
                      shape: BoxShape.rectangle,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flag.fromString("IT", height: 20, width: 20,borderRadius:10,fit: BoxFit.fill,),
                        SizedBox(width: 8,),
                        Text(
                          "+1 (800) 658379",
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 12,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),


                  ),

                ),
              ],
            )




          ],
        )



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
