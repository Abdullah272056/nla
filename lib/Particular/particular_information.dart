
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nova_lexxa/Particular/particular_information2.dart';
import 'package:nova_lexxa/common/static/Colors.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

import '../api_service/api_service.dart';
import '../common/static/loding_dialog.dart';
import '../common/static/toast.dart';

class AddInformationForParticularScreen extends StatefulWidget {
  String userId;
  AddInformationForParticularScreen(this.userId);

  @override
  State<AddInformationForParticularScreen> createState() => _AddInformationForParticularScreenState(this.userId);
}

class _AddInformationForParticularScreenState extends State<AddInformationForParticularScreen> {
  String _userId;
  _AddInformationForParticularScreenState(this._userId);

  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _surnameController = TextEditingController();
  TextEditingController? _birthDayController = TextEditingController();
  String _particularBirthDate="Enter Birthday";
  String select_your_country="Enter Birthday";

  late DateTime _myDate;


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
                      center: const Text("70%"),
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
                      margin:const EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: const Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Enter your personal information",
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
                                  text: 'Name',
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
                    userInputName(_nameController!, 'Name', TextInputType.text),

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
                                  text: 'Surname',
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


                    userInputName(_surnameController!, 'Surname', TextInputType.text),
                    //country
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
                                  text: 'Birthday',
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
                      height: 10,
                    ),


                    userInputBirthDay(_birthDayController!, 'BirthDay', TextInputType.datetime),
                    Container( color: novalexxa_hint_text_color,
                      margin:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
                      height: .5,
                    ),
                    const SizedBox(
                      height: 20,
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

  Widget userInputName(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
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
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon: const Image(
              image: AssetImage(
                "assets/images/icon_user.png"
              ),
              height: 18,
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

  Widget userInputBirthDay(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return InkResponse(
      onTap: () async {
        _myDate = (await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        ))!;

        setState(() {
          _particularBirthDate = _myDate.toString();
          _particularBirthDate = DateFormat('yyyy-MM-dd').format(_myDate);
        });

      },
      child: SizedBox(
        height: 52,

        child: Padding(
          padding:  const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
          child:Flex(direction: Axis.horizontal,
            children: [
              if(_particularBirthDate==select_your_country)...{
                Expanded(child: Text(_particularBirthDate,
                    style: const TextStyle(
                        color: hint_color,
                        fontSize: 18,
                        fontWeight: FontWeight.normal)
                )),
              }
              else...{
                Expanded(child: Text(_particularBirthDate,
                    style: const TextStyle(
                        color: novalexxa_text_color,
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

          String nameTxt = _nameController!.text;
          String surNameTxt = _surnameController!.text;


          if(_inputValidation(name: nameTxt,surname: surNameTxt,birthday: _particularBirthDate)==false){
            _sendPersonalInfo(name:nameTxt,surname: surNameTxt,birthday: _particularBirthDate );
           // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddInformationForParticular2Screen()));

          }


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


  _inputValidation(
      { required String name,
        required String surname,
        required String birthday,
       }) {
    if (name.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("name can't empty");
      return;
    }
    if (surname.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("surname can't empty");
      return;
    }

    if (birthday.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("birth date can't empty");
      return;
    }
    if (birthday==select_your_country) {
       Fluttertoast.cancel();
       validation_showToast("birth date can't empty");
       return;
    }


    return false;
  }

  _sendPersonalInfo({
    required String name,
    required String surname,
    required String birthday,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await put(Uri.parse('$BASE_URL_API$SUB_URL_API_PERSONAL_INFO_CREATE$_userId/'),
              body: {
                'name': name,
                'surname': surname,
                'birthday': birthday,
              });
          Navigator.of(context).pop();
          if (response.statusCode == 200) {
            _showToast("success");
            //var data = jsonDecode(response.body.toString());

            setState(() {
              //_showToast("success");
             // var data = jsonDecode(response.body);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>AddInformationForParticular2Screen(_userId)));

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

