
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



class AddCreditCardScreen extends StatefulWidget {
  const AddCreditCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCreditCardScreen> createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {


  TextEditingController? _nameOnCardController = TextEditingController();
  TextEditingController? _cardNumberController = TextEditingController();
  TextEditingController? _expiryDatgeController = TextEditingController();
  TextEditingController? _cvvController = TextEditingController();

  String _cvvName="Cvv";
  String select_your_cvv="Cvv";

  String _card_number="5666 4239 8643 8643";
  String _card_holder_name="Simon Lewis";
  String _card_expire_date="02/20";
  bool isChecked = false;

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
                  height: 20,
                ),

                //message section
                Container(
                 // margin: const EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
                  child:   _buildCardSection(),
                ),

                //image section
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left:30, top: 00, right: 30, bottom: 00),
                    child:Column(
                      children: [
                        SizedBox(height: 20,),
                        userInputField(_nameOnCardController!, 'Name on Card', TextInputType.text),
                        SizedBox(height: 20,),
                        userInputField(_cardNumberController!, 'Card Number', TextInputType.text),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(child:  userInputField(_expiryDatgeController!, 'Expiry Date', TextInputType.text),),
                            Expanded(child:   userInputEmail(_cvvController!, 'Cvv', TextInputType.text),),
                          ],
                        ),

                        saveThisCardCheckBox()

                      ],
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

  Widget userInputEmail(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.,

            focusedBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),

            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon:InkWell(
              onTap: (){
                _showToast("dfgb");
              },
              child: Icon(
                Icons.help_rounded,
                color:hint_color,
                size: 22.0,
              ),
            ),




            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget saveThisCardCheckBox() {
    return Container(
      height: 55,
      alignment: Alignment.center,
      margin:  EdgeInsets.only(left: 0.0, right: 10.0,top: 20,bottom: 10),
      child: Padding(
        padding: EdgeInsets.only(left: 0.0, top: 0, bottom: 0, right: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [

            Theme(
              data: Theme.of(context).copyWith(
                unselectedWidgetColor:hint_color,
              ),
              child: Checkbox(
                checkColor: Colors.white,

                activeColor: novalexxa_color1,

                //fillColor: MaterialStateProperty.resolveWith(Colors.black38),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ),

            Expanded(
                child: Text("Save this card for future payments",
                    style: TextStyle(
                        color:novalexxa_text_color,
                        fontSize: 15,
                        fontWeight: FontWeight.normal))),



          ],
        ),
      ),
    );
  }
  Widget userInputField(TextEditingController userInputController, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
        child: TextField(
          controller: userInputController,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          autofocus: false,
          decoration: InputDecoration(
            // border: InputBorder.none,
            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            focusedBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: 1.0),
            ),
            enabledBorder:UnderlineInputBorder(
              borderSide:  BorderSide(color: novalexxa_hint_text_color, width: .5),
            ),

            hintText: hintTitle,
            hintStyle: const TextStyle(fontSize: 17, color: hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  Widget _buildCardSection() {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: 00, top: 30, left: 00, bottom: 10),
              height: 163,
              width: 19,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/images/card_left_side.png",
                  height: 137,
                  width: 19,
                ),
              ),
            ),

            Expanded(
              child:Center(
                child: Container(
                    margin: EdgeInsets.only(
                        right: 10, top: 30, left: 10, bottom: 10),
                    height: 163,
                    width: 316,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.50),
                          blurRadius: 20.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            2.0, // Move to right 10  horizontally
                            1.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      gradient: LinearGradient(colors: [ novalexxa_visa_card_start_color,novalexxa_visa_card_end_color,],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),

                    ),
                    child: Stack(
                      children: [

                        Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: 00,
                                        top: 00,
                                        left: 20,
                                        bottom: 00),
                                    child: Image.asset(
                                      "assets/images/logo_for_card_.png",
                                      fit: BoxFit.fill,
                                      width: 103,
                                      height: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: 20,
                                            top: 00,
                                            left: 00,
                                            bottom: 00),
                                        child: Image.asset(
                                          "assets/images/chip_for_card.png",
                                          fit: BoxFit.fill,
                                          width: 35,
                                          height: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              flex: 3,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  _card_number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontSize: 22,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: 00,
                                    top: 00,
                                    left: 00,
                                    bottom: 00),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 10,
                                                  top: 00,
                                                  left: 20,
                                                  bottom: 5),
                                              child: Text(
                                                "Card Holder Name",
                                                textAlign:
                                                TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 9,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 10,
                                                top: 00,
                                                left: 20,
                                                bottom: 00),
                                            child: Text(
                                              _card_holder_name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.5,
                                                  decoration:
                                                  TextDecoration
                                                      .none,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                        direction: Axis.vertical,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 10,
                                                  top: 00,
                                                  left: 20,
                                                  bottom: 5),
                                              child: Text(
                                                "Expiry Date",
                                                textAlign:
                                                TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 10,
                                                top: 00,
                                                left: 20,
                                                bottom: 00),
                                            child: Text(
                                              _card_expire_date,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.5,
                                                  decoration:
                                                  TextDecoration
                                                      .none,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment:
                                        Alignment.centerRight,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              right: 20,
                                              top: 00,
                                              left: 00,
                                              bottom: 00),
                                          child: Image.asset(
                                            "assets/images/visa_logo.png",
                                            fit: BoxFit.fill,
                                            width: 87,
                                            height: 27,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 3,
                            ),
                          ],
                        ),
                      ],
                    )

                  /* add child content here */
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                  right: 00, top: 30, left: 00, bottom: 10),
              height: 163,
              width: 19,
              child: Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  "assets/images/card_right_side.png",
                  height: 137,
                  width: 19,
                ),
              ),
            ),
          ],
        ),
      ],
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
          //   Navigator.push(context,MaterialPageRoute(builder: (context)=>ScanDocBackParticularScreen()));
          //   //_showToast("Ok");
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
                   "Save Card",
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

