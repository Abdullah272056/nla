
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/common/log_in.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'confirm_number_particular.dart';

class AddInformationForParticular2Screen extends StatefulWidget {
  const AddInformationForParticular2Screen({Key? key}) : super(key: key);

  @override
  State<AddInformationForParticular2Screen> createState() => _AddInformationForParticularScreen2State();
}

class _AddInformationForParticularScreen2State extends State<AddInformationForParticular2Screen> {


  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _surnameController = TextEditingController();
  TextEditingController? _birthDayController = TextEditingController();

  String _nationality="Nationality";
  String select_your__nationality="Nationality";
  FlagsCode _nationalityCountryFlagCode=FlagsCode.IT;

  String _placeOFBirth="Place of Birth";
  String select_your_place_of_birth="Place of Birth";
  FlagsCode _placeOFBirthCountryFlagCode=FlagsCode.IT;


  int _particular_company_selected_status=1;


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
                        child: Text("Nationality",
                            style: TextStyle(
                                color: novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
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
                        child: Text("Place of Birth",
                            style: TextStyle(
                                color:novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
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
                        child: Text("Sex",
                            style: TextStyle(
                                color:novalexxa_hint_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                    ),
                    if(_particular_company_selected_status==1)...[
                      _buildParticularSelectedSection(),

                    ]else...{
                      _buildCompanySelectedSection(),
                    },
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

              Flag.fromCode(_nationalityCountryFlagCode, height: 18, width: 22, fit: BoxFit.fill)
            ],
          ),

        ),
      ),
    );
  }

  Widget userInputPlaceOfBirth(TextEditingController userInput,) {
    return InkResponse(
      onTap: (){

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

              Flag.fromCode(_placeOFBirthCountryFlagCode, height: 18, width: 22, fit: BoxFit.fill)
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

  Widget _buildParticularSelectedSection() {
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
                  setState(() {
                    _particular_company_selected_status=2;
                  });
                },
                child: Image.asset(
                  "assets/images/female_unselected.png",
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
              child:InkResponse(
                onTap: (){
                  setState(() {
                    _particular_company_selected_status=1;
                  });

                },
                child:  Image.asset(
                  "assets/images/male_selected.png",
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
                    _particular_company_selected_status=2;
                  });

                },
                child: Image.asset(
                  "assets/images/female_unselected.png",

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
                    _particular_company_selected_status=1;
                  });

                },
                child: Image.asset(
                  "assets/images/male_selected.png",

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

