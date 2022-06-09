
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_lexxa/Particular/scan_doc_back_particular.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scan/scan.dart';

import '../../../static/Colors.dart';
import 'add_credit_cart.dart';



class NoCreditCardScreen extends StatefulWidget {
  const NoCreditCardScreen({Key? key}) : super(key: key);

  @override
  State<NoCreditCardScreen> createState() => _NoCreditCardScreenState();
}

class _NoCreditCardScreenState extends State<NoCreditCardScreen> {
  String countryName="en",countryIcon="icon_country.png";

int _particular_company_selected_status=1;
  ScanController controller = ScanController();
  String qrcode = 'Unknown';

  //image upload
  PickedFile? _imageFile;
  final ImagePicker _picker=ImagePicker();
  String _imageLink = "";
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [

                SizedBox(
                  height: 55,
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
                          color: novalexxa_text_color,
                          size: 30.0,
                        ),
                      ),
                    ),

                    Expanded(
                        child: Container(
                          margin: new EdgeInsets.only(right: 60),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Top Up Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: novalexxa_text_color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                    ),

                  ],
                ),



                SizedBox(
                  height: 50,
                ),

                //message section
                Container(
                  margin: const EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
                  child:   scanMessageSection(),
                ),

                //image section
                Expanded(
                  child: Container(
                    width: 200, // custom wrap size
                    height: 200,
                    margin: const EdgeInsets.only(left:10, top: 00, right: 10, bottom: 00),
                    child: Center(
                      child: Text("Image"),
                    ),
                  ),
                ),



                Container(
                  child: _buildAddNewCardButton(),
                ),

                const SizedBox(height: 10,),

                Container(
                  child: _buildCancelButton(),
                ),
                const SizedBox(height: 25,),
              ],
            ),
          ),
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
              "Credit Card",
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "You don't have any card save in\nyour account",
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


  Widget _buildAddNewCardButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {
          // if( imageFile==null){
          //   _showToast("please select document image!");
          // }
          // else{

          //   //_showToast("Ok");
          // }

          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddCreditCardScreen()));


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
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                 Icon(
                   Icons.add_circle,
                   color: Colors.white,
                   size: 25.0,
                 ),
                 SizedBox(width: 10,),
                 Text(
                   "Add New Card",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     fontFamily: 'PT-Sans',
                     fontSize: 18,
                     fontWeight: FontWeight.normal,
                     color: Colors.white,
                   ),
                 )
               ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return InkWell(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  Text(
          "Cancel",
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

