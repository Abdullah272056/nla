
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_lexxa/Particular/scan_doc_back_particular.dart';

import 'package:nova_lexxa/common/money_option/top_up_account/top_up_credit_card/save_card.dart';

import 'package:shared_preferences/shared_preferences.dart';


import '../../../../../api_service/api_service.dart';
import '../../../../../api_service/sharePreferenceDataSaveName.dart';

import '../../../static/Colors.dart';
import '../../../static/loding_dialog.dart';
import '../../../static/toast.dart';

import '../card input format/input_formatters.dart';
import 'payment_card.dart';



class AddCreditCardScreen extends StatefulWidget {
  String  inputBalance;
  String  currencyId;
  AddCreditCardScreen({required this.inputBalance, required this.currencyId});



  @override
  State<AddCreditCardScreen> createState() => _AddCreditCardScreenState(this.inputBalance, this.currencyId);
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  String _inputBalance;
  String _currencyId;

  _AddCreditCardScreenState(this._inputBalance, this._currencyId);

  TextEditingController? _nameOnCardController = TextEditingController();
  TextEditingController? _cardNumberController = TextEditingController();
  TextEditingController? _expiryDateController = TextEditingController();
  TextEditingController? _cvvController = TextEditingController();


  static String select_your_cvv="***";
  String _cvvName=select_your_cvv;
  String _card_number="**** **** **** ****";

  static String _cardHolderNameEmpty='-----------';
  String _card_holder_name=_cardHolderNameEmpty;
  String _card_expire_date="mm/yy";
  bool isChecked = false;

  int _cardFrontBackStatus=1;

  String cardBackText="Lorem ipsum dolor sit amet, consectetur adipiscing et sed do eiusmod tempor "
      "incididunt ut labore et dolore magnaaliqua. Ut enim ad minim veniam, quis nostrud exercitation"
      " ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute rure dolor in reprehenderit "
      "in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\nLorem ipsum dolor sit amet, occaecat cupidatat "
      "R Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt.";
  var _paymentCard = PaymentCard();
  var _paymentCardExpiryMonth;
  var _paymentCardExpirYear;
  String _userId = "";
  String _cardType = "1";
  String save_card_for_future_payment = "false";
  @override
  @mustCallSuper
  initState() {
    super.initState();
    loadUserIdFromSharePref().then((_) {
      if(_userId!=null &&!_userId.isEmpty&&_userId!=""){
        setState(() {
        //  _getSaveCardsList();
          // _getChatUserList();
        });
      }
      else{
      }
    });
  }
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
                if(_cardFrontBackStatus==1)...[
                  InkResponse(
                    onTap: (){
                      setState(() {
                        _cardFrontBackStatus=2;
                      });
                    },
                    child: _buildCardFrontSection(),
                  )

                ]
                else...[
                  InkResponse(
                    onTap: (){
                      setState(() {
                        _cardFrontBackStatus=1;
                      });
                    },
                    child: _buildCardBackSection(),
                  )

                ],

                // Container(
                //  // margin: const EdgeInsets.only(left:20, top: 00, right: 20, bottom: 00),
                //   child:   _buildCardSection(_cardFrontBackStatus),
                // ),

