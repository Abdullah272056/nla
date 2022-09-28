
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/Particular/particular_acount_information.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/common/log_in/log_in.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../api_service/api_service.dart';
import '../common/static/loding_dialog.dart';
import '../common/static/toast.dart';
import 'confirm_number_particular.dart';

class AddInformationForParticular2Screen extends StatefulWidget {
  String userId;
  AddInformationForParticular2Screen(this.userId);

  @override
  State<AddInformationForParticular2Screen> createState() => _AddInformationForParticularScreen2State(this.userId);
}

class _AddInformationForParticularScreen2State extends State<AddInformationForParticular2Screen> {
  String _userId;
  _AddInformationForParticularScreen2State(this._userId);

  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _surnameController = TextEditingController();
  TextEditingController? _birthDayController = TextEditingController();

  String _nationality="Nationality";
  String select_your__nationality="Nationality";
  String _nationalityCountryCode="IT";
  String _nationalityCountryNameId="0";


  String _placeOFBirth="Place of Birth";
  String select_your_place_of_birth="Place of Birth";
  String _placeOFBirthCountryCode="IT";
  String _placeOFBirthCountryNameId="0";


  int _particular_gender_selected_status=1;

  //String _countryCode="IT";
  String _countryCode = "IT";
  List _countryList = [];

