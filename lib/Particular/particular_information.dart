
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/common/log_in.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'confirm_number_particular.dart';

class AddInformationForParticularScreen extends StatefulWidget {
  const AddInformationForParticularScreen({Key? key}) : super(key: key);

  @override
  State<AddInformationForParticularScreen> createState() => _AddInformationForParticularScreenState();
}

class _AddInformationForParticularScreenState extends State<AddInformationForParticularScreen> {


  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _surnameController = TextEditingController();
  TextEditingController? _birthDayController = TextEditingController();

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
                          "Personal Info",
                          textAlign: TextAlign.center,

                          style: TextStyle(
                              color: Colors.intello_easylearn_bold_text_color_,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 20.0,top: 10,left: 10,bottom: 0),
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
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Name",
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
                    userInputName(_nameController!, 'Name', TextInputType.text),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Surname",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    userInputName(_surnameController!, 'Surname', TextInputType.text),
                    //country
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Birthday",
                            style: TextStyle(
                                color:novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),

                    userInputBirthDay(_birthDayController!, 'BirthDay', TextInputType.datetime),

                    SizedBox(
                      height: 20,
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
                ))

          ],
        ),
      ),
    );
  }

  Widget userInputName(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
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
            suffixIcon:  Icon(
              Icons.person,
              color: Colors.intello_hint_color,
              size: 22.0,
            ),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: novalexxa_text_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget userInputBirthDay(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
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
            // border: InputBorder.none,
            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            focusedBorder:UnderlineInputBorder(
              borderSide: const BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide: const BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),
            suffixIcon: Icon(
              Icons.date_range_sharp,
              color: Colors.intello_hint_color,
              size: 22.0,
            ),


            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color:novalexxa_text_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget userPromoCode(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.done,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.none,
            suffixIconConstraints: BoxConstraints(
              minHeight: 12,
              minWidth: 12,
            ),
            suffixIcon: Image(
              image: AssetImage(
                "assets/images/promo_code_icon.png",

              ),

              height: 18,
              width: 18,
              fit: BoxFit.fill,
            ),
            focusedBorder:UnderlineInputBorder(
              borderSide: const BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide: const BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),
            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: novalexxa_text_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ElevatedButton(
        onPressed: () {

          //_showToast(_particular_company_selected_status.toString());
        //  Navigator.push(context,MaterialPageRoute(builder: (context)=>ConfirmNumberForParticularScreen()));
          // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SplashScreen4()));

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
        backgroundColor: Colors.intello_bd_color_dark,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}

