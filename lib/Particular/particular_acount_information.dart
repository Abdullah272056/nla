
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/Particular/scan_doc_front_particular.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../api_service/api_service.dart';
import '../common/static/loding_dialog.dart';
import '../common/static/toast.dart';


class ParticularAccountInformationScreen extends StatefulWidget {
  String userId;
  ParticularAccountInformationScreen(this.userId, {Key? key}) : super(key: key);

  @override
  State<ParticularAccountInformationScreen> createState() => _ParticularAccountInformationScreenState(this.userId);
}

class _ParticularAccountInformationScreenState extends State<ParticularAccountInformationScreen> {

  String _userId;
  _ParticularAccountInformationScreenState(this._userId);


  TextEditingController? _passwordOrNidController = TextEditingController();
  TextEditingController? _birthDayController = TextEditingController();
  TextEditingController? _countryController = TextEditingController();



  late DateTime _myDate;
  String _dateOfIssue="select date";
  String _select_your_dateOfIssue="select date";

  String _dateOfExpiry="select date";
  String _select_your_dateOfExpiry="select date";



  List _countryList = [];

  String _countryName="Select your country";
  String select_your_country="Select your country";
  String _countryCode = "BD";
 // String _placeOFBirthCountryCode="IT";
  String _countryNameId="0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body: SingleChildScrollView(
        child: Column(

          children: [
            const SizedBox(
              height: 55,
            ),
            Padding(
                padding:
                const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      // width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1000,
                      percent: 0.7,
                      center: const Text("80%"),
                      barRadius: const Radius.circular(10),
                      fillColor:Colors.white,
                      backgroundColor: novalexxa_indicator_unselected_color,
                      progressColor: novalexxa_color,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin:const EdgeInsets.only(right: 20.0,top: 00,left: 10),
                      child:Align(alignment: Alignment.topLeft,
                          child:Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.asset(
                              "assets/images/logo_icon.png",
                              width: 71,
                              height: 71,
                              fit: BoxFit.fill,
                            ),
                          )


                      ),
                    ),

                    Container(
                      margin:const EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: const Align(alignment: Alignment.topLeft,
                        child: Text(
                          "Account Info",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    Container(
                      margin:const EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: const Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter your account Information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_hint_text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Passport No or ID Card',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: novalexxa_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),

                            ],
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),


                    const SizedBox(
                      height: 0,
                    ),

                    userInputPassportNoOrIDCard(_passwordOrNidController!, 'Passport No or ID Card', TextInputType.number),

                    const SizedBox(
                      height: 20,
                    ),


                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Date of Issue',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: novalexxa_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),

                            ],
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),



                    userInputDateOfIssue(_birthDayController!, 'select date', TextInputType.datetime),
                    Container( color: novalexxa_hint_text_color,
                      margin:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
                      height: .5,
                    ),


                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Date of Expiry',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: novalexxa_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),

                            ],
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),


                    userInputDateOfExpire(_birthDayController!, 'select date', TextInputType.datetime),
                    Container( color: novalexxa_hint_text_color,
                      margin:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
                      height: .5,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Place of Issue',
                                  style: TextStyle(
                                      color: novalexxa_hint_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                      color: novalexxa_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)
                              ),

                            ],
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    userInputCountry(_countryController!, 'Country', TextInputType.text),
                    Container( color: novalexxa_hint_text_color,
                      margin:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
                      height: .6,
                    ),


                    const SizedBox(
                      height: 35,
                    ),

                    DelayedWidget(

                      delayDuration: const Duration(milliseconds: 100),// Not required
                      animationDuration: const Duration(milliseconds: 1000),// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child:Flex(direction: Axis.vertical,
                        children: [
                          _buildNextButton(),



                        ],
                      ),
                    )

                  ],
                ))

          ],
        ),
      ),
    );
  }

  ///input user passport or nid card box
  Widget userInputPassportNoOrIDCard(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return SizedBox(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.,

            focusedBorder:const UnderlineInputBorder(
              borderSide: BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:const UnderlineInputBorder(
              borderSide: BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),

            suffixIconConstraints: const BoxConstraints(
              minHeight: 12,
              minWidth: 17,
            ),
            suffixIcon: const Image(
              image: AssetImage(
                "assets/images/icon_id.png"
              ),
              height: 15,
              width: 18,
              fit: BoxFit.fill,
            ),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  ///input user country box
  Widget userInputCountry(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return InkResponse(
      onTap: (){
        _getCountryDataList();
      },
      child: SizedBox(
        height: 52,

        child: Padding(
          padding:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
          child:Flex(direction: Axis.horizontal,
            children: [
              if(_countryName==select_your_country)...{
                Expanded(child: Text(_countryName,
                    style: const TextStyle(
                        color: hint_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              }
              else...{
                Expanded(child: Text(_countryName,
                    style: const TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              },
              Flag.fromString(_countryCode, height: 18, width: 22, fit: BoxFit.fill)
            //  Flag.fromCode(FlagsCode.BD, height: 18, width: 22, fit: BoxFit.fill)
            ],
          ),

        ),
      ),
    );
  }

  ///user card Input DateOfIssue
  Widget userInputDateOfIssue(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return InkResponse(
      onTap: () async {
        _myDate = (await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ))!;

        setState(() {
          _dateOfIssue = _myDate.toString();
          _dateOfIssue = DateFormat('yyyy-MM-dd').format(_myDate);
        });

      },
      child: SizedBox(
        height: 52,

        child: Padding(
          padding:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
          child:Flex(direction: Axis.horizontal,
            children: [
              if(_dateOfIssue==_select_your_dateOfIssue)...{
                Expanded(child: Text(_dateOfIssue,
                    style: const TextStyle(
                        color: hint_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              }
              else...{
                Expanded(child: Text(_dateOfIssue,
                    style: const TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              },
              Image.asset(
                "assets/images/icon_calendar.png",
                width: 18,
                height: 18,
                fit: BoxFit.fill,
              ),
              // Flag.fromCode(FlagsCode.BD, height: 18, width: 22, fit: BoxFit.fill)
            ],
          ),

        ),
      ),
    );
  }

  ///user card Input DateOfExpire
  Widget userInputDateOfExpire(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return InkResponse(
      onTap: () async {
        _myDate = (await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ))!;

        setState(() {
          _dateOfExpiry = _myDate.toString();
          _dateOfExpiry = DateFormat('yyyy-MM-dd').format(_myDate);
        });

      },
      child: SizedBox(
        height: 52,

        child: Padding(
          padding:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
          child:Flex(direction: Axis.horizontal,
            children: [
              if(_dateOfExpiry==_select_your_dateOfExpiry)...{
                Expanded(child: Text(_dateOfExpiry,
                    style: const TextStyle(
                        color: hint_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              }
              else...{
                Expanded(child: Text(_dateOfExpiry,
                    style: const TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              },
              Image.asset(
                "assets/images/icon_calendar.png",
                width: 18,
                height: 18,
                fit: BoxFit.fill,
              ),
              // Flag.fromCode(FlagsCode.BD, height: 18, width: 22, fit: BoxFit.fill)
            ],
          ),

        ),
      ),
    );
  }

  ///next button for send account info
  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {
          String passportORNIDTxt = _passwordOrNidController!.text;
          if(_inputValidation(countryId:_countryNameId,passportNo: passportORNIDTxt,
                      dateOfExpire:_dateOfExpiry, dateOfIssue: _dateOfIssue
          )==false){


            _sendPersonalAccountInfo(country_id:_countryNameId,date_of_expiry: _dateOfExpiry,
                date_of_issue: _dateOfIssue,passport_or_nid_no: passportORNIDTxt);

          }

         // Navigator.push(context,MaterialPageRoute(builder: (context)=>ScanDocFrontParticularScreen()));

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [novalexxa_color, novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  const Text(
              "Next",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///get country list api call and receive data
  _getCountryDataList() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _showLoadingDialog(context, "Loading...");
        try {
          var response = await get(
            Uri.parse('$BASE_URL_API$GET_COUNTRY_LIST'),
          );
          Navigator.of(context).pop();
          //showToast(response.statusCode.toString());
          if (response.statusCode == 200) {
            setState(() {
              var data = jsonDecode(response.body);
              _countryList = data["data"];
              _showAlertDialog(context, _countryList);
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

  ///show all country list data with alert dialog
  void _showAlertDialog(BuildContext context, List _countryListData) {
    showDialog(
      context: context,
      builder: (context) {
        // return VerificationScreen();
        return Dialog(
          child: Container(
            // color: Colors.green,
            margin: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: const Text(
                    "Select your country",
                    style: TextStyle(
                      fontSize: 17,
                      color: novalexxa_color,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _countryList == null ? 0 : _countryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkResponse(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).pop();
                              _countryName = _countryListData[index]['country_name'].toString();
                              _countryCode = _countryListData[index]['country_code_name']
                                  .toString();
                              _countryNameId = _countryListData[index]['country_id'].toString();

                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Flag.fromString(
                                        _countryListData[index]
                                        ['country_code_name']
                                            .toString(),
                                        height: 25,
                                        width: 25),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _countryListData[index]['country_name']
                                            .toString(),
                                        style: const TextStyle(
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

  ///loading dialog
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

  ///send user personal info
  _sendPersonalAccountInfo({
    required String passport_or_nid_no,
    required String date_of_issue,
    required String date_of_expiry,
    required String country_id,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_PERSONAL_ACCOUNT_INFO_CREATE'),
              body: {
                'passport_or_nid_no': passport_or_nid_no,
                'date_of_issue': date_of_issue,
                'date_of_expiry': date_of_expiry,
                'user_id': _userId,
                'country_id': country_id,
              });
          Navigator.of(context).pop();
          if (response.statusCode == 201) {
            // _showToast("success");
            setState(() {
              //_showToast("success");

              //var data = jsonDecode(response.body);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ScanDocFrontParticularScreen(_userId)));

            });
          }

          else {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }

        } catch (e) {
          Navigator.of(context).pop();
          _showToast("Try again!");
          //print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }

  ///user input validation
  _inputValidation(
      { required String passportNo,
        required String dateOfIssue,
        required String dateOfExpire,
        required String countryId,
      }) {
    if (passportNo.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("passport or NID can't empty");
      return;
    }

    if (_dateOfIssue=="select date") {
      Fluttertoast.cancel();
      validation_showToast("date of issue can't empty");
      return;
    }
    if (_dateOfExpiry=="select date") {
      Fluttertoast.cancel();
      validation_showToast("date of expire can't empty");
      return;
    }
    if (countryId=="0") {
      Fluttertoast.cancel();
      validation_showToast("please select your country");
      return;
    }


    // if (genderId!="1"||genderId!="2") {
    //   Fluttertoast.cancel();
    //   validation_showToast("please select gender");
    //   return;
    // }


    return false;
  }

  ///create toast
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

