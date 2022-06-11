
import 'dart:convert';
import 'dart:io';


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nova_lexxa/Particular/scan_doc_back_particular.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scan/scan.dart';

import '../../../static/Colors.dart';
import 'add_credit_cart.dart';


class SaveCardsScreen extends StatefulWidget {
  const SaveCardsScreen({Key? key}) : super(key: key);

  @override
  State<SaveCardsScreen> createState() => _SaveCardsScreenState();
}

class _SaveCardsScreenState extends State<SaveCardsScreen> {
  String countryName="en",countryIcon="icon_country.png";

  ScanController controller = ScanController();
  String qrcode = 'Unknown';

  //image upload
  PickedFile? _imageFile;
  final ImagePicker _picker=ImagePicker();
  String _imageLink = "";
  File? imageFile;

  String _alertMessageForSave="Many desktop publishing packages and web page editors now use Lorem Ipsum as "
      "their default model text and a search.";
  String _alertMessageForDelete="Many desktop publishing packages and web page editors now"
      " use Lorem Ipsum as their default model text and a search.";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body:Column(
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
                        "Save Cards",
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
            margin: const EdgeInsets.only(left:30, top: 00, right: 30, bottom: 00),
            child:   scanMessageSection(),
          ),

          Expanded(child: Container(
            child:  ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 3,
                shrinkWrap: true,
                // physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _buildCardListItem(index);
                }),

          ),),


          // Expanded(
          //   child:  ListView.builder(
          //     padding: EdgeInsets.zero,
          //     itemCount: 10,
          //     shrinkWrap: true,
          //     physics: ClampingScrollPhysics(),
          //     itemBuilder: (BuildContext context, int index) {
          //       return _buildNotificationItemForList(index);
          //     }),
          // ),


          Container(
            child: _buildAddNewCardButton(),
          ),

          const SizedBox(height: 25,),
        ],
      ),


    );
  }

  Widget scanMessageSection() {
    return Container(
      height: 116,
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
              "Your Saved Cards",
              textAlign: TextAlign.center,

              style: TextStyle(
                  color: novalexxa_text_color,
                  fontSize: 24,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and industry.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: novalexxa_hint_text_color,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ],

        ),
      ),
    );
  }

  Widget _buildCardListItem(int index) {
    return Container(
      margin: EdgeInsets.only(right: 30.0, top: 10, bottom: 10, left: 30),
      //width: 180,
      decoration: new BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(

            color:Colors.grey.withOpacity(.25),
            //  blurRadius: 20.0, // soften the shadow
            blurRadius:20, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            )
        )],
      ),
      child: InkResponse(
          onTap: (){
            setState(() {

              _showToast(index.toString());
            });

          },
          child: SlidableAutoCloseBehavior(
            child: Slidable(

              // Specify a key if the Slidable is dismissible.
              key: ValueKey(0),


              endActionPane:ActionPane(
                extentRatio: .5,
                motion:DrawerMotion(),
                children: [

                  SlidableAction(
                    autoClose: true,

                    padding: EdgeInsets.only(left: 10,right: 10),
                    onPressed: (BuildContext context) {

                      setState(() {
                       // _showToast(index.toString() +"Delete");
                      });

                    },
                    flex: 1,

                    backgroundColor: hide_action_bg_color,
                    foregroundColor: Colors.white,
                    icon: Icons.remove_red_eye_rounded,
                    label: 'Hide',
                  ),


                  SlidableAction(
                    autoClose: true,

                    padding: EdgeInsets.only(left: 10,right: 10),
                    onPressed: (BuildContext context) {

                      setState(() {
                        showDialog(context: context,
                            barrierDismissible:false,
                            builder: (BuildContext context){
                              return Dialog(

                                shape: RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(10.0)),
                                child:Wrap(
                                  children: [
                                    Container(
                                      padding:EdgeInsets.only(left: 18.0, right: 18.0,top: 0,bottom: 0),
                                      child: Column(

                                        children: [


                                          SizedBox(
                                            height: 45,
                                          ),

                                          Image.asset(
                                            "assets/images/information.png",
                                            height: 30,
                                            width: 30,
                                            fit: BoxFit.fill,
                                            color: novalexxa_color1,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text("Confirm card deletion ?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:novalexxa_text_color,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),

                                          Text(_alertMessageForDelete,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color:novalexxa_text_color,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(child: _buildAlertCancelButton(),),
                                              Expanded(child: _buildAlertYesDeleteButton(),),
                                            ],
                                          ),


                                          SizedBox(
                                            height: 45,
                                          ),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        );
                      });

                    },
                    flex: 1,

                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),

                    ),


                    backgroundColor: delete_action_bg_color,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_rounded,
                    label: 'Delete',
                  ),
                ],
              ),


              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child:Container(
                height: 82,
                margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 10, left: 20),
                //color: Colors.white,
                child: SizedBox(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [

                      Image.asset("assets/images/card1.png",
                        height: 34,
                        width: 50,
                        fit: BoxFit.fill,
                      ),

                      SizedBox(
                        width: 17,
                      ),
                      Expanded(child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "**** **** **** 8743",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:novalexxa_text_color,
                                  // color: Colors.intello_text_color,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              softWrap: false,
                              maxLines: 2,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),

          )


      ),
    )

    ;
  }

  Widget _buildAddNewCardButton() {
    return InkResponse(
      onTap: (){
        showDialog(context: context,
            barrierDismissible:false,
            builder: (BuildContext context){
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(10.0)),
                child:Wrap(
                  children: [
                    Container(
                      padding:EdgeInsets.only(left: 18.0, right: 18.0,top: 0,bottom: 0),
                      child: Column(

                        children: [


                          SizedBox(
                            height: 45,
                          ),

                          Image.asset(
                            "assets/images/information.png",
                            height: 30,
                            width: 30,
                            fit: BoxFit.fill,
                            color: novalexxa_color1,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("You can’t able to Add New Card",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:novalexxa_text_color,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Text(_alertMessageForSave,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color:novalexxa_text_color,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 35,
                          ),

                          _buildAlertBackButton(),
                          SizedBox(
                            height: 45,
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              );
            }
        );
      },
      child: Container(
          margin: const EdgeInsets.only(left: 50.0, right: 50.0,top: 25),
          child: DottedBorder(
            color: add_new_card_button_border_color,
            dashPattern: [6, 3],
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            strokeWidth: 1,
            child:Container(

              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [add_new_card_button_bg_color,add_new_card_button_bg_color],
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
                      color: add_new_card_button_border_color,
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
                        color: add_new_card_button_border_color,
                      ),
                    )
                  ],
                ),
              ),
            ),


          )
      ),
    );


  }


  Widget _buildAlertBackButton() {
    return InkResponse(
      onTap: (){
        // Route route = MaterialPageRoute(builder: (context) => NavigationBarScreen(2,MoneyOptionScreen()));
        // Navigator.pushReplacement(context, route);
        Navigator.of(context).pop();
      },
      child: Container(
        height: 45,
        margin: const EdgeInsets.only(left: 15.0, right: 15.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Center(
          child: Text(
            "Back",
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

    );
  }

  Widget _buildAlertYesDeleteButton() {
    return InkResponse(
      onTap: (){
        // Route route = MaterialPageRoute(builder: (context) => NavigationBarScreen(2,MoneyOptionScreen()));
        // Navigator.pushReplacement(context, route);
        Navigator.of(context).pop();
      },
      child: Container(
        height: 45,
        margin: const EdgeInsets.only(left: 10.0, right: 5.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Center(
          child: Text(
            "Yes Delete!",
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

    );
  }
  Widget _buildAlertCancelButton() {
    return InkResponse(
      onTap: (){
        // Route route = MaterialPageRoute(builder: (context) => NavigationBarScreen(2,MoneyOptionScreen()));
        // Navigator.pushReplacement(context, route);
        Navigator.of(context).pop();
      },
      child: Container(
        height: 45,
        margin: const EdgeInsets.only(left: 5.0, right:10.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Center(
          child: Text(
            "Cancel",
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

