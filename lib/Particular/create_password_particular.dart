
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../api_service/api_service.dart';
import '../common/static/Colors.dart';
import '../common/static/loding_dialog.dart';
import '../common/static/toast.dart';
import 'create_pin_particular.dart';


class CreatePasswordParticularScreen extends StatefulWidget {
  String userId;
  CreatePasswordParticularScreen(this.userId, {Key? key}) : super(key: key);

  @override
  State<CreatePasswordParticularScreen> createState() => _CreatePasswordParticularScreenState(this.userId);
}

class _CreatePasswordParticularScreenState extends State<CreatePasswordParticularScreen> {
  String _userId;
  _CreatePasswordParticularScreenState(this._userId);

  String countryName="en",countryIcon="icon_country.png";
  TextEditingController? _confirmPasswordController = TextEditingController();
  TextEditingController? _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;

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
                          "Create Password",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color:intello_easylearn_bold_text_color_,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.only(right: 20.0,top: 10,left: 10,bottom: 0),
                      child: const Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Create a password for your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: hint_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),

                    const SizedBox(
                      height: 50,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Confirm Password",
                            style: TextStyle(
                                color:intello_level_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    userInputPassword(_passwordController!, 'New Password', TextInputType.visiblePassword),

                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Confirm Password",
                            style: TextStyle(
                                color:intello_level_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    userInputConfirmPassword(_confirmPasswordController!, 'Confirm Password', TextInputType.visiblePassword),

                    const SizedBox(
                      height: 50,
                    ),

                    _buildNextButton()

                  ],
                ))

          ],
        ),
      ),
    );
  }

  ///user password input box
  Widget userInputPassword(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return SizedBox(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.go,
          autocorrect: false,
          enableSuggestions: false,
          obscureText: _isObscure,
          cursorColor: intello_input_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.none,

            focusedBorder:const UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:const UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),

            suffixIconConstraints: const BoxConstraints(
              minHeight: 10,
              minWidth: 15,
            ),
            suffixIcon: IconButton(
                color:intello_input_text_color,
                icon: _isObscure ? Image.asset(
                  'assets/images/eye_close_icon.png',
                  width: 24, height: 12,
                  fit: BoxFit.fill,):
                Image.asset(
                  'assets/images/eye_open_icon.png',
                  width: 24,
                  height: 14,
                  fit: BoxFit.fill,),

                // Icon(_isObscure ? Image.asset(
                //   'assets/images/eye_close_icon.png',
                //   width: 24,
                //   height: 24,
                //   fit: BoxFit.fill,): Icons.visibility,
                // color: hint_color,
                // ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                }),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color:hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  ///user confirm password input box
  Widget userInputConfirmPassword(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return SizedBox(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.go,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: intello_input_text_color,
          autofocus: false,
          obscureText: _isObscure2,
          decoration: InputDecoration(
            // border: InputBorder.none,
            suffixIconConstraints: const BoxConstraints(
              minHeight: 10,
              minWidth: 15,
            ),
            suffixIcon: IconButton(
                color:intello_input_text_color,
                icon: _isObscure2 ? Image.asset(
                  'assets/images/eye_close_icon.png',
                  width: 24, height: 12,
                  fit: BoxFit.fill,):
                Image.asset(
                  'assets/images/eye_open_icon.png',
                  width: 24,
                  height: 14,
                  fit: BoxFit.fill,),
                onPressed: () {
                  setState(() {
                    _isObscure2 = !_isObscure2;
                  });
                }),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color:hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  ///next button for send user password info
  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {
          String newPasswordTxt = _passwordController!.text;
          String confirmPasswordTxt = _confirmPasswordController!.text;


          if(_inputValidation(newPassword:newPasswordTxt,confirmPassword:confirmPasswordTxt  )==false){
            _sendPasswordInfo(newPassword:newPasswordTxt,confirmPassword:confirmPasswordTxt  );
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

  ///user password data validation
  _inputValidation({
    required String newPassword,
    required String confirmPassword,
  }) {

    if (newPassword.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("new password can't empty");
      return;
    }

    if (newPassword.length<8) {
      Fluttertoast.cancel();
      validation_showToast("new password must be 8 digit");
      return;
    }

    if (confirmPassword.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("confirm password can't empty");
      return;
    }


    if (newPassword!=confirmPassword) {
      Fluttertoast.cancel();
      validation_showToast("new password and confirm password does not match");
      return;
    }

    return false;
  }

  ///send user password api call
  _sendPasswordInfo({
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Sending...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_PERSONAL_CREATE_PASSWORD'),
              body: {

                'user_id': _userId,
                'new_password': newPassword,
                'confirm_password': confirmPassword,

              });
          Navigator.of(context).pop();
          if (response.statusCode == 201) {
            _showToast("success");
            //var data = jsonDecode(response.body.toString());

            setState(() {
              //_showToast("success");
              var data = jsonDecode(response.body);

              Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePinParticularScreen(_userId)));
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

