

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
import '../static/toast.dart';
import 'customer_service_details.dart';

class CustomerServicesScreen extends StatefulWidget {
  const CustomerServicesScreen({Key? key}) : super(key: key);
  @override
  State<CustomerServicesScreen> createState() => _CustomerServicesScreenState();
}

class _CustomerServicesScreenState extends State<CustomerServicesScreen> with SingleTickerProviderStateMixin{
  String countryName="en",countryIcon="icon_country.png";

  late AnimationController controller;
  late Animation heartbeatAnimation;

  var AllTextColor,currencyRatesTextColor,privacyPolicyTextColor,customerServiceTextColor;
  TextEditingController? _searchController = TextEditingController();
  var AllTabColor,currencyRatesTabColor,privacyPolicyTabColor,customerServiceTabColor;
  int tab_status = 1;
  int list_grid_status = 1;
  String _userId = "";
  String _serviceTypeName = "All Question";
  List _customerServiceTypeList = [];
  List _customerServiceList = [];
  List _customerServiceList1 = [];
  int selectedTabPosition=0;

  @override
  @mustCallSuper
  initState() {
    super.initState();
    setState(() {
   //  _getCustomerServiceAllList();
     // _getCustomerServiceSingleTypeList("1");
      _getCustomerServiceTypeList();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: novalexxa_color,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: 50,
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
                      margin: new EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Customer Services",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child:IconButton(
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: Colors.white,
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
            SizedBox(
              height: 30,
            ),
            userInputSearchField(_searchController!, 'Search here...', TextInputType.text),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: _buildBottomDesign(),
            ),

          ],
        ),

