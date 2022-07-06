
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/common/money_option/send_money/send_money_message_page.dart';
import 'package:nova_lexxa/common/money_option/top_up_account/top_up_mobile_bank/top_up_account_mobile_amount_page.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api_service/api_service.dart';
import '../../../../api_service/sharePreferenceDataSaveName.dart';
import '../../../log_in/login_loading_page.dart';
import '../../../static/loding_dialog.dart';
import '../../../static/toast.dart';
import '../select_top_up.dart';


class TopUpYourAccountPageScreen extends StatefulWidget {


  @override
  State<TopUpYourAccountPageScreen> createState() => _TopUpYourAccountPageScreenState();
}

class _TopUpYourAccountPageScreenState extends State<TopUpYourAccountPageScreen> {

  _TopUpYourAccountPageScreenState();

  TextEditingController? _phoneNumberController = TextEditingController();
  String _userId = "";
  String _currencyId = "0";
  List _mobilePaymentTypeList = [];
  String _paymentMethodLogo="";
  String _paymentMethodId="";
  String _paymentMethodName="";
  String _phoneNumber="";

  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {
          _getMobilePaymentTypeList();
        });
      }
      else{
      }
    });
  }

  double _currentBalance=0.00;
  int _inputAmountGatterThanStatus=0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(

              children: [

               Expanded(child:
                Stack(
                  children: [
                    //bg
                    Container(
                      height: 185,

                      child: Image.asset(
                        "assets/images/header_bg.png",
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    //content dsign
                    Column(
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
                                  color: Colors.white,
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
                                      "Top up your account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                            ),

                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                                child: Center(

                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Mobile Money",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                            ),

                          ],
                        ),

                        SizedBox(
                          height: 110,
                        ),

                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Mobile money number",
                                style: TextStyle(
                                    color:Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400)
                            ),
                          ),
                        ),
                        Align(alignment: Alignment.topCenter,
                          child: userInputAmountField(_phoneNumberController!, 'Phone Number', TextInputType.text),
                        ),

                        Expanded(child:  Align(alignment: Alignment.bottomCenter,
                          child: InkResponse(
                            onTap: (){
                              String phoneTxt = _phoneNumberController!.text;

                              if (phoneTxt.isEmpty) {
                                Fluttertoast.cancel();
                                _showToast("phone number can't empty");
                                return;
                              }
                              if (phoneTxt.length<=8) {
                                Fluttertoast.cancel();
                                _showToast("please input valid phone number!");
                                return;
                              }
                              _phoneNumber=phoneTxt;
                              _saveNumber(
                                userId: _userId,
                                mobileNumber:_phoneNumber,
                                logo:_paymentMethodLogo,
                                paymentMethodTypeId:_paymentMethodId
                              );

                            },
                            child: _buildContinueButton(),
                          ),
                        ),)

                      ],
                    )
                  ],
                )
                )

              ],
            ),
          ),
        ],
      )
    );
  }

  Widget userInputAmountField(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(

      alignment: Alignment.center,
      margin: new EdgeInsets.only(left: 30,right: 30,top: 15),
      decoration: BoxDecoration(
          color:search_send_money_box_color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
          padding: EdgeInsets.only(left: 10.0, top: 13,bottom: 13, right: 10),
          child: Row(
            children: [

             InkWell(
               onTap: (){
                 _showAlertDialog(
                   context,_mobilePaymentTypeList
                 );

               },
               child:  ClipRRect(
                   borderRadius: BorderRadius.circular(10.0),
                   child: SizedBox(
                     height: 70,
                     width: 70,
                     child: Stack(children: <Widget>[
                       if(_paymentMethodLogo.isEmpty)...{
                         Image.asset(
                           'assets/images/empty.jpg',
                           height: 70,
                           width: 70,
                           fit: BoxFit.fill,
                         ),
                       }
                       else...{
                         FadeInImage.assetNetwork(
                           height: 70,
                           width: 70,
                           // fit: BoxFit.fill,
                           fit: BoxFit.fill,
                           placeholder: 'assets/images/empty.jpg',
                           image: _paymentMethodLogo,
                           imageErrorBuilder: (context, url, error) =>
                               Image.asset(
                                 'assets/images/empty.jpg',
                                 fit: BoxFit.fill,
                               ),
                         ),
                       }



                     ]),
                   )),
             ),

              Expanded(child:  Column(
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    controller: userInput,
                    textInputAction: TextInputAction.done,
                    autocorrect: false,
                    enableSuggestions: false,
                    cursorColor:intello_input_text_color,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    // inputFormatters: [FilteringTextInputFormatter.allow(RegExp('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$'))],
                    //
                    style: TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),

                    autofocus: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      hintText: hintTitle,
                      hintStyle:  TextStyle(fontSize: 20,
                          color:novalexxa_hint_text_color,
                          // color: Colors.intello_hint_color,
                          fontStyle: FontStyle.normal),
                    ),

                  ),
                ],
              ),),

            ],
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
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
  // Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginLoadingScreen()));

  Widget _buildContinueButton() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0)
      ),
      height: 65,
      alignment: Alignment.center,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Continue",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PT-Sans',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10,),
          Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 25.0,
          ),
        ],
      )

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

  String getCurrency(String currencyCode) {
    var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: currencyCode);
    return format.currencySymbol;
  }

  _getMobilePaymentTypeList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //  _showLoadingDialog(context, "Loading...");
        //  shimmerStatus=true;
        try {
          var response = await get(
            Uri.parse('$BASE_URL_FOR_PAYMENT$SUB_URL_API_MOBILE_PAYMENT_TYPE_LIST'),
          );

          if (response.statusCode == 200) {
            setState(() {
              // shimmerStatus=false;

              var data = jsonDecode(response.body);
              _mobilePaymentTypeList=data["data"];

              _paymentMethodId=_mobilePaymentTypeList[0]["payment_method_type_id"].toString();
              _paymentMethodName=_mobilePaymentTypeList[0]["payment_method_type_info"]["payment_type_name"].toString();
              _paymentMethodLogo=BASE_URL_FOR_PAYMENT1+_mobilePaymentTypeList[0]["payment_method_type_info"]["logo"].toString();

             // _showToast(_mobilePaymentTypeList.length.toString());
              // _currentBalance=double.parse(data["amount"].toString());
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



  _saveNumber(
      {
        required String paymentMethodTypeId,
        required String mobileNumber,
        required String userId,
        required String logo,
      }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Checking...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_MOBILE_NUMBER_SAVE_LIST'),
              body: {
                'payment_method_type_id': paymentMethodTypeId,
                'mobile_number': mobileNumber,
                'user_id': userId,
                'logo': logo,
              });
          Navigator.of(context).pop();
        //  _showToast(response.statusCode.toString());

          if (response.statusCode == 201) {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>
                  TopUpAccountMobileAmountPageScreen(paymentMethodId: _paymentMethodId,
                    phoneNumber: mobileNumber,)));

          }

          else {
            var data = jsonDecode(response.body.toString());
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


  void _showAlertDialog(BuildContext context, List _countryListData) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Container(
            // color: Colors.green,
            margin: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: Text(
                    "Select your payment method",
                    style: TextStyle(
                      fontSize: 17,
                      color: novalexxa_text_color,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                      itemCount: _countryListData == null ? 0 : _countryListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();
                              _paymentMethodId=_countryListData[index]["payment_method_type_id"].toString();
                              _paymentMethodName=_countryListData[index]["payment_method_type_info"]["payment_type_name"].toString();
                              _paymentMethodLogo=BASE_URL_FOR_PAYMENT1+_countryListData[index]["payment_method_type_info"]["logo"].toString();

                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Stack(children: <Widget>[
                                            if(_countryListData[index]["payment_method_type_info"]["logo"].toString().isEmpty)...{
                                              Image.asset(
                                                'assets/images/empty.jpg',
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.fill,
                                              ),
                                            }
                                            else...{
                                              FadeInImage.assetNetwork(
                                                height: 40,
                                                width: 40,
                                                // fit: BoxFit.fill,
                                                fit: BoxFit.fill,
                                                placeholder: 'assets/images/empty.jpg',
                                                image: BASE_URL_FOR_PAYMENT1+_countryListData[index]["payment_method_type_info"]["logo"].toString(),
                                                imageErrorBuilder: (context, url, error) =>
                                                    Image.asset(
                                                      'assets/images/empty.jpg',
                                                      fit: BoxFit.fill,
                                                    ),
                                              ),
                                            }



                                          ]),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _countryListData[index]["payment_method_type_info"]["payment_type_name"].toString(),
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        softWrap: false,
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        );
      },
    );
  }


}

