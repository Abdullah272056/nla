
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/static/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../api_service/api_service.dart';
import '../api_service/sharePreferenceDataSaveName.dart';


class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionDetailsScreen> createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {

  String _startDate="", _endDate="";
  final DateRangePickerController _controller = DateRangePickerController();
  String _userId = "";
  List _transactionHistoryList= [];
  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {

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
      backgroundColor:novalexxa_color1,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            fillOverscroll: true,
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
                          //_showToast(_endDate.toString());
                         // _showToast(_startDate.toString());
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
            const EdgeInsets.only(left:25, top: 0, right: 25, bottom: 15),
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

                SizedBox(height: 10,),

                Expanded(child:  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _transactionHistoryList==null||_transactionHistoryList.length<=0?0:
                    _transactionHistoryList.length,
                    // physics: NeverScrollableScrollPhysics(),

                    // physics: ClampingScrollPhysics(),
                    shrinkWrap: true,

                    itemBuilder: (BuildContext context, int index) {
                      return transactionItemDesign(_transactionHistoryList[index]);
                    }))


              ],
            )));
  }

  Widget transactionItemDesign(var response) {
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
              "-€"+response["user_amount"].toString(),
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

  _getUserTransactionHistoryList1({required String startDate, required String endDate}) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
     //   _showLoadingDialog(context, "Loading...");
        try {
          var response = await post(
              Uri.parse('$BASE_URL_API$SUB_URL_API_TRANSACTION_HISTORY_DETAILS'),
              body: {
                "user_id":_userId,
                "start_date":startDate,
                "end_date":endDate,
              }
          );
        //  Navigator.of(context).pop();
          //  showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
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

  _getUserTransactionHistoryList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await post(
              Uri.parse('$BASE_URL_API$SUB_URL_API_TRANSACTION_HISTORY_LIST'),
              body: {
                "user_id":_userId
              }
          );
          Navigator.of(context).pop();
          //  showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
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
      _startDate = DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
      _endDate = DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate).toString();
      _getUserTransactionHistoryList1(startDate:_startDate,endDate: _endDate );
     // _showToast(_endDate.toString());
    });
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

}

