
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../api_service/api_service.dart';
import '../common/static/loding_dialog.dart';
import '../common/static/toast.dart';
import 'company_account.dart';
import 'confirm_number_company.dart';


class AddInformationForCompanyScreen extends StatefulWidget {
  String userId;
  AddInformationForCompanyScreen(this.userId);



  @override
  State<AddInformationForCompanyScreen> createState() => _AddInformationForCompanyScreenState(this.userId);
}

class _AddInformationForCompanyScreenState extends State<AddInformationForCompanyScreen> {
  String _userId;
  _AddInformationForCompanyScreenState(this._userId);

  TextEditingController? _companyNameController = TextEditingController();
  TextEditingController? _SectorofActivitiesController = TextEditingController();
  TextEditingController? _zipCodeController = TextEditingController();
  TextEditingController? _addressController = TextEditingController();
  String _countryBirthDay="Enter Birthday";
  String select_your_country="Enter Birthday";
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
                      linearStrokeCap: LinearStrokeCap.roundAll,
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
                          "Company Info",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color:intello_easylearn_bold_text_color_,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter your company information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_hint_text_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Company Name",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 0,
                    ),
                    companyNameInput(_companyNameController!, 'Company Name', TextInputType.text,"assets/images/commpany_name_icon.png"),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Sector of Activities",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    companyNameInput(_SectorofActivitiesController!, 'Sector of Activities', TextInputType.text,"assets/images/icon_activity.png"),


                    //country
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Address",
                            style: TextStyle(
                                color:novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),
                    companyNameInput(_addressController!, 'Address', TextInputType.text,"assets/images/icon_map.png"),

                    // userInputBirthDay(_birthDayController!, 'BirthDay', TextInputType.datetime),
                    // Container( color: novalexxa_hint_text_color,
                    //   margin:  EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
                    //   height: .5,
                    // ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Zip Code",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    companyNameInput(_zipCodeController!, 'Zip Code', TextInputType.text,"assets/images/icon_zip.png"),


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
                ))

          ],
        ),
      ),
    );
  }

  Widget companyNameInput(TextEditingController controller, String hintTitle, TextInputType keyboardType,String icon_link) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: controller,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.,

            focusedBorder:UnderlineInputBorder(
              borderSide: const BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide: const BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),

            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon: Image(
              image: AssetImage(icon_link),
              height: 18,
              width: 16,
              fit: BoxFit.fill,
            ),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color:hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }



  Widget userInputBirthDay(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return InkResponse(
      onTap: (){

      },
      child: SizedBox(
        height: 52,

        child: Padding(
          padding:  EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
          child:Flex(direction: Axis.horizontal,
            children: [
              if(_countryBirthDay==select_your_country)...{
                Expanded(child: Text(_countryBirthDay,
                    style: TextStyle(
                        color: hint_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              }
              else...{
                Expanded(child: Text(_countryBirthDay,
                    style: TextStyle(
                        color:novalexxa_text_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              },
              Image.asset(
                "assets/images/icon_birthday.png",
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

  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {
          String nameTxt = _companyNameController!.text;
          String activityTxt = _SectorofActivitiesController!.text;
          String zipCodeTxt = _zipCodeController!.text;
          String addressTxt = _addressController!.text;

          if(_inputValidation(name:nameTxt,activities:activityTxt,address:addressTxt,  zipCode: zipCodeTxt )==false){
            _sendCompanyInfo(name:nameTxt,activities:activityTxt, zipCode: zipCodeTxt,address: addressTxt );
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

  _inputValidation({
    required String name,
    required String activities,
    required String address,
    required String zipCode
  }) {

    if (name.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("name can't empty");
      return;
    }

    if (activities.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("activities can't empty");
      return;
    }
    if (address.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("address can't empty");
      return;
    }
    if (zipCode.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("zipCode can't empty");
      return;
    }

    return false;
  }


  _sendCompanyInfo({
    required String name,
    required String activities,
    required String address,
    required String zipCode
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_COMPANY_INFO_CREATE'),
              body: {

                'user_id': _userId,
                'company_name': name,
                'sector_of_activities': activities,
                'company_address': address,
                'zip_code': zipCode,
              });
          Navigator.of(context).pop();
          if (response.statusCode == 201) {
            _showToast("success");
            //var data = jsonDecode(response.body.toString());

            setState(() {
              //_showToast("success");
              var data = jsonDecode(response.body);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CompanyAccountScreen(_userId)));
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


}

