
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common/static/Colors.dart';
import 'create_pin_Company.dart';



class CreatePasswordCompanyScreen extends StatefulWidget {
  const CreatePasswordCompanyScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordCompanyScreen> createState() => _CreatePasswordCompanyScreenState();
}

class _CreatePasswordCompanyScreenState extends State<CreatePasswordCompanyScreen> {
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
            SizedBox(
              height: 55,
            ),
            Padding(
                padding:
                const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
                child: Column(
                  children: [
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
                      margin:EdgeInsets.only(right: 20.0,top: 10,left: 10,bottom: 0),
                      child: Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Create a password for your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: hint_color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),),
                    ),

                    SizedBox(
                      height: 50,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Confirm Password",
                            style: TextStyle(
                                color:intello_level_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    userInputPassword(_passwordController!, 'New Password', TextInputType.visiblePassword),

                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Confirm Password",
                            style: TextStyle(
                                color:intello_level_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    userInputConfirmPassword(_confirmPasswordController!, 'Confirm Password', TextInputType.visiblePassword),

                    SizedBox(
                      height: 50,
                    ),

                    _buildLogInButton()

                  ],
                ))

          ],
        ),
      ),
    );
  }


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

            focusedBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),

            suffixIconConstraints: BoxConstraints(
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
            suffixIconConstraints: BoxConstraints(
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


  Widget _buildLogInButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePinCompanyScreen()));

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
        textColor: Colors.white,
        fontSize: 16.0);
  }

}

