
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/transaction_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


import '../../api_service/api_service.dart';
import '../../api_service/sharePreferenceDataSaveName.dart';
import '../call_contact/customer_services.dart';
import '../money_option/top_up_account/select_top_up.dart';
import '../notification/notification.dart';
import '../static/toast.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  List _currencyTypeList= [];
  List _transactionHistoryList= [];
  String _userId = "";
  String _userName = "xxxxxxx";

  int _current = 0;
  final CarouselController _controller = CarouselController();
  bool trancactionShimmerStatus=true;
  bool buttonShimmerStatus=true;
  bool headerShimmerStatus=true;
  bool cardShimmerStatus=true;
  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {
          _getUserCurrencyTypeList();
          _getUserTransactionHistoryList();
          // _getChatUserList();
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
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
          //  hasScrollBody: false,
           fillOverscroll: true,
            child:Column(

              children: [

                const SizedBox(
                  height: 55,
                ),
                if(headerShimmerStatus==false)...{
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,

                        child: Container(
                          width: 55,
                          height: 55,


                          margin:const EdgeInsets.only(left:30, top: 00, right: 15, bottom: 00),
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
                      Expanded(child:Column(
                        children: [
                          Flex(direction: Axis.horizontal,
                            children: [
                              Expanded(child:  Align(
                                alignment: Alignment.centerLeft,
                                child:Text(
                                  _userName,
                                  style: TextStyle(
                                      color: novalexxa_text_color,
                                      fontSize: 22,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold),
                                ),
                              ) ,),
                              Container(
                                margin:EdgeInsets.only(right: 15,top: 0,left: 10,bottom: 0),
                                child:InkResponse(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerServicesScreen()));
                                  },
                                  child: Image.asset(
                                    'assets/images/call_icon.png',
                                    height: 22,
                                    fit: BoxFit.fill,
                                  ),
                                ),

                              ),
                              Container(
                                margin:EdgeInsets.only(right: 20,top: 0,left: 10,bottom: 0),
                                child:InkResponse(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsScreen()));

                                  },
                                  child:Image.asset(
                                    'assets/images/icon_noti.png',
                                    height: 25,

                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),



                            ],
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "IT60 X054 2811 1010 0000 0123 456",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: novalexxa_hint_text_color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          )


                        ],
                      )

                      )

                    ],
                  ),
                }
                else...{
                  Container(
                    margin:const EdgeInsets.only(left:30, top: 00, right: 25, bottom: 00),
                    child:  _buildHeaderForShimmer(),
                  )

                },

                const SizedBox(
                  height: 10,
                ),
                //card desing
                // cardItemDesign(),

                if(cardShimmerStatus==false)...{
                  //data set
                  if(_currencyTypeList.length<=0)...{
                    dammyCardDesign(),
                  }
                  else...{
                    CarouselSlider(
                      items: carouselItem(),

                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          height: 170.0,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                  },
                }else...{

                  cardDesignShimmer()
                },

                if(buttonShimmerStatus==false)...{
                  Container(
                    padding:EdgeInsets.only(right: 20,top: 10,left: 20,bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black38,
                          size: 30.0,
                        ),

                        Expanded(child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [

                              Flex(direction: Axis.vertical,
                                children: [
                                  InkWell(

                                    child: Container(
                                      margin:  EdgeInsets.only(left: 20, right: 15,bottom: 10,top: 10),
                                      width: 65,
                                      height: 65,
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(33),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(.35),
                                            blurRadius: 20.0, // soften the shadow
                                            spreadRadius: 0.0, //extend the shadow
                                            offset: Offset(
                                              2.0, // Move to right 10  horizontally
                                              1.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                      ),
                                      //   height: 150,
                                      child: Container(

                                        margin: EdgeInsets.only(right: 17.0,top: 17,bottom: 17,left: 17),
                                        // height: double.infinity,
                                        // width: double.infinity,
                                        color: Colors.white,
                                        child: Image.asset(
                                          "assets/images/deposit_icon.png",
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.fill,
                                        ),
                                      ) ,
                                    ),
                                    onTap: (){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>TopUpScreenScreen()));
                                    },
                                  ),

                                  Container(
                                      margin:  EdgeInsets.only(left: 20, right: 15,bottom: 00,top: 0),
                                      child:  Text(
                                        "Deposit",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )
                                  ),
                                ],
                              ),

                              Flex(direction: Axis.vertical,
                                children: [
                                  Container(
                                    margin:  EdgeInsets.only(left: 15, right: 15,bottom: 10,top: 10),
                                    width: 65,
                                    height: 65,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(33),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.35),
                                          blurRadius: 20.0, // soften the shadow
                                          spreadRadius: 0.0, //extend the shadow
                                          offset: Offset(
                                            2.0, // Move to right 10  horizontally
                                            1.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    //   height: 150,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 17.0,top: 17,bottom: 17,left: 17),
                                      // height: double.infinity,
                                      // width: double.infinity,
                                      color: Colors.white,
                                      child: Image.asset(
                                        "assets/images/invite_friend_icon.png",
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fill,
                                      ),
                                    ) ,
                                  ),

                                  Container(
                                      margin:  EdgeInsets.only(left: 15, right: 15,bottom: 0,top: 0),
                                      child:  Text(
                                        "Invite Friends",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )
                                  ),
                                ],
                              ),

                              Flex(direction: Axis.vertical,
                                children: [
                                  Container(
                                    margin:  EdgeInsets.only(left: 15, right: 15,bottom: 10,top: 10),
                                    width: 65,
                                    height: 65,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(33),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(.35),
                                          blurRadius: 20.0, // soften the shadow
                                          spreadRadius: 0.0, //extend the shadow
                                          offset: Offset(
                                            2.0, // Move to right 10  horizontally
                                            1.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                    ),
                                    //   height: 150,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 17.0,top: 17,bottom: 17,left: 17),
                                      // height: double.infinity,
                                      // width: double.infinity,
                                      color: Colors.white,
                                      child: Image.asset(
                                        "assets/images/stats_icon.png",
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fill,
                                      ),
                                    ) ,
                                  ),

                                  Container(
                                      margin:  EdgeInsets.only(left: 15, right: 15,bottom: 0,top: 0),
                                      child:  Text(
                                        "Stats",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                        ///////////////////////////////////


                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black38,
                          size: 30.0,
                        ),

                      ],
                    ),
                  ),
                }
                else...{
                  Container(
                    padding:EdgeInsets.only(right: 20,top: 10,left: 20,bottom: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color:shimmer_baseColor,
                          size: 30.0,
                        ),

                        Expanded(child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [

                              Flex(direction: Axis.vertical,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor:shimmer_baseColor,
                                    highlightColor:shimmer_highlightColor,
                                    child:Container(
                                      margin:  EdgeInsets.only(left: 20, right: 15,bottom: 10,top: 10),
                                      width: 65,
                                      height: 65,
                                      decoration: new BoxDecoration(
                                        color: shimmer_baseColor,
                                        borderRadius: BorderRadius.circular(33),

                                      ),
                                      //   height: 150,
                                    ),

                                  ),
                                  Shimmer.fromColors(
                                    baseColor:shimmer_baseColor,
                                    highlightColor:shimmer_highlightColor,
                                    child:Container(
                                      height: 17,
                                      width: 65,
                                      color: shimmer_baseColor,
                                      margin:  EdgeInsets.only(left: 20, right: 15,bottom: 00,top: 0),

                                    ),

                                  ),

                                ],
                              ),

                              Flex(direction: Axis.vertical,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor:shimmer_baseColor,
                                    highlightColor:shimmer_highlightColor,
                                    child:Container(
                                      margin:  EdgeInsets.only(left: 20, right: 15,bottom: 10,top: 10),
                                      width: 65,
                                      height: 65,
                                      decoration: new BoxDecoration(
                                        color: shimmer_baseColor,
                                        borderRadius: BorderRadius.circular(33),

                                      ),
                                      //   height: 150,
                                    ),

                                  ),
                                  Shimmer.fromColors(
                                    baseColor:shimmer_baseColor,
                                    highlightColor:shimmer_highlightColor,
                                    child:Container(
                                      height: 17,
                                      width: 65,
                                      color: shimmer_baseColor,
                                      margin:  EdgeInsets.only(left: 20, right: 15,bottom: 00,top: 0),

                                    ),

                                  ),

                                ],
                              ),

                              Flex(direction: Axis.vertical,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor:shimmer_baseColor,
                                    highlightColor:shimmer_highlightColor,
                                    child:Container(
                                      margin:  EdgeInsets.only(left: 20, right: 15,bottom: 10,top: 10),
                                      width: 65,
                                      height: 65,
                                      decoration: new BoxDecoration(
                                        color: shimmer_baseColor,
                                        borderRadius: BorderRadius.circular(33),

                                      ),
                                      //   height: 150,
                                    ),

                                  ),
                                  Shimmer.fromColors(
                                    baseColor:shimmer_baseColor,
                                    highlightColor:shimmer_highlightColor,
                                    child:Container(
                                      height: 17,
                                      width: 65,
                                      color: shimmer_baseColor,
                                      margin:  EdgeInsets.only(left: 20, right: 15,bottom: 00,top: 0),

                                    ),

                                  ),

                                ],
                              ),
                            ],
                          ),
                        )),


                        Icon(
                          Icons.arrow_forward_ios,
                          color: shimmer_baseColor,
                          size: 30.0,
                        ),

                      ],
                    ),
                  ),
                },

                if(trancactionShimmerStatus==false)...{
                  Expanded(child: _buildBottomDesign())
                }else...{
                  SizedBox(height: 15,),
                  Expanded(child: _buildBottomDesignForShimmer())
                }


              ],
            ),
          ),
        ],
      )


    );
  }

  Widget _buildBottomDesign() {
    return Container(
        width: double.infinity,
       // height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.50),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),

        child: Padding(
            padding:
            const EdgeInsets.only(left:25, top: 10, right: 25, bottom: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                children: [
                  Expanded(child: Align(
                    alignment: Alignment.centerLeft,
                    child:Text(
                      "Transaction History",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: novalexxa_text_color,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ),),


                  Align(
                    alignment: Alignment.centerRight,
                    child:InkWell(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>TransactionDetailsScreen()));
                      },
                      child:const Text(
                        "Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: novalexxa_hint_text_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),

                    )


                  ),


                ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                children: [
                  Expanded(child:  Container(
                    margin: EdgeInsets.only(left:0, top: 0, right: 10, bottom: 0),
                    height: .4,
                    color: novalexxa_hint_text_color,

                  ),),
                  // Text(
                  //   "01 Mar, 2020",
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       color: novalexxa_hint_text_color,
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.w400),
                  // ),
                  Expanded(child:  Container(
                    margin: EdgeInsets.only(left:10, top: 0, right: 0, bottom: 0),
                    height: .4,
                    color: novalexxa_hint_text_color,

                  ),),


                ],
                ),

                if(_transactionHistoryList.length<=0)...{
                  Expanded(
                    child: Center(
                      child:
                      Text(
                        "Transaction is not found!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: novalexxa_hint_text_color,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                }
                else...[
                  Expanded(child:  ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _transactionHistoryList==null||_transactionHistoryList.length<=0?0:
                      _transactionHistoryList.length,
                      // physics: NeverScrollableScrollPhysics(),

                      // physics: ClampingScrollPhysics(),
                      shrinkWrap: true,

                      itemBuilder: (BuildContext context, int index) {
                        return transactionItemDesign(_transactionHistoryList[index],Colors.primaries[Random().nextInt(Colors.primaries.length)]);
                      }))
                ]


              ],
            )));
  }

  Widget transactionItemDesign(var response,Color bgColor) {
    return Padding(padding: EdgeInsets.only(right:00,top: 10,left: 00,bottom: 10),
    child:  Row(
      children: [
        //image link not
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Container(
        //     width: 55,
        //     height: 55,
        //     margin:const EdgeInsets.only(left:0, top: 00, right: 15, bottom: 00),
        //     // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(27.5),
        //       child: Container(
        //           height: 55,
        //           width: 55,
        //           color:hint_color,
        //           child: FadeInImage.assetNetwork(
        //             fit: BoxFit.fill,
        //             placeholder: 'assets/images/empty.jpg',
        //             image: "https://i.pinimg.com/236x/44/59/80/4459803e15716f7d77692896633d2d9a--business-headshots-professional-headshots.jpg",
        //             imageErrorBuilder: (context, url, error) =>
        //                 Image.asset(
        //                   'assets/images/empty.jpg',
        //                   fit: BoxFit.fill,
        //                 ),
        //           )),
        //     ),
        //
        //   ),
        // ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 55,
            height: 55,
            margin:const EdgeInsets.only(left:0, top: 00, right: 15, bottom: 00),
            // padding:const EdgeInsets.only(left:10, top: 10, right: 10, bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(27.5),
              child: Container(
                  height: 55,
                  width: 55,
                  color:bgColor,
                  //color:Colors.primaries[Random().nextInt(Colors.primaries.length)],

                  //color:novalexxa_rounded_border_color,
                  child:Center(
                    child: Text(
                      response["receiver_info"]["username"][0].toString()
                      ,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold),
                    ),
                  )
              ),
            ),

          ),
        ),
        Expanded(child:Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child:Text(
                response["receiver_info"]["username"].toString(),
                style: TextStyle(
                    color: novalexxa_text_color,
                    fontSize: 17,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Flex(direction: Axis.horizontal,
            children: [
              Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "10:45 AM",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: novalexxa_hint_text_color,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            ),
              Container(
                margin: const EdgeInsets.only(left: 5.0, right: 3.0),
                decoration: const BoxDecoration(
                  color: novalexxa_color,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
                height: 5,
                width: 5,
              ),
              Align(alignment: Alignment.centerLeft,
              child: Text(
                "pending",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: novalexxa_hint_text_color,
                    fontSize: 13,
                    fontWeight: FontWeight.w400),
              ),
            )],
            )

          ],
        ),),
        Align(
          alignment: Alignment.centerLeft,
          child:Text(
              response["sender_info"]["username"].toString()==_userId?
              "- €"+response["sender_user_send_amount"].toString():
              "+ €"+response["receiver_user_received_money"].toString(),
            style: TextStyle(
                color:response["sender_info"]["username"].toString()==_userId?
                transaction_send_money_color:transaction_receive_money_color,
                fontSize: 17,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10,)

      ],
    ),
    );
  }

  Widget cardItemDesign(var response) {
    return InkWell(
      onTap: (){
        _showToast("€"+response["current_balance"].toString());
      },
      child:  Container(
        margin: EdgeInsets.all(5.0),
        height: 150,
        //  width: 350,

        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage("assets/images/current_balance_card_bg.png"),
            fit: BoxFit.fill,
          ),
        ),

        child: Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            direction: Axis.vertical,
            children: [

              Container(
                  margin:EdgeInsets.only(right: 10,top: 00,left: 20,bottom: 5),
                  child:  Text(
                    "Current Balance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  )
              ),

              Container(
                margin:EdgeInsets.only(right: 10,top: 00,left: 20,bottom: 00),
                child: Text(

                  "€"+response["current_balance"].toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),



            ],
          ),
        ),


        /* add child content here */
      ),
    );
  }

  Widget dammyCardDesign() {
    return InkWell(
      // onTap: (){
      //   _showToast("00");
      // },
      child:  Container(
       // margin: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(left: 30,top: 5,bottom: 5,right: 30),

        height: 150,
        //  width: 350,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/current_balance_card_bg.png"),
            fit: BoxFit.fill,
          ),
        ),

        child: Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            direction: Axis.vertical,
            children: [

              Container(
                  margin:EdgeInsets.only(right: 10,top: 00,left: 20,bottom: 5),
                  child:  Text(
                    "Current Balance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  )
              ),

              Container(
                margin:EdgeInsets.only(right: 10,top: 00,left: 20,bottom: 00),
                child: Text(

                  "00",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
              ),



            ],
          ),
        ),


        /* add child content here */
      ),
    );
  }


  _getUserCurrencyTypeList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       // _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_USER_CURRENCY_TYPE_LIST$_userId/'),
          );
         // Navigator.of(context).pop();
          // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              cardShimmerStatus=false;
              headerShimmerStatus=false;
              buttonShimmerStatus=false;
              var data = jsonDecode(response.body);
              _currencyTypeList = data["data"];
             // _showCountryAlertDialogForReceiver(context, _currencyTypeListForRecever);

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
  _getUserTransactionHistoryList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       // _showLoadingDialog(context, "Loading...");
        try {
          var response = await post(
            Uri.parse('$BASE_URL_API$SUB_URL_API_TRANSACTION_HISTORY_LIST'),
            body: {
              "user_id":_userId
            }
          );
         // Navigator.of(context).pop();
         //  showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              trancactionShimmerStatus=false;
              headerShimmerStatus=false;
              buttonShimmerStatus=false;
              var data = jsonDecode(response.body);
              _transactionHistoryList = data["data"];
             // _showCountryAlertDialogForReceiver(context, _currencyTypeListForRecever);

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
        _userName = sharedPreferences.getString(pref_user_name)!;
        // _login_status_check = sharedPreferences.getString(pref_login_status)!;

      });
    } catch(e) {
      //code
    }

  }

  carouselItem(){
     return _currencyTypeList.map((var response) => Container(
       height: 170,
       child: cardItemDesign(response),
     ))
         .toList();
  }

  //shimmer desing
  Widget _buildBottomDesignForShimmer() {
    return Container(
        width: double.infinity,
        // height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.50),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),

        child: Padding(
            padding:
            const EdgeInsets.only(left:25, top: 10, right: 25, bottom: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(child: Align(
                      alignment: Alignment.centerLeft,
                      child: Shimmer.fromColors(
                        baseColor:shimmer_baseColor,
                        highlightColor:shimmer_highlightColor,
                        child:Container(
                          width: 150,
                          height: 25,
                          decoration: new BoxDecoration(
                            color: shimmer_baseColor,
                            borderRadius: BorderRadius.circular(2.5),

                          ),

                        ),
                      ),
                    ),),

                    Shimmer.fromColors(
                      baseColor:shimmer_baseColor,
                      highlightColor:shimmer_highlightColor,
                      child:Container(
                        width: 65,
                        height: 22,
                        decoration: new BoxDecoration(
                          color: shimmer_baseColor,
                          borderRadius: BorderRadius.circular(2.5),

                        ),

                      ),
                    ),



                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Expanded(child:  Container(
                      margin: EdgeInsets.only(left:0, top: 0, right: 10, bottom: 0),
                      height: .4,
                      color: novalexxa_hint_text_color,

                    ),),
                    // Text(
                    //   "01 Mar, 2020",
                    //   textAlign: TextAlign.center,
                    //   style: TextStyle(
                    //       color: novalexxa_hint_text_color,
                    //       fontSize: 13,
                    //       fontWeight: FontWeight.w400),
                    // ),
                    Expanded(child:  Container(
                      margin: EdgeInsets.only(left:10, top: 0, right: 0, bottom: 0),
                      height: .4,
                      color: novalexxa_hint_text_color,

                    ),),


                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                Expanded(child:  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 7,
                    // physics: NeverScrollableScrollPhysics(),

                    // physics: ClampingScrollPhysics(),
                    shrinkWrap: true,

                    itemBuilder: (BuildContext context, int index) {
                      return _buildTransactionItemForShimmer();
                    }))


              ],
            )));
  }
  Widget _buildTransactionItemForShimmer() {
    return Container(
      margin: EdgeInsets.only(right: 00.0, top: 0, bottom: 0, left: 00),
      //width: 180,
      decoration: new BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        margin: EdgeInsets.only(right: 00.0, top: 10, bottom: 10, left: 00),
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
                  // padding: EdgeInsets.only(right: 12.0,top: 12,bottom: 12,left: 12),
                  width: 57,
                  height: 57,
                  decoration: new BoxDecoration(
                    color: shimmer_baseColor,
                    borderRadius: BorderRadius.circular(28.5),

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
                                      Radius.circular(3.0),

                                    ),
                                  ),
                                  height: 25,
                                  width: double.infinity,


                                ),
                              ),


                            ),
                          ],
                        ),

                      ),

                      SizedBox(
                        height: 5,
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
                                  margin: EdgeInsets.only(right: 5.0,left: 5,bottom: 00),
                                  decoration: BoxDecoration(
                                    color: shimmer_baseColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),

                                    ),
                                  ),
                                  height: 15,
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
              SizedBox(
                width: 5,
              ),
              Shimmer.fromColors(
                baseColor:shimmer_baseColor,
                highlightColor:shimmer_highlightColor,
                child:Container(
                  width: 65,
                  height: 30,
                  decoration: new BoxDecoration(
                    color: shimmer_baseColor,
                    borderRadius: BorderRadius.circular(2.5),

                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    )

    ;
  }
  Widget _buildHeaderForShimmer() {
    return Container(
      margin: EdgeInsets.only(right: 00.0, top: 0, bottom: 0, left: 00),
      //width: 180,
      decoration: new BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        margin: EdgeInsets.only(right: 00.0, top: 10, bottom: 10, left: 00),
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
                  // padding: EdgeInsets.only(right: 12.0,top: 12,bottom: 12,left: 12),
                  width: 57,
                  height: 57,
                  decoration: new BoxDecoration(
                    color: shimmer_baseColor,
                    borderRadius: BorderRadius.circular(28.5),

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
                                      Radius.circular(3.0),

                                    ),
                                  ),
                                  height: 25,
                                  width: double.infinity,


                                ),
                              ),


                            ),
                          ],
                        ),

                      ),

                      SizedBox(
                        height: 5,
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
                                  margin: EdgeInsets.only(right: 5.0,left: 5,bottom: 00),
                                  decoration: BoxDecoration(
                                    color: shimmer_baseColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.0),

                                    ),
                                  ),
                                  height: 15,
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
              SizedBox(
                width: 5,
              ),
              Shimmer.fromColors(
                baseColor:shimmer_baseColor,
                highlightColor:shimmer_highlightColor,
                child:Container(
                  width: 30,
                  height: 30,
                  decoration: new BoxDecoration(
                    color: shimmer_baseColor,
                    borderRadius: BorderRadius.circular(2.5),

                  ),

                ),
              ),
              SizedBox(
                width: 5,
              ),
              Shimmer.fromColors(
                baseColor:shimmer_baseColor,
                highlightColor:shimmer_highlightColor,
                child:Container(
                  width: 30,
                  height: 30,
                  decoration: new BoxDecoration(
                    color: shimmer_baseColor,
                    borderRadius: BorderRadius.circular(2.5),

                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    )

    ;
  }
  Widget cardDesignShimmer() {
    return  Shimmer.fromColors(
      baseColor:shimmer_baseColor,
      highlightColor:shimmer_highlightColor,
      child:Container(
        // margin: EdgeInsets.all(5.0),
        margin: EdgeInsets.only(left: 30,top: 5,bottom: 5,right: 30),

        height: 150,
        //  width: 350,

        color: shimmer_baseColor,




        /* add child content here */
      ),
    );


  }
}

