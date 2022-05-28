
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../common/Colors.dart';


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


  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {

        // Navigator.push(context,MaterialPageRoute(builder: (context)=>BiometricParticularScreen()));

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [novalexxa_color,novalexxa_color],
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
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }



}

