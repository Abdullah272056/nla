import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/Particular/particular_information.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'customer_services.dart';
import 'notification/notification.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionDetailsScreen> createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {

  late String _startDate, _endDate;
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:novalexxa_color1,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:
            Column(

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
                          size: 25.0,
                        ),
                      ),
                    ),



                    Expanded(
                        child: Container(
                          margin: new EdgeInsets.only(right: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Transaction Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                    ),

                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child:IconButton(
                        icon: const Icon(Icons.search,
                          size: 25,
                        ),
                        color:Colors.white,
                        onPressed: () {
                          _showToast(_endDate.toString());
                         // Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsSettingsScreen()));

                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  height: 290,

                  child: SfDateRangePicker(
                    view: DateRangePickerView.month,
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged:selectionChanged,
                    rangeSelectionColor: date_selection_color,
                    rangeTextStyle: const TextStyle(
                        color: Colors.white, fontSize: 15),
                    startRangeSelectionColor: Colors.blue,
                    endRangeSelectionColor: Colors.blue,

                    // selectionColor: Colors.blue,
                    monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                  ),
                ),

                const SizedBox(
                  height: 21,
                ),

                Expanded(child: _buildBottomDesign())



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

        ),

        child: Padding(
            padding:
            const EdgeInsets.only(left:25, top: 0, right: 25, bottom: 30),
            child: Column(
              children: [
                Container(
                  height: 31,
                  width: 149,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/drop_shape.png',
                      ),
                      fit: BoxFit.fill,
                    ),

                  ),

                 child: Center(
                   child: RotatedBox(
                       quarterTurns: 1,
                       child: Icon(
                         Icons.arrow_forward_ios_rounded,
                         color: Colors.white,
                         size: 18.0,
                       ),
                   ),


                 ),


                ),



                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
                transactionItemDesign(),
              ],
            )));
  }

  Widget transactionItemDesign() {
    return Padding(padding: EdgeInsets.only(right:00,top: 10,left: 00,bottom: 10),
    child:  Row(
      children: [

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
            Align(
              alignment: Alignment.centerLeft,
              child:Text(
                "Tech Italy",
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
            "-€12",
            style: TextStyle(
                color: novalexxa_text_color,
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

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _startDate = DateFormat('yyyy-MMM-dd').format(args.value.startDate).toString();
      _endDate = DateFormat('yyyy-MMM-dd').format(args.value.endDate ?? args.value.startDate).toString();
     // _showToast(_endDate.toString());
    });
  }


}

