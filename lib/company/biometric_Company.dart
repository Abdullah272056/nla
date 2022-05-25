
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_lexxa/company/privacy_policy_for_company.dart';
import 'package:nova_lexxa/Particular/privacy_policy_for_particular.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scan/scan.dart';

import '../common/Colors.dart';
import 'create_password_company.dart';


class BiometricCompanyScreen extends StatefulWidget {
  const BiometricCompanyScreen({Key? key}) : super(key: key);

  @override
  State<BiometricCompanyScreen> createState() => _BiometricCompanyScreenState();
}

class _BiometricCompanyScreenState extends State<BiometricCompanyScreen> {

  //image upload
  PickedFile? _imageFile;
  final ImagePicker _picker=ImagePicker();
  String _imageLink = "";
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body:Column(
        children: [

          Column(
            children: [
              SizedBox(
                height: 50,
              ),

              Container(
                margin: EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
                child:   LinearPercentIndicator(
                  // width: MediaQuery.of(context).size.width - 80,
                  animation: true,
                  lineHeight: 20.0,
                  animationDuration: 1000,
                  percent: 0.85,
                  center: Text("85%"),
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  fillColor:Colors.white,
                  backgroundColor: novalexxa_indicator_unselected_color,
                  progressColor: novalexxa_color,
                ),
              ),

              SizedBox(
                height: 50,
              ),

              Container(
                margin: const EdgeInsets.only(left:20, top: 00, right: 20, bottom: 0),
                child:   scanMessageSection(),
              ),

            ],
          ),


          Expanded(child: Center(
            child:  Image.asset(
              "assets/images/add_finger_print.png",
              width: 205,
              height: 205,
              fit: BoxFit.fill,
            ),
          )
         ),

          Column(
            children: [
              const SizedBox(
                height: 50,
              ),

              Container(
                child: _buildNextButton(),
              ),

              const SizedBox(height: 25,),

              Container(
                child: _buildMayBeLaterButton(),
              ),
              const SizedBox(height: 40,),
            ],
          )

        ],
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
              "Fingerprint Required",
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
              "Add your fingerprint for future connections and authorizations of payments",
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


         Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePasswordCompanyScreen()));

          // if( imageFile==null){
          //   _showToast("please select document image!");
          // }
          // else{
          //   _showToast("Ok");
          // }




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
              "Add Fingerprint",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMayBeLaterButton() {
    return InkWell(
      onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePasswordCompanyScreen()));

      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  Text(
          "Maybe Later",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 16,
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

  Widget _buildImageSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Stack(
          children: [
            InkResponse(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(65.0),
                child: Container(
                    height: 130,
                    width: 130,
                    color: Colors.black26,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/default_image.png',
                      image: _imageLink,
                      imageErrorBuilder: (context, url, error) => Image.asset(
                        'assets/images/default_image.png',
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              onTap: () {
                // if (_imageLink.isNotEmpty) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               ProfileFullScreenImage(_imageLink)));
                // }
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 90,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(context: context, builder: ( (builder) =>_buildImageUploadBottomSheet()));

                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 27,
                        ))
                  ],
                ),
              ],
            )
          ],
        ),
        // Text(
        //   _nameValue,
        //   style: const TextStyle(
        //     fontSize: 22,
        //     //fontSize: MediaQuery.of(context).size.height / 25,
        //     fontWeight: FontWeight.normal,
        //     color: Colors.white,
        //   ),
        // ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
  void takeImage(ImageSource source)async{
    final pickedFile= await _picker.getImage(source: source);
    setState(() {
      _imageFile=pickedFile!;
      imageFile = File(pickedFile.path);
      final bytes = File(_imageFile!.path).readAsBytesSync();
      String img64 = base64Encode(bytes);

     // _imageUpload(img64);

    });
  }

  _imageUpload(String image64) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   _showLoadingDialog(context,"Uploading...");
      //   try {
      //     Response response = await put(Uri.parse('$BASE_URL_API$SUB_URL_FOR_IMAGE_UPLOAD_API$_userId/'),
      //         headers: {
      //           "Authorization": "Token $_accessToken",
      //         },
      //         body: {
      //           'profile_image': image64,
      //
      //         });
      //     Navigator.of(context).pop();
      //
      //
      //     if (response.statusCode==200) {
      //       _showToast("Update Successfully");
      //       setState(() {
      //         var data = jsonDecode(response.body);
      //         _imageLink = data['data']["user_image"].toString();
      //         saveUserImage(data['data']["user_image"].toString());
      //
      //       });
      //
      //
      //     }
      //     else {
      //       _showToast("Failed! try again");
      //     }
      //
      //   } catch (e) {
      //
      //     print(e.toString());
      //
      //   }
      // }
    } on SocketException catch (e) {

    }
  }

  Widget _buildImageUploadBottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
        children: [
          Text("Choose",
              style: const TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 18,
                // color: Colors.black,
              )
          ),
          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: TextButton.icon(     // <-- TextButton
                onPressed: () {
                  Navigator.of(context).pop();
                  takeImage(ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera,
                  size: 30.0,
                ),
                label: Text('Camera',
                    style: const TextStyle(
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
                icon: Icon(
                  Icons.image,
                  size: 30.0,
                ),
                label: Text('Gallery',style: const TextStyle(
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
