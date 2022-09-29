

import 'dart:io';


import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';


import '../common/static/Colors.dart';
import 'biometric_particular.dart';

class ScanDoneParticularScreen extends StatefulWidget {
  String userId;
  ScanDoneParticularScreen(this.userId, {Key? key}) : super(key: key);

  @override
  State<ScanDoneParticularScreen> createState() => _ScanDoneParticularScreenState(this.userId);
}

class _ScanDoneParticularScreenState extends State<ScanDoneParticularScreen> {
  String _userId;
  _ScanDoneParticularScreenState(this._userId);
  //image upload
  PickedFile? _imageFile;
  final ImagePicker _picker=ImagePicker();

  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body:SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(
              height: 50,
            ),

            Container(
              margin: const EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
              child:   LinearPercentIndicator(
                // width: MediaQuery.of(context).size.width - 80,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 1000,
                percent: 0.85,
                center: const Text("85%"),
                barRadius: const Radius.circular(10),
                fillColor:Colors.white,
                backgroundColor: novalexxa_indicator_unselected_color,
                progressColor: novalexxa_color,
              ),
            ),

            const SizedBox(
              height: 110,
            ),

            Image.asset(
              "assets/images/scan_doc_done.png",
              width: 210,
              height: 250,
              fit: BoxFit.fill,
            ),

            const SizedBox(
              height: 27,
            ),

            const Text(
              "Done",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 38,
                  fontWeight: FontWeight.bold),
            ),

            Container(
              margin: const EdgeInsets.only(left:20, top: 18, right: 20, bottom: 00),
              child:const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dunt ut labore et dolore magna aliqua.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: novalexxa_hint_text_color,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),


            const SizedBox(
              height: 63,
            ),

            Container(
              child: _buildNextButton(),
            ),


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

         Navigator.push(context,MaterialPageRoute(builder: (context)=>BiometricParticularScreen(_userId)));

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





  void takeImage(ImageSource source)async{
    final pickedFile= await _picker.getImage(source: source);
    setState(() {
      _imageFile=pickedFile!;
      imageFile = File(pickedFile.path);
      final bytes = File(_imageFile!.path).readAsBytesSync();
     // String img64 = base64Encode(bytes);

     // _imageUpload(img64);

    });
  }

}

