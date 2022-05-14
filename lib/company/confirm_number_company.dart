
import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/splash_screen/splash_screen3.dart';

import 'message_verification_company.dart';

class ConfirmNumberForCompanyScreen extends StatefulWidget {
  const ConfirmNumberForCompanyScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmNumberForCompanyScreen> createState() => _ConfirmNumberForCompanyScreenState();
}

class _ConfirmNumberForCompanyScreenState extends State<ConfirmNumberForCompanyScreen> with SingleTickerProviderStateMixin{
  String countryName="en",countryIcon="icon_country.png";

  late AnimationController controller;
  late Animation heartbeatAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    heartbeatAnimation = Tween<double>(begin: 100.0, end: 150.0).animate(controller);
    controller.forward().whenComplete(() {
      //  controller.reverse();
    });

    /* Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.of(context).pushReplacementNamed("/dashboard");
    });
*/
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: 45,
            ),
            Expanded(child:Align(alignment: Alignment.center,
            child: DelayedWidget(

              delayDuration: Duration(milliseconds: 100),// Not required
              animationDuration: Duration(milliseconds: 400),// Not required
              animation: DelayedAnimations.SLIDE_FROM_LEFT,// Not required
              child: Wrap(
                children: [
                  Container(
                    margin:EdgeInsets.only(right: 10.0,top: 00,left: 10,bottom: 10),
                    child:Align(alignment: Alignment.center,
                      child:Image.asset(
                        "assets/images/logo_icon.png",
                        width: 140,
                        height: 140,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Align(alignment: Alignment.center,
                    child:Text(
                      "Novalexxxa",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ),
                  ),




                ],
              ),
            ),



            )

              ),

            _buildBottomDesign()

          ],
        ) /* add child content here */,
      ),
    );
  }

  Widget _buildBottomDesign() {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
            padding:
            const EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                ),
                Text(
                  "Is this your correct phone number?",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 30,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "+1 (800) 1234 567",
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: novalexxa_color,
                      fontSize: 30,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 15,
                ),



                SizedBox(
                  height: 25,
                ),

                _buildConfirmButton(),
                SizedBox(
                  height: 5,
                ),
                _buildWantChangeButton()

              ],
            )));
  }

  Widget _buildConfirmButton() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>MessageVerificationCompanyScreen()));


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
              "Yes, send code by SMS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWantChangeButton() {
    return InkWell(
      onTap: (){
        Navigator.of(context).pop();
       // Navigator.push(context,MaterialPageRoute(builder: (context)=>LogInScreen()));

      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  Text(
          "No, I want to change it",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: novalexxa_text_color,
          ),
        ),
      ),
    );
  }
  //You can create a function with your desirable animation

}