                //image section
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left:30, top: 00, right: 30, bottom: 00),
                    child:Column(
                      children: [
                        SizedBox(height: 20,),
                        userInputNameOnCardField(_nameOnCardController!, 'Name on Card', TextInputType.text),
                        SizedBox(height: 20,),
                        userInputCardNumberField(_cardNumberController!, 'Card Number', TextInputType.number),
                        SizedBox(height: 20,),
                        ////////////////////


                        Row(
                          children: [
                            Expanded(child:  userInputExpiryDateField(_expiryDateController!, 'Expiry Date', TextInputType.number),),
                            Expanded(child:   userInputCvv(_cvvController!, 'Cvv', TextInputType.number),),
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

  Widget userInputCvv(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
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
          maxLength: 3,
          onChanged: (text){
            setState(() {
              if(text.isEmpty){
                _cvvName=select_your_cvv;
                return;
              }
              else{
                _cvvName=text;
              }

            });
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          ],
          decoration: InputDecoration(
            // border: InputBorder.,
            counterText: "",
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
            suffixIcon:InkResponse(
              onTap: (){
                setState(() {

                  if(_cardFrontBackStatus==1){
                    _cardFrontBackStatus=2;
                  }
                  else{
                    _cardFrontBackStatus=1;
                  }

                });


               // _showToast("dfgb");
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

  Widget userInputNameOnCardField(TextEditingController userInputController, String hintTitle, TextInputType keyboardType) {
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
          maxLength: 18,

          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]"))
          ],
          onChanged: (text){
            setState(() {
              userInputController.value = userInputController.value.copyWith(text: text.toUpperCase());
              if(text.isEmpty){
                _card_holder_name=_cardHolderNameEmpty;
                return;
              }
              else{
                _card_holder_name=text.toUpperCase() ;
              }

            });
          },
          decoration: InputDecoration(
            // border: InputBorder.none,
            counterText: "",
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

  Widget userInputExpiryDateField(TextEditingController userInputController, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,

      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0,bottom: 0, right: 10),
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            new LengthLimitingTextInputFormatter(4),
            new CardMonthInputFormatter()
          ],
          controller: userInputController,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: novalexxa_text_color,
          onChanged: (value){

            setState(() {
              if(value.length<0){
                _card_expire_date=value;
                return;
              }
              _card_expire_date=value;

              List<int> expiryDate = CardUtils.getExpiryDate(value);
              _paymentCard.month = expiryDate[0];
              _paymentCardExpiryMonth=expiryDate[0];
              _paymentCardExpirYear=expiryDate[1];
              _paymentCard.year = expiryDate[1];
            });

          },
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

  Widget userInputCardNumberField(TextEditingController userInputController, String hintTitle, TextInputType keyboardType) {
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

          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CardNumberFormatter(),
          ],
          decoration: InputDecoration(
            // border: InputBorder.none,
            counterText: "",
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
          maxLength: 19,
          onChanged: (text){
            setState(() {

              if(text.isEmpty){
                _card_number="**** **** **** ****";
                return;
              }

              if(text.length==1){
                _card_number="**** **** **** ***$text";
                _card_number="$text*** **** **** ****";
                return;
              }
              if(text.length==2){
                _card_number="$text** **** **** ****";
                return;
              }
              if(text.length==3){
                _card_number="$text* **** **** ****";
                return;
              }
              if(text.length==4){
                _card_number="$text **** **** ****";
                return;
              }
              if(text.length==5){
                _card_number="$text**** **** ****";
                return;
              }
              if(text.length==6){
                _card_number="$text*** **** ****";
                return;
              }
              if(text.length==7){
                _card_number="$text** **** ****";
                return;
              }
              if(text.length==8){
                _card_number="$text* **** ****";
                return;
              }
              if(text.length==9){
                _card_number="$text **** ****";
                return;
              }
              if(text.length==10){
                _card_number="$text**** ****";
                return;
              }
              if(text.length==11){
                _card_number="$text*** ****";
                return;
              }
              if(text.length==12){
                _card_number="$text** ****";
                return;
              }
              if(text.length==13){
                _card_number="$text* ****";
                return;
              }
              if(text.length==14){
                _card_number="$text ****";
                return;
              }
              if(text.length==15){
                _card_number="$text****";
                return;
              }
              if(text.length==16){
                _card_number="$text***";
                return;
              }
              if(text.length==17){
                _card_number="$text**";
                return;
              }
              if(text.length==18){
                _card_number="$text*";
                return;
              }
              if(text.length==19){
                _card_number="$text";
                return;
              }



              // _card_number=text;
              // _cardFrontBackStatus=2;
            });
          },
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
                    if(isChecked){
                      save_card_for_future_payment="true";

                    }else{
                      save_card_for_future_payment="false";
                    }
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


  Widget _buildCardSection(int cardFrontBackStatus) {
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

            if(cardFrontBackStatus==1)...[
              Expanded(
                child:Center(
                  child:InkWell(
                    onTap: (){
                      setState(() {
                        cardFrontBackStatus==2;
                      });


                    },
                    child: _buildCardFrontSide(),
                  )
                ),
              ),
            ]
            else...[
              Expanded(
                child:Center(
                    child:InkWell(
                    onTap: (){
                      setState(() {
                        cardFrontBackStatus==1;
                      });


                    },
                    child: _buildCardBackSide(),
                    )

                ),
              ),
            ],


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

  Widget _buildCardFrontSection() {
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
                  child:_buildCardFrontSide()
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
  Widget _buildCardBackSection() {
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
                  child:_buildCardBackSide()
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

  Widget _buildCardFrontSide() {
    return Container(
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
    );
  }

  Widget _buildCardBackSide() {
    return Container(
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
               Row(
                 children: [
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Container(
                       margin: EdgeInsets.only(
                           right:10,
                           top:7,
                           left: 20,
                           bottom: 00),
                       child: Text(
                         "For Customer Service: 111 123 111",
                         textAlign:
                         TextAlign.center,
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: 8,
                             fontWeight:
                             FontWeight
                                 .w500),
                       ),
                     ),
                   ),
                 ],
               ),
               Row(
                  children: [
                    Expanded(child: Container(
                      margin: EdgeInsets.only(

                          top:5,
                          bottom: 00),
                      height:35,
                      color: Colors.black,
                    ))
                  ],
                ),
               Row(
                  children: [
                    Expanded(child: Container(
                      margin: EdgeInsets.only(
                          right:10,
                          top: 7,
                          left: 10,
                          bottom: 00
                      ),
                      padding: EdgeInsets.only(
                          right:10,

                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/cvv_bg.png'),
                          fit: BoxFit.fill,
                        ),
                      //  shape: BoxShape.circle,
                      ),
                      height: 28,
                      child:Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _cvvName,
                          //textAlign: TextAlign.center,


                          style: TextStyle(
                              color:novalexxa_text_color,
                              letterSpacing: 2.0,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500),
                        ),
                      ),

                      // color: Colors.white54,
                    ))
                  ],
                ),

               Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        right:10,
                        top: 7,
                        left: 10,
                        bottom: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        cardBackText,
                        textAlign:
                        TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 6.5,
                            fontWeight:
                            FontWeight
                                .normal),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        )

      /* add child content here */
    );
  }

  Widget _buildAddNewCardButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {
          String cardOnName=_nameOnCardController!.text;
          String cardNumber=_cardNumberController!.text;
          String cardExpiryDate=_expiryDateController!.text;
          String cardCvv=_cvvController!.text;

          if (cardOnName.isEmpty) {
            Fluttertoast.cancel();
            validation_showToast("card on name can't empty");
            return;
          }
          if (cardNumber.isEmpty) {
            Fluttertoast.cancel();
            validation_showToast("card number can't empty");
            return;
          }
          if (cardNumber.length<19) {
            Fluttertoast.cancel();
            validation_showToast("card number must be 16 digit");
            return;
          }
          if (cardExpiryDate.isEmpty) {
            Fluttertoast.cancel();
            validation_showToast("expiry date can't empty");
            return;
          }
          if (cardExpiryDate.length<5) {
            Fluttertoast.cancel();
            validation_showToast("input valid expiry date");
            return;
          }
          if (cardCvv.isEmpty) {
            Fluttertoast.cancel();
            validation_showToast("cvv can't empty");
            return;
          }
          _userNewCardSave(
            user_id: _userId,
            card_names: _cardType,
            card_number: cardNumber,
            cvv_code: cardCvv,
            expiry_date: cardExpiryDate,
            name_on_card: cardOnName,
            save_card_for_future_payment: save_card_for_future_payment,
          );

         //


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
  _userNewCardSave({
    required String user_id,
    required String card_names,
    required String name_on_card,
    required String card_number,
    required String expiry_date,
    required String cvv_code,
    required String save_card_for_future_payment,
  }) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        showLoadingDialog(context,"Creating...");
        try {
          Response response =
          await post(Uri.parse('$BASE_URL_API$SUB_URL_API_ADD_CARD_WITH_SAVE_LIST'),
              body: {
                'user_id': user_id,
                'card_names': card_names,
                'name_on_card': name_on_card,
                'card_number': card_number,
                'expiry_date': expiry_date,
                'cvv_code': cvv_code,
                'save_card_for_future_payment': save_card_for_future_payment,
              }
          );
          Navigator.of(context).pop();
         // _showToast(response.statusCode.toString());
          if (response.statusCode == 201) {
            _showToast("success");
            //var data = jsonDecode(response.body.toString());

            setState(() {
              //_showToast("success");
              var data = jsonDecode(response.body);
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SaveCardsScreen(
                  currencyId: _currencyId,
                  inputBalance: _inputBalance,
                  )));

            });
          }

          else if (response.statusCode == 400) {
            var data = jsonDecode(response.body.toString());
            _showToast(data['message']);
          }
          else {
            // var data = jsonDecode(response.body.toString());
            // _showToast(data['message']);
          }
        } catch (e) {
          Navigator.of(context).pop();
          _showToast("Try again!");
          print(e.toString());
        }
      }
    } on SocketException catch (_) {
      Fluttertoast.cancel();
      _showToast("No Internet Connection!");
    }
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


  loadUserIdFromSharePref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      setState(() {
        _userId = sharedPreferences.getString(pref_user_id)!;
        // _login_status_check = sharedPreferences.getString(pref_login_status)!;

      });
    } catch(e) {
      //code
    }

  }

}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue previousValue,
      TextEditingValue nextValue,
      ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = new StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: new TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}