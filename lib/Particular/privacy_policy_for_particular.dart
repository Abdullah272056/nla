
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:nova_lexxa/Particular/registration_for_particular.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';

class PrivacyPolicyForParticularScreen extends StatefulWidget {
  const PrivacyPolicyForParticularScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyForParticularScreen> createState() => _PrivacyPolicyForParticularScreenState();
}

class _PrivacyPolicyForParticularScreenState extends State<PrivacyPolicyForParticularScreen> with SingleTickerProviderStateMixin{
  String countryName="en",countryIcon="icon_country.png";



  late AnimationController controller;
  late Animation heartbeatAnimation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: novalexxa_color,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            const SizedBox(
              height: 50,
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),

                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 50),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Privacy Policy",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: _buildBottomDesign(),
            ),
          ],
        ),

        /* add child content here */
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
            const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 22,
                  ),
                 const Align(
                   alignment: Alignment.centerLeft,
                   child:  Text(
                     "Privacy Policy for Particular",
                     textAlign: TextAlign.left,

                     style: TextStyle(
                         color: novalexxa_color,
                         fontSize: 25,
                         decoration: TextDecoration.none,
                         fontWeight: FontWeight.w600),
                   ),
                 ),

                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehe nderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                        "\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea comm odo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nul pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                        "\n\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip."
                    ,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: novalexxa_text_color,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w400),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  DelayedWidget(

                    delayDuration: const Duration(milliseconds: 100),// Not required
                    animationDuration: const Duration(milliseconds: 1000),// Not required
                    animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
                    child:Flex(direction: Axis.vertical,
                      children: [
                        _buildAcceptButton(),
                        const SizedBox(height: 10,),
                        _buildDeclineButton()
                      ],
                    ),
                  ),

                ],
              ),
            )));
  }


  Widget _buildAcceptButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ElevatedButton(
        onPressed: () {

          Navigator.push(context,MaterialPageRoute(builder: (context)=>const SignUpForParticularScreen()));
          // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SplashScreen4()));

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
              "Accept",
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

  Widget _buildDeclineButton() {
    return InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>const SplashScreen4()));

      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  const Text(
          "Decline",
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

  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


}