        /* add child content here */
      ),
    );
  }

  Widget _buildBottomDesign() {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 00, top: 10, right: 00, bottom: 30),
            child:Column(
              children: [
                Expanded(
                  child: Column(
                    children: [

                      _buildTabButton(),
                      SizedBox(
                        height: 10,
                      ),


                      Expanded(child: _currencyRatesDataSection(serviceName: _serviceTypeName))
                      // all data tab section


                    ],
                  ),
                )
              ],
            )

        ));
  }

  Widget _buildTabButton() {
    return Container(
        height: 40,
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      child:
      ListView.builder(
          padding: EdgeInsets.zero,
          itemCount:_customerServiceTypeList==null||_customerServiceTypeList.length<=0?0
              :_customerServiceTypeList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if(index==0){
              return _buildCurrencyTypeItem(20,5,_customerServiceTypeList[index],index);
            }else if(index==_customerServiceTypeList.length-1){
              return _buildCurrencyTypeItem(0,20,_customerServiceTypeList[index],index);
            }
            else{
              return _buildCurrencyTypeItem(0,5,_customerServiceTypeList[index],index);
            }

          }),
      // SingleChildScrollView(
      //   scrollDirection: Axis.horizontal,
      //   child: Flex(
      //     direction: Axis.horizontal,
      //     children: [
      //       InkResponse(
      //         onTap: () {
      //           setState(() {
      //
      //             AllTextColor = Colors.white;
      //             currencyRatesTextColor = Colors.black;
      //             privacyPolicyTextColor = Colors.black;
      //             customerServiceTextColor = Colors.black;
      //             AllTabColor =novalexxa_color;
      //             currencyRatesTabColor = Colors.transparent;
      //             privacyPolicyTabColor = Colors.transparent;
      //             customerServiceTabColor = Colors.transparent;
      //             tab_status = 1;
      //
      //           });
      //         },
      //         child: Container(
      //           padding: const EdgeInsets.only(
      //               left: 25.0, right: 25.0, bottom: 12, top: 12),
      //           margin: const EdgeInsets.only(left:20.0, right: 5.0),
      //           decoration: BoxDecoration(
      //             color: AllTabColor,
      //             border: Border.all(
      //               width: 1,
      //               color: novalexxa_customer_services_tab_border_color//                   <--- border width here
      //             ),
      //             borderRadius: BorderRadius.only(
      //                 topRight: Radius.circular(40.0),
      //                 bottomRight: Radius.circular(40.0),
      //                 topLeft: Radius.circular(40.0),
      //                 bottomLeft: Radius.circular(40.0)),
      //           ),
      //           child: Text(
      //             "All",
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //                 color: AllTextColor,
      //                 fontSize: 15,
      //                 fontWeight: FontWeight.normal),
      //           ),
      //         ),
      //       ),
      //       InkResponse(
      //         onTap: () {
      //           setState(() {
      //             AllTextColor = Colors.black;
      //             currencyRatesTextColor = Colors.white;
      //             privacyPolicyTextColor = Colors.black;
      //             customerServiceTextColor = Colors.black;
      //             AllTabColor = Colors.transparent;
      //             currencyRatesTabColor =novalexxa_color;
      //             privacyPolicyTabColor = Colors.transparent;
      //             customerServiceTabColor = Colors.transparent;
      //             tab_status = 2;
      //
      //           });
      //         },
      //         child: Container(
      //           margin: const EdgeInsets.only(left: 0.0, right: 5.0),
      //           padding: const EdgeInsets.only(
      //               left: 15.0, right: 15.0, bottom: 12, top: 12),
      //           decoration: BoxDecoration(
      //             color: currencyRatesTabColor,
      //             border: Border.all(
      //                 width: 1,
      //                 color: novalexxa_customer_services_tab_border_color//                   <--- border width here
      //             ),
      //             borderRadius: BorderRadius.only(
      //                 topRight: Radius.circular(40.0),
      //                 bottomRight: Radius.circular(40.0),
      //                 topLeft: Radius.circular(40.0),
      //                 bottomLeft: Radius.circular(40.0)),
      //           ),
      //           child: Text(
      //             "Currency Rates",
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //                 color: currencyRatesTextColor,
      //                 fontSize: 15,
      //                 fontWeight: FontWeight.normal),
      //           ),
      //         ),
      //       ),
      //       InkResponse(
      //         onTap: () {
      //           setState(() {
      //             AllTextColor = Colors.black;
      //             currencyRatesTextColor = Colors.black;
      //             privacyPolicyTextColor = Colors.white;
      //             customerServiceTextColor = Colors.black;
      //             AllTabColor = Colors.transparent;
      //             currencyRatesTabColor = Colors.transparent;
      //             privacyPolicyTabColor =novalexxa_color;
      //             customerServiceTabColor = Colors.transparent;
      //             tab_status = 3;
      //
      //
      //           });
      //         },
      //         child: Container(
      //           margin: const EdgeInsets.only(left: 5.0, right: 0.0),
      //           padding: const EdgeInsets.only(
      //               left: 15.0, right: 15.0, bottom: 12, top: 12),
      //           decoration: BoxDecoration(
      //             color: privacyPolicyTabColor,
      //             border: Border.all(
      //                 width: 1,
      //                 color: novalexxa_customer_services_tab_border_color//                   <--- border width here
      //             ),
      //             borderRadius: const BorderRadius.only(
      //                 topRight: Radius.circular(40.0),
      //                 bottomRight: Radius.circular(40.0),
      //                 topLeft: Radius.circular(40.0),
      //                 bottomLeft: Radius.circular(40.0)),
      //           ),
      //           child: Text(
      //             "Privacy Policy",
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //                 color: privacyPolicyTextColor,
      //                 fontSize: 15,
      //                 fontWeight: FontWeight.normal),
      //           ),
      //         ),
      //       ),
      //       InkResponse(
      //         onTap: () {
      //           setState(() {
      //             AllTextColor = Colors.black;
      //             currencyRatesTextColor = Colors.black;
      //             privacyPolicyTextColor = Colors.black;
      //             customerServiceTextColor = Colors.white;
      //             AllTabColor = Colors.transparent;
      //             currencyRatesTabColor = Colors.transparent;
      //             privacyPolicyTabColor = Colors.transparent;
      //             customerServiceTabColor =novalexxa_color;
      //             tab_status = 4;
      //
      //           });
      //         },
      //         child: Container(
      //           margin: const EdgeInsets.only(left: 5.0, right: 20.0),
      //           padding: const EdgeInsets.only(
      //               left: 15.0, right: 15.0, bottom: 12, top: 12),
      //           decoration: BoxDecoration(
      //             color: customerServiceTabColor,
      //             border: Border.all(
      //                 width: 1,
      //                 color: novalexxa_customer_services_tab_border_color//                   <--- border width here
      //             ),
      //             borderRadius: const BorderRadius.only(
      //                 topRight: Radius.circular(40.0),
      //                 bottomRight: Radius.circular(40.0),
      //                 topLeft: Radius.circular(40.0),
      //                 bottomLeft: Radius.circular(40.0)),
      //           ),
      //           child: Text(
      //             "Customer Service",
      //             textAlign: TextAlign.center,
      //             style: TextStyle(
      //                 color: customerServiceTextColor,
      //                 fontSize: 15,
      //                 fontWeight: FontWeight.normal),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  //Currency Rates data section
  Widget _currencyRatesDataSection({required String serviceName}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 10),
              child:Text(
                serviceName,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: novalexxa_text_color,
                    height: 1.2,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.zero,

              itemCount: _customerServiceList==null||_customerServiceList.length<=0?0
                  :_customerServiceList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _buildCurrencyRatesItem1(_customerServiceList[index]);
              }),


        ],

      ),
    );
  }

  Widget _buildCurrencyRatesItem1(var responseList) {
    return ListView.builder(
        padding: EdgeInsets.zero,

        itemCount: responseList["customar_service_info"]==null||responseList["customar_service_info"].length<=0?0
            :responseList["customar_service_info"].length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _buildCurrencyRatesItem(responseList["customar_service_info"][index]);
        });
  }
  Widget _buildCurrencyRatesItem(var response) {
    return InkResponse(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerServicesDetailScreen("What it the rate currency in IT ?")));
      },
      child:Container(
        padding: const EdgeInsets.only(left: 20, top: 19, right: 20, bottom: 0),
        margin: EdgeInsets.only(
          top: 0.0,
        ),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    child: Container(
                      margin: new EdgeInsets.only(right:00),
                      child: Text(
                        response["customar_service_qustions"].toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: novalexxa_text_color,
                            height: 1.2,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(right:20),
                  child:Icon(
                    Icons.arrow_forward_ios,
                    color:novalexxa_text_color,
                    size: 19,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 0, top: 15, right: 0, bottom: 0),
              height: 1,
              color: novalexxa_customer_services_list_divider_color,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyTypeItem(double marginLeft,double marginRight,var response,int index) {
    return InkResponse(
      onTap: () {
        setState(() {

          // AllTextColor = Colors.white;
          // currencyRatesTextColor = Colors.black;
          // privacyPolicyTextColor = Colors.black;
          // customerServiceTextColor = Colors.black;
          // AllTabColor =novalexxa_color;
          // currencyRatesTabColor = Colors.transparent;
          // privacyPolicyTabColor = Colors.transparent;
          // customerServiceTabColor = Colors.transparent;
          // tab_status = 1;
          selectedTabPosition=index;
          _getCustomerServiceSingleTypeList(response["customar_service_type_id"].toString());
          _serviceTypeName=response["customar_service_type_name"].toString();

        });
      },
      child: Container(
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, bottom: 12, top: 12),
        margin:  EdgeInsets.only(left:marginLeft, right: marginRight),
        decoration: BoxDecoration(

          color:selectedTabPosition==index?novalexxa_color:Colors.transparent,
          border: Border.all(
              width: 1,
              color: novalexxa_customer_services_tab_border_color//                   <--- border width here
          ),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0)),
        ),
        child: Text(
          response["customar_service_type_name"].toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color:selectedTabPosition==index?Colors.white:Colors.black ,

             // AllTextColor,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  // //All data section
  // Widget _allTabDataSection() {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         Align(alignment: Alignment.topLeft,
  //           child: Container(
  //             padding: const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 10),
  //             child:Text(
  //               _serviceTypeName,
  //               textAlign: TextAlign.left,
  //               style: TextStyle(
  //                   color: novalexxa_text_color,
  //                   height: 1.2,
  //                   fontSize: 19,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ),
  //
  //         ListView.builder(
  //             padding: EdgeInsets.zero,
  //             itemCount: 10,
  //             shrinkWrap: true,
  //             physics: ClampingScrollPhysics(),
  //             itemBuilder: (BuildContext context, int index) {
  //               return _buildTopQuestionItem();
  //             }),
  //         // _customerServiceList
  //         Align(alignment: Alignment.topLeft,
  //           child: Container(
  //             padding: const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 10),
  //             child:Text(
  //               "All Questions",
  //               textAlign: TextAlign.left,
  //               style: TextStyle(
  //                   color: novalexxa_text_color,
  //                   height: 1.2,
  //                   fontSize: 19,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //         ),
  //         ListView.builder(
  //             padding: EdgeInsets.zero,
  //             itemCount: 10,
  //             shrinkWrap: true,
  //             physics: ClampingScrollPhysics(),
  //             itemBuilder: (BuildContext context, int index) {
  //               return _buildAllQuestionItem();
  //             }),
  //         SizedBox(height: 10,)
  //       ],
  //
  //     ),
  //   );
  // }
  //
  // Widget _buildTopQuestionItem() {
  //   return InkResponse(
  //     onTap: (){
  //       Navigator.push(context,MaterialPageRoute(builder: (context)=>
  //           CustomerServicesDetailScreen("Cras egestas leo eget augue mollis, id vulputate velit suscipit?")));
  //
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.only(left: 20, top: 19, right: 20, bottom: 0),
  //       margin: EdgeInsets.only(
  //         top: 0.0,
  //       ),
  //       child: Column(
  //         children: [
  //           Flex(
  //             direction: Axis.horizontal,
  //             children: [
  //               Expanded(
  //                   child: Container(
  //                     margin: new EdgeInsets.only(right:00),
  //                     child: Text(
  //                       "Cras egestas leo eget augue mollis, id vulputate velit suscipit?",
  //                       textAlign: TextAlign.left,
  //                       style: TextStyle(
  //                           color: novalexxa_text_color,
  //                           height: 1.2,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w500),
  //                     ),
  //                   )),
  //               Container(
  //                 margin: const EdgeInsets.only(right:20),
  //                 child:Icon(
  //                   Icons.arrow_forward_ios,
  //                   color:novalexxa_text_color,
  //                   size: 19,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Container(
  //             margin: const EdgeInsets.only(left: 0, top: 15, right: 0, bottom: 0),
  //             height: 1,
  //             color: novalexxa_customer_services_list_divider_color,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildAllQuestionItem() {
  //   return InkResponse(
  //     onTap: (){
  //       Navigator.push(context,MaterialPageRoute(builder: (context)=>CustomerServicesDetailScreen("Sed posuere purus sit amet fringilla?")));
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.only(left: 20, top: 19, right: 20, bottom: 0),
  //       margin: EdgeInsets.only(
  //         top: 0.0,
  //       ),
  //       child: Column(
  //         children: [
  //           Flex(
  //             direction: Axis.horizontal,
  //             children: [
  //               Expanded(
  //                   child: Container(
  //                     margin: new EdgeInsets.only(right:00),
  //                     child: Text(
  //                       "Sed posuere purus sit amet fringilla?",
  //                       textAlign: TextAlign.left,
  //                       style: TextStyle(
  //                           color: novalexxa_text_color,
  //                           height: 1.2,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w500),
  //                     ),
  //                   )),
  //               Container(
  //                 margin: const EdgeInsets.only(right:20),
  //                 child:Icon(
  //                   Icons.arrow_forward_ios,
  //                   color:novalexxa_text_color,
  //                   size: 19,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Container(
  //             margin: const EdgeInsets.only(left: 0, top: 15, right: 0, bottom: 0),
  //             height: 1,
  //             color: novalexxa_customer_services_list_divider_color,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget userInputSearchField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
          color:Colors.white,

          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor:intello_input_text_color,
          style: TextStyle(color:novalexxa_text_color,),
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
              // color: Colors.intello_input_text_color,
                icon: Image.asset(
                  "assets/images/search_icon.png",
                  width: 25,
                  height: 25,
                  fit: BoxFit.fill,

                ),
                onPressed: () {
                  setState(() {
                  //  searchBoxVisible=0;
                  });
                }),

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

  // _getCustomerServiceAllList() async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       // shimmerStatus=true;
  //       try {
  //         var response = await get(
  //           Uri.parse('$BASE_URL_API$SUB_URL_API_CUSTOMER_SERVICE_SINGLE_TYPE_DETAILS_LIST'),
  //         );
  //         // Navigator.of(context).pop();
  //        //  showToast(response.statusCode.toString());
  //         if (response.statusCode == 200) {
  //           setState(() {
  //           //  shimmerStatus=false;
  //             var data = jsonDecode(response.body);
  //
  //             _customerServiceTypeList = data["data"];
  //             //showToast(_notificationList.length.toString());
  //
  //
  //           });
  //         } else {
  //           Fluttertoast.cancel();
  //         }
  //       } catch (e) {
  //         Fluttertoast.cancel();
  //       }
  //     }
  //   } on SocketException catch (e) {
  //     Fluttertoast.cancel();
  //     showToast("No Internet Connection!");
  //   }
  // }

  _getCustomerServiceSingleTypeList(String typeId) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // shimmerStatus=true;
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_CUSTOMER_SERVICE_SINGLE_TYPE_DETAILS_LIST$typeId'),
          );
          // Navigator.of(context).pop();
        //  showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
            //  shimmerStatus=false;
              var data = jsonDecode(response.body);

              _customerServiceList = data["data"];
             // showToast(data["data"].length.toString());


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

  _getCustomerServiceTypeList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // shimmerStatus=true;
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$SUB_URL_API_CUSTOMER_SERVICE_TYPE_LIST'),
          );
          // Navigator.of(context).pop();
         // showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
            //  shimmerStatus=false;
              var data = jsonDecode(response.body);

              _customerServiceTypeList = data["data"];
              _getCustomerServiceSingleTypeList(_customerServiceTypeList[0]["customar_service_type_id"].toString());
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
}

