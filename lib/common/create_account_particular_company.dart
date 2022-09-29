


import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'static/Colors.dart';

class CreateAccountParticularAndCompanyScreen extends StatefulWidget {
  const CreateAccountParticularAndCompanyScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountParticularAndCompanyScreen> createState() => _CreateAccountParticularAndCompanyScreenState();
}

class _CreateAccountParticularAndCompanyScreenState extends State<CreateAccountParticularAndCompanyScreen> {
  String countryName="en",countryIcon="icon_country.png";



int _particular_company_selected_status=1;

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
                      percent: 0.1,
                      center: const Text("10%"),
                      barRadius: const Radius.circular(10),
                      fillColor:Colors.white,
                      backgroundColor: novalexxa_indicator_unselected_color,
                      progressColor: novalexxa_color,
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Create Account as",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: novalexxa_text_color,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dunt ut labore et dolore magna aliqua",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: novalexxa_hint_text_color,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    if(_particular_company_selected_status==1)...[
                      _buildParticularSelectedSection(),

                    ]else...{
                      _buildCompanySelectedSection(),
                    },
                    const SizedBox(
                      height: 50,
                    ),

                    DelayedWidget(

                      delayDuration: const Duration(milliseconds: 100),// Not required
                      animationDuration: const Duration(milliseconds: 1000),// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child:Flex(direction: Axis.vertical,
                        children: [
                          _buildNextButton(),
                          _buildHaveAnAccountButton()
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

  Widget _buildParticularSelectedSection() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child:Stack(
        children: [
          Container(
              margin:const EdgeInsets.only(right:00.0,top: 10,left: 142,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                  setState(() {
                    _particular_company_selected_status=2;
                  });
                },
                child: Image.asset(
                  "assets/images/company_unselected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )
          ),


          Container(
              margin:const EdgeInsets.only(right:00.0,top: 10,left: 00,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                  setState(() {
                    _particular_company_selected_status=1;
                  });

                },
                child:  Image.asset(
                  "assets/images/particular_selected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildCompanySelectedSection() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child:Stack(
        children: [
          Container(
              margin:const EdgeInsets.only(right:00.0,top: 10,left: 00,
                bottom: 20,
              ),
              child: InkResponse(
                onTap: (){
                  //_showToast("particular");
                  setState(() {
                    _particular_company_selected_status=1;
                  });

                },
                child: Image.asset(
                  "assets/images/particular_unselected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )

          ),
          Container(
              margin:const EdgeInsets.only(right:00.0,top: 10,left: 142,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                 // _showToast("company");
                  setState(() {
                    _particular_company_selected_status=2;
                  });

                },
                child: Image.asset(
                  "assets/images/company_selected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )




          ),

        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if(_particular_company_selected_status==1){

            Navigator.push(context,MaterialPageRoute(builder: (context)=>const PrivacyPolicyForParticularScreen()));
          }
          else{
            Navigator.push(context,MaterialPageRoute(builder: (context)=>const PrivacyPolicyForCompanyScreen()));
          }

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [novalexxa_color,novalexxa_color],
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

  Widget _buildHaveAnAccountButton() {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>const SplashScreen4()));
      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  const Text(
          "I have an Account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: novalexxa_text_color,
          ),
        ),
      ),
    );
  }


}

