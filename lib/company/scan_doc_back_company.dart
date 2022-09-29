
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:nova_lexxa/company/scan_done_company.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


import '../common/static/Colors.dart';

class ScanDocBackCompanyScreen extends StatefulWidget {
  String userId;
  ScanDocBackCompanyScreen(this.userId, {Key? key}) : super(key: key);


  @override
  State<ScanDocBackCompanyScreen> createState() => _ScanDocBackCompanyScreenState(this.userId);
}

class _ScanDocBackCompanyScreenState extends State<ScanDocBackCompanyScreen> {
  String _userId;
  _ScanDocBackCompanyScreenState(this._userId);


  String countryName="en",countryIcon="icon_country.png";
  String qrcode = 'Unknown';

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
              height: 50,
            ),

            Container(
              margin: const EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
              child:   scanMessageSection(),
            ),
            InkResponse(
              onTap: (){
                showModalBottomSheet(context: context, builder: ( (builder) =>_buildImageUploadBottomSheet()));
                // _showToast("clicked");
              },
              child: Container(
                  width: 350, // custom wrap size
                  height: 350,
                  margin: const EdgeInsets.only(left:10, top: 30, right: 10, bottom: 00),
                  child:Column(
                    children: [
                      if( imageFile==null)...{
                        Image.asset(
                          "assets/images/add_image.png",
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        ),

                      }else...{
                        Image.file(
                          imageFile!,
                          width: 300, // custom wrap size
                          height: 300,

                          fit: BoxFit.fill,
                        )
                      }

                    ],
                  )


              ),
            ),



            const SizedBox(
              height: 50,
            ),

            Container(
              child: _buildNextButton(),
            ),

            const SizedBox(height: 25,),

            Container(
              child: _buildRetryButton(),
            ),

          ],
        ),
      ),
    );
  }


  Widget scanMessageSection() {
    return Container(
      height: 110,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color:scan_text_box_color, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 0,bottom: 0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Scan Document",
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Scan the back of your document",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: novalexxa_hint_text_color,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
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
          if( imageFile==null){
            _showToast("please select document image!");
          }
          else{
            Navigator.push(context,MaterialPageRoute(builder: (context)=>ScanDoneCompanyScreen(_userId)));
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

  Widget _buildRetryButton() {
    return InkWell(
      onTap: (){
        showModalBottomSheet(context: context, builder: ( (builder) =>_buildImageUploadBottomSheet()));
      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  const Text(
          "Retry",
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

  void takeImage(ImageSource source)async{
    final pickedFile= await _picker.getImage(source: source);
    setState(() {
      _imageFile=pickedFile!;
      imageFile = File(pickedFile.path);
      //final bytes = File(_imageFile!.path).readAsBytesSync();
     // String img64 = base64Encode(bytes);

     // _imageUpload(img64);

    });
  }



  Widget _buildImageUploadBottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: [
          const Text("Choose",
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 18,
                // color: Colors.black,
              )
          ),
          const SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: TextButton.icon(     // <-- TextButton
                onPressed: () {
                  Navigator.of(context).pop();
                  takeImage(ImageSource.camera);
                },
                icon: const Icon(
                  Icons.camera,
                  size: 30.0,
                ),
                label: const Text('Camera',
                    style: TextStyle(
                      fontFamily: 'PT-Sans',
                      fontSize: 18,
                      // color: Colors.black,
                    )
                ),
              ),),
              Expanded(child: TextButton.icon(     // <-- TextButton
                onPressed: () {
                  Navigator.of(context).pop();
                  takeImage(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.image,
                  size: 30.0,
                ),
                label: const Text('Gallery',style: TextStyle(
                  fontFamily: 'PT-Sans',
                  fontSize: 18,
                  // color: Colors.black,
                ),),
              ),)




            ],
          )
        ],
      ),

    );
  }
}

