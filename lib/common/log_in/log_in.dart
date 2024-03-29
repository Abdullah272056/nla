
import 'dart:convert';
import 'dart:io';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service/api_service.dart';
import '../../api_service/sharePreferenceDataSaveName.dart';
import '../create_account_particular_company.dart';
import '../navigation_page/home_page.dart';
import '../navigation_page/navigation_bar_page.dart';
import '../static/Colors.dart';

import '../static/loding_dialog.dart';
import '../static/toast.dart';
import 'finger_print_input_for_loging.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String countryName="en",countryIcon="icon_country.png";
  final TextEditingController? _emailController = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();
  String _userId = "";
  String _finger_print_permission_status = "";
  bool _isObscure = true;

  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref();
  }

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
                          "Login",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color:intello_easylearn_bold_text_color_,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.only(right: 10.0,top: 10,left: 10,bottom: 0),
                      child: const Align(alignment: Alignment.centerLeft,
                        child: Text(
                          "Login with your email address and password.",
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
                        child: Text("Email",
                            style: TextStyle(
                                color: intello_level_color,
                                fontSize: 13,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 0,
                    ),
                    userInputEmail(_emailController!, 'Email', TextInputType.emailAddress),

                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Your Password",
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
                    userInputPassword(_passwordController!, 'Password', TextInputType.visiblePassword),

                    const SizedBox(
                      height: 50,
                    ),

                    DelayedWidget(

                      delayDuration: const Duration(milliseconds: 100),// Not required
                      animationDuration: const Duration(milliseconds: 1000),// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child:Flex(direction: Axis.vertical,
                        children: [

                          Flex(direction: Axis.horizontal,
                          children: [
                            Expanded(child: _buildLogInButton(),),
                            _buildFingerPrintButton()


                          ],
                          ),
                          Container(
                            margin:  const EdgeInsets.only(left: 10, right: 15,bottom: 0,top: 25),
                            child:const Align(
                              alignment: Alignment.topLeft,
                              child: Text("Forgot Password ?",
                                  style: TextStyle(
                                      color: novalexxa_text_color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)
                              ),
                            ) ,
                          ),

                          Container(
                            margin:  const EdgeInsets.only(left: 10, right: 15,bottom: 0,top: 18),
                            child:Align(
                              alignment: Alignment.topLeft,
                              child: InkWell(
                                onTap: (){

                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const CreateAccountParticularAndCompanyScreen()));

                                },
                                child: const Text.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:"Don't have an Account?",
                                          style: TextStyle(
                                              color: novalexxa_text_color,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)
                                      ),
                                      TextSpan(
                                          text: ' Sign Up',
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


                            ) ,
                          ),



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
  ///user email input field
  Widget userInputEmail(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: intello_input_text_color,
          autofocus: false,
          decoration: InputDecoration(

           // border: InputBorder.none,
            suffixIconConstraints: const BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon: IconButton(
                color:intello_input_text_color,
                icon:  const Icon(
                  Icons.email,
                  color:hint_color,
                  size: 25.0,
                ), onPressed: () {  },


            ),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color:hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  ///user password input field
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
          cursorColor: intello_input_text_color,
          obscureText: _isObscure,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.none,
            suffixIconConstraints: const BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon: IconButton(
                color:intello_input_text_color,
                icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility,
                color: hint_color,
                ),
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

  ///log in button
  Widget _buildLogInButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {
          String emailTxt = _emailController!.text;
          String passwordTxt = _passwordController!.text;

          if(_inputValidation(email:emailTxt,Password: passwordTxt )==false){
            _userLogIn(email:emailTxt, password: passwordTxt);
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
              "Login",
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
  ///finger print button
  Widget _buildFingerPrintButton() {
    return   InkWell(
      onTap: (){
        if(_userId!=""&&_finger_print_permission_status=="1"){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>const FingerPrintInputForLoginScreen()));
        }
        else{
          _showToast("Finger print is not available at this moment!");
        }


      },
      child:Container(
        margin:  const EdgeInsets.only(left: 5, right: 15,bottom: 0,top: 0),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.25),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: const Offset(
                2.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        //   height: 150,
        child: Container(
          margin: const EdgeInsets.only(right: 10.0,top: 10,bottom: 10,left: 10),
          // height: double.infinity,
          // width: double.infinity,
          color: Colors.white,
          child: Image.asset(
            "assets/images/fingerprint_icon.png",
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
        ) ,
      )
    );

  }

  ///log api call
  _userLogIn(
        {
        required String email,
        required String password,
      }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Checking...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_LOGIN_EMAIL_PASSWORD'),
              body: {
                'username_or_email': email,
                'password': password,
              });
          Navigator.of(context).pop();
          // _showToast(response.statusCode.toString());

          if (response.statusCode == 200) {
            var data = jsonDecode(response.body.toString());

            saveUserInfo(data);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NavigationBarScreen(0,const HomePageScreen()),
              ),
                  (route) => false,
            );
          //  Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginLoadingScreen()));

          }
          else if (response.statusCode == 400) {
            var data = jsonDecode(response.body);
            _showToast(data['message']);
          }
          else if (response.statusCode == 201) {
            setState(() {
              //_showToast("success");
              var data = jsonDecode(response.body);
             // userNotActiveDialog(context,email,data['data']['id'].toString());
            });

          }
          else {
            // var data = jsonDecode(response.body.toString());
            // _showToast(data['message']);
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

  ///save data after login
  void saveUserInfo(var userInfo) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      sharedPreferences.setString(pref_user_id, userInfo['data']['id'].toString());
      sharedPreferences.setString(pref_user_uuid, userInfo['data']['uuid'].toString());
      sharedPreferences.setString(pref_user_name, userInfo['data']['name'].toString());
    } catch (e) {
      //code
    }

  }

  _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: hint_color,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  ///retrieve data from sharepref
  loadUserIdFromSharePref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        _userId = sharedPreferences.getString(pref_user_id)!;
        _finger_print_permission_status = sharedPreferences.getString(pref_user_finger_print_permission_status)!;
        // _login_status_check = sharedPreferences.getString(pref_login_status)!;

      });
    } catch(e) {
      //code
    }

  }

  ///input data validation
  _inputValidation({
    required String email,
    required String Password,
  }) {

    if (email.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("Email can't empty");
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+"
      //  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
    )
        .hasMatch(email)) {
      validation_showToast("Enter valid email");
      return;
    }

    if (Password.isEmpty) {
      Fluttertoast.cancel();
      validation_showToast("Password can't empty");
      return;
    }
    if (Password.length<8) {
      Fluttertoast.cancel();
      validation_showToast("Password must be 8 digit");
      return;
    }

    return false;
  }


}

