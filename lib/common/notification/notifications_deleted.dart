
import 'dart:async';

import 'package:flutter/material.dart';

import '../static/Colors.dart';
import 'no_notifications.dart';



class NotificationsDeletedScreen extends StatefulWidget {
  const NotificationsDeletedScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsDeletedScreen> createState() => _NotificationsDeletedScreenState();
}

class _NotificationsDeletedScreenState extends State<NotificationsDeletedScreen> {



  @override
  @mustCallSuper
  initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
       Navigator.push(context,MaterialPageRoute(builder: (context)=>const NoNotificationsScreen()));

      });

    });

  }

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
            const Text(
              "Notifications",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
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
                  "assets/images/notification_deleted_bg.png",
                  width: 285,
                  height: 185,
                  fit: BoxFit.fill,
                ),

                const SizedBox(
                  height: 60,
                ),

                const Text(
                  "Deleted!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 26,
                      fontWeight: FontWeight.w500),
                ),

                const SizedBox(
                  height: 23,
                ),

                Image.asset(
                  "assets/images/icon_check.png",
                  width: 65,
                  height: 65,
                  fit: BoxFit.fill,
                ),
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







}

