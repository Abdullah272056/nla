
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../static/Colors.dart';
import 'no_notifications.dart';



class NotificationsDeletedScreen extends StatefulWidget {
  const NotificationsDeletedScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsDeletedScreen> createState() => _NotificationsDeletedScreenState();
}

class _NotificationsDeletedScreenState extends State<NotificationsDeletedScreen> {

  //image upload
  PickedFile? _imageFile;
  final ImagePicker _picker=ImagePicker();
  String _imageLink = "";
  File? imageFile;

  @override
  @mustCallSuper
  initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
       Navigator.push(context,MaterialPageRoute(builder: (context)=>NoNotificationsScreen()));

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

            SizedBox(
              height: 55,
            ),
            Text(
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

                SizedBox(
                  height: 60,
                ),

                Text(
                  "Deleted!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: novalexxa_text_color,
                      fontSize: 26,
                      fontWeight: FontWeight.w500),
                ),

                SizedBox(
                  height: 23,
                ),

                Image.asset(
                  "assets/images/icon_check.png",
                  width: 65,
                  height: 65,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ))


          ],
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
        textColor: Colors.black,
        fontSize: 16.0);
  }



}

