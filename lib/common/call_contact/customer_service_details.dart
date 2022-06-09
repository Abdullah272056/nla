
import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_lexxa/Particular/registration_for_particular.dart';
import 'package:nova_lexxa/common/static/Colors.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';

import 'contact_support.dart';

class CustomerServicesDetailScreen extends StatefulWidget {
  String serviceName;

  CustomerServicesDetailScreen(this.serviceName);

  @override
  State<CustomerServicesDetailScreen> createState() => _CustomerServicesDetailScreenState(this.serviceName);
}

class _CustomerServicesDetailScreenState extends State<CustomerServicesDetailScreen> with SingleTickerProviderStateMixin{

  String _serviceName;
  _CustomerServicesDetailScreenState(this._serviceName);

  String _serviceDetails="It is a long established fact that a reader will be distracted "
      "by the readable content of a page when looking at its layout. The point of using"
      " Lorem Ipsum is that it has more or less normal distribution of letters, as "
      "opposed to using 'Content here, content here', making it look like readable "
      "English.\n\nMany desktop publishing packages and web page editors now use Lorem "
      "Ipsum as their default model text, and a search for 'lorem ipsum' will uncover "
      "many web sites still in their infancy. Various versions have evolved over the "
      "years, sometimes by accident, sometimes on purpose (injected humour and the like).";



  late AnimationController controller;
  late Animation heartbeatAnimation;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: novalexxa_color,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: 50,
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Container(
                  margin: new EdgeInsets.only(left: 30),
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      margin: new EdgeInsets.only(right: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "FAQs",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child:IconButton(
                    icon: const Icon(
                      Icons.more_vert_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    color: novalexxa_text_color,
                    onPressed: () {
                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>NotificationsSettingsScreen()));

                    },
                  ),
                ),
              ],
            ),
            SizedBox(
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
            const EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 30),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 22,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          _serviceName,
                          textAlign: TextAlign.left,

                          style: TextStyle(
                              color: novalexxa_faqs_text_color,
                              fontSize: 22,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      Expanded(child: Text(
                        _serviceDetails,
                        textAlign: TextAlign.left,


                        style: TextStyle(
                            color: novalexxa_text_color,
                            fontSize: 15,
                            height: 1.5,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w400),
                      ),),


                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:  Text(
                          "Was this topic useful to you?",
                          textAlign: TextAlign.left,

                          style: TextStyle(
                              color: novalexxa_faqs_text_color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DelayedWidget(

                        delayDuration: Duration(milliseconds: 100),// Not required
                        animationDuration: Duration(milliseconds: 1000),// Not required
                        animation: DelayedAnimations.SLIDE_FROM_TOP,// Not required
                        child:Flex(direction: Axis.vertical,
                          children: [
                            Flex(direction: Axis.horizontal,
                              children: [
                                _buildYesButton(),
                                Expanded(child:  _buildNoButton())

                              ],
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),

        ));
  }


  Widget _buildNoButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 0.0),
      child: ElevatedButton(
        onPressed: () {

        Navigator.push(context,MaterialPageRoute(builder: (context)=>ContactSupportScreen()));


        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              color: novalexxa_hint_text_color,
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 45,
            alignment: Alignment.center,
            child:  Text(
              "No! I want to contact support",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildYesButton() {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: ElevatedButton(
        onPressed: () {

          //Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpForParticularScreen()));

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

            height: 45,
            alignment: Alignment.center,
            child:  Text(
              "Yes",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
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