  String _countryName="Select your country";
  String select_your_country="Select your country";
  String _countryNameId = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(
              height: 55,
            ),
            Padding(
                padding:
                const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
                child: Column(
                  children: [
                    new LinearPercentIndicator(
                      // width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 1000,
                      percent: 0.7,
                      center: Text("70%"),
                      barRadius: const Radius.circular(10),
                      fillColor:Colors.white,
                      backgroundColor: novalexxa_indicator_unselected_color,
                      progressColor: novalexxa_color,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 20.0,top: 00,left: 10),
                      child:Align(alignment: Alignment.topLeft,
                          child:Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0, 2), // changes position of shadow
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
                      margin:EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.topLeft,
                        child: Text(
                          "Personal Info",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter your personal information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_hint_text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),

                    SizedBox(
                      height: 35,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Nationality',
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

                    userInputNationality(_nameController!,),
                    Container( color: novalexxa_hint_text_color,
                      margin:  EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
                      height: .5,
                    ),

                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Place of Birth',
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


                    userInputPlaceOfBirth(_birthDayController!,),
                    Container( color: novalexxa_hint_text_color,
                      margin:  EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
                      height: .5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10,bottom: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sex',
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




                    // if(_particular_company_selected_status==1)...[
                    //   _buildParticularSelectedSection(),
                    //
                    // ]else...{
                    //   _buildCompanySelectedSection(),
                    // },

                    _buildCompanySelectedSection(),

                    Container( color: novalexxa_hint_text_color,
                      margin:  EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
                      height: .5,
                    ),

                    SizedBox(
                      height: 35,
                    ),

                    DelayedWidget(

                      delayDuration: Duration(milliseconds: 100),// Not required
                      animationDuration: Duration(milliseconds: 1000),// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child:Flex(direction: Axis.vertical,
                        children: [
                          _buildNextButton(),



                        ],
                      ),
                    )

                  ],
                )),




          ],
        ),
      ),
    );
  }


  Widget userInputNationality(TextEditingController userInput, ) {
    return InkResponse(
      onTap: (){
        _getCountryDataListForNationality();
      },
      child: Container(
        height: 52,

        child: Padding(
          padding:  EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
          child:Flex(direction: Axis.horizontal,
            children: [

              if(_nationality==select_your__nationality)...{
                Expanded(child: Text(_nationality,
                    style: TextStyle(
                        color:hint_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              }
              else...{
                Expanded(child: Text(_nationality,
                    style: TextStyle(
                        color:novalexxa_text_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              },
              Flag.fromString(_nationalityCountryCode, height: 18, width: 22, fit: BoxFit.fill)

            ],
          ),

        ),
      ),
    );
  }

  Widget userInputPlaceOfBirth(TextEditingController userInput,) {
    return InkResponse(
      onTap: (){
        _getCountryDataList();
      },
      child: Container(
        height: 52,

        child: Padding(
          padding:  EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
          child:Flex(direction: Axis.horizontal,
            children: [

              if(_placeOFBirth==select_your_place_of_birth)...{
                Expanded(child: Text(_placeOFBirth,
                    style: TextStyle(
                        color:hint_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              }
              else...{
                Expanded(child: Text(_placeOFBirth,
                    style: TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              },
              Flag.fromString(_placeOFBirthCountryCode, height: 18, width: 22, fit: BoxFit.fill)

            ],
          ),

        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {

          if(_inputValidation(nationality:_nationalityCountryNameId,
              genderId:_particular_gender_selected_status.toString(),
              placeOfBirth:_placeOFBirthCountryNameId )==false){

            _sendPersonalInfo(nationality:_nationalityCountryNameId,
                genderId:_particular_gender_selected_status.toString(),
                placeOfBirth:_placeOFBirthCountryNameId);
          }


        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
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

  // Widget _buildParticularSelectedSection() {
  //   return Container(
  //     margin: const EdgeInsets.only(left: 00.0, right: 00.0),
  //     child:Flex(
  //       direction: Axis.horizontal,
  //       children: [
  //         Container(
  //             margin:EdgeInsets.only(right:00.0,top: 00,left: 00,
  //               bottom: 10,
  //             ),
  //             child:InkResponse(
  //               onTap: (){
  //                 setState(() {
  //                   _particular_company_selected_status=2;
  //                 });
  //               },
  //               child: Image.asset(
  //                 "assets/images/female_unselected.png",
  //                 width: 35,
  //                 height: 35,
  //                 fit: BoxFit.fill,
  //               ),
  //             )
  //         ),
  //         Container(
  //           margin:EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 0),
  //           child: Align(alignment: Alignment.topLeft,
  //             child: Text(
  //               "Male",
  //               textAlign: TextAlign.center,
  //
  //               style: TextStyle(
  //                   color: novalexxa_text_color,
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.w500),
  //             ),
  //           ),
  //         ),
  //
  //
  //         Container(
  //             margin:EdgeInsets.only(right:00.0,top: 00,left: 20,
  //               bottom: 10,
  //             ),
  //             child:InkResponse(
  //               onTap: (){
  //                 setState(() {
  //                   _particular_company_selected_status=1;
  //                 });
  //
  //               },
  //               child:  Image.asset(
  //                 "assets/images/male_selected.png",
  //                 width: 35,
  //                 height: 35,
  //                 fit: BoxFit.fill,
  //               ),
  //             )
  //         ),
  //         Container(
  //           margin:EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 0),
  //           child: Align(alignment: Alignment.topLeft,
  //             child: Text(
  //               "Female",
  //               textAlign: TextAlign.center,
  //
  //               style: TextStyle(
  //                   color: novalexxa_text_color,
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.w500),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCompanySelectedSection() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child:Flex(
        direction: Axis.horizontal,
        children: [

          Container(
              margin:EdgeInsets.only(right:00.0,top: 00,left: 00,
                bottom: 10,
              ),
              child:InkResponse(
                onTap: (){
                  // _showToast("company");
                  setState(() {
                    _particular_gender_selected_status=1;
                  });

                },
                child: Image.asset(_particular_gender_selected_status==1?
                "assets/images/male_selected_icon.png":
                  "assets/images/male_unselected_icon.png",
                  //"assets/images/female_unselected.png",

                  width: 35,
                  height: 35,
                  fit: BoxFit.fill,
                ),
              )


          ),

          Container(
            margin:EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 0),
            child: Align(alignment: Alignment.topLeft,
              child: Text(
                "Male",
                textAlign: TextAlign.center,

                style: TextStyle(
                    color: novalexxa_text_color,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),

          Container(
              margin:EdgeInsets.only(right:00.0,top: 00,left: 20,
                bottom: 10,
              ),
              child: InkResponse(
                onTap: (){
                  //_showToast("particular");
                  setState(() {
                    _particular_gender_selected_status=2;
                  });

                },
                child: Image.asset(_particular_gender_selected_status==2?
                "assets/images/female_selected_icon.png":"assets/images/female_unselected.png",

                  width: 35,
                  height: 35,
                  fit: BoxFit.fill,
                ),
              )

          ),

          Container(
            margin:EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 0),
            child: Align(alignment: Alignment.topLeft,
              child: Text(
                "Female",
                textAlign: TextAlign.center,

                style: TextStyle(
                    color: novalexxa_text_color,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }


  _sendPersonalInfo({
    required String nationality,
    required String placeOfBirth,
    required String genderId,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await put(Uri.parse('$BASE_URL_API$SUB_URL_API_PERSONAL_INFO_CREATE2$_userId/'),
              body: {
                'nationalitys': nationality,
                'country_id': placeOfBirth,
                'gender': genderId,
              });
          Navigator.of(context).pop();
          if (response.statusCode == 200) {
            _showToast("success");
            //var data = jsonDecode(response.body.toString());

            setState(() {
              //_showToast("success");
              var data = jsonDecode(response.body);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ParticularAccountInformationScreen(_userId)));

            });
          }

          else {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }

        } catch (e) {
          Navigator.of(context).pop();
          _showToast("Try again!");
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
  }


  _inputValidation(
      { required String nationality,
        required String placeOfBirth,
        required String genderId,
      }) {
    if (nationality=="0") {
      Fluttertoast.cancel();
      validation_showToast("nationality can't empty");
      return;
    }
    if (placeOfBirth=="0") {
      Fluttertoast.cancel();
      validation_showToast("place of birth can't empty");
      return;
    }

    // if (genderId!="1"||genderId!="2") {
    //   Fluttertoast.cancel();
    //   validation_showToast("please select gender");
    //   return;
    // }


    return false;
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
    } on SocketException catch (e) {
      Fluttertoast.cancel();
      showToast("No Internet Connection!");
    }
  }
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
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: Text(
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
                              _placeOFBirth = _countryListData[index]['country_name'].toString();
                              _placeOFBirthCountryCode = _countryListData[index]['country_code_name']
                                  .toString();
                              _placeOFBirthCountryNameId = _countryListData[index]['country_id'].toString();

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
                                    Flag.fromString(
                                        _countryListData[index]
                                        ['country_code_name']
                                            .toString(),
                                        height: 25,
                                        width: 25),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _countryListData[index]['country_name']
                                            .toString(),
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


  _getCountryDataListForNationality() async {
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
              _showAlertDialogForNationality(context, _countryList);
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
  void _showAlertDialogForNationality(BuildContext context, List _countryListData) {
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
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 00, bottom: 10),
                  child: Text(
                    "Select your Nationality",
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

                              _nationality = _countryListData[index]['nationalitys'].toString();
                              _nationalityCountryCode = _countryListData[index]['country_code_name']
                                  .toString();
                              _nationalityCountryNameId = _countryListData[index]['country_id'].toString();

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
                                    Flag.fromString(
                                        _countryListData[index]
                                        ['country_code_name']
                                            .toString(),
                                        height: 25,
                                        width: 25),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        _countryListData[index]['nationalitys']
                                            .toString(),
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

