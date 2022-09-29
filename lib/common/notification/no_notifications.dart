
import 'dart:io';

import 'package:flutter/material.dart';
import '../static/Colors.dart';

import 'notifications_settings.dart';


class NoNotificationsScreen extends StatefulWidget {
  const NoNotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NoNotificationsScreen> createState() => _NoNotificationsScreenState();
}

class _NoNotificationsScreenState extends State<NoNotificationsScreen> {

  //image upload
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white,
      body:Center(
        child: Column(

          children: [

            const SizedBox(
              height: 55,
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
                      color: novalexxa_text_color,
                      size: 27.0,
                    ),
                  ),
                ),

                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Notifications",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: novalexxa_text_color,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                ),

                Container(
                  margin: const EdgeInsets.only(right: 30),
                  child:IconButton(
                    icon: const Icon(Icons.settings,
                      size: 25,
                    ),
                    color: novalexxa_text_color,
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>const NotificationsSettingsScreen()));

                    },
                  ),
                ),
              ],
            ),

            Expanded(child:

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 130,
                // ),

                Image.asset(
                  "assets/images/no_notification.png",
                  width: 285,
                  height: 185,
                  fit: BoxFit.fill,
                ),

                const SizedBox(
                  height: 60,
                ),

                const Text(
                  "You dont have any\nNotification !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      height: 1.5,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),


                _buildNotificationsSettingsButton(),
                const SizedBox(
                  height: 60,
                ),
              ],
            ))


          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSettingsButton() {
    return InkResponse(
      onTap: (){

       // Navigator.push(context,MaterialPageRoute(builder: (context)=>NavigationBarScreen(0,HomePageScreen())));
      },
      child:  Container(
        margin:  const EdgeInsets.only(left: 10, right: 10,bottom: 0,top: 45),
        //width: 80,
        height: 45,
        width: 280,
        decoration: BoxDecoration(
          color: novalexxa_color,
          borderRadius: BorderRadius.circular(10),

        ),
        //   height: 150,
        child: Center(
          child: Wrap(direction: Axis.horizontal,
              children: const [
                Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 20.0,
                ),
                SizedBox(width: 11,),
                Text(
                  "Notifications Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PT-Sans',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
          ),


        ),
      ),
    );


  }



}

