
import 'package:delayed_widget/delayed_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_lexxa/Particular/registration_for_particular.dart';
import 'package:nova_lexxa/common/Colors.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';

class AddressMapScreen extends StatefulWidget {
  const AddressMapScreen({Key? key}) : super(key: key);

  @override
  State<AddressMapScreen> createState() => _AddressMapScreenState();
}

class _AddressMapScreenState extends State<AddressMapScreen> with SingleTickerProviderStateMixin{
  String countryName="en",countryIcon="icon_country.png";

  late AnimationController controller;
  late Animation heartbeatAnimation;
  TextEditingController? searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(
              height: 50,
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
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                ),

                Expanded(
                    child: Container(
                      margin: new EdgeInsets.only(right: 50),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add Address",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: _buildBottomDesign(),
            ),
          ],
        ),

        /* add child content here */
      ),
    );
  }

  Widget _buildBottomDesign() {
    return Container(
        //width: double.infinity,
        decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/map.png"),
            fit: BoxFit.cover,
          ),
          color:hint_color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: [


            SizedBox(
              height: 25,
            ),

            Expanded(child: Align(
              alignment: Alignment.center,
              child:Flex(direction: Axis.vertical,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: userInputEmail(searchController!, 'Selected Location', TextInputType.emailAddress),
                  ),

                  Expanded(child:Container(
                    child: Container()
                  )),
                  _buildAddAddressDetailsButton(),
                  SizedBox(height: 10,),
                  Align(alignment: Alignment.bottomCenter,
                  child: _buildUseCurrentLocationButton(),
                  ),
                  SizedBox(height: 35,),
                ],

              )


            ),)


          ],
        ));
  }


  Widget _buildAddAddressDetailsButton() {
    return Container(
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: ElevatedButton(
        onPressed: () {

          Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpForParticularScreen()));
          // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SplashScreen4()));

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [add_address_button_start_color, add_address_button_end_color],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
              "Add Address Details",
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
  Widget _buildUseCurrentLocationButton(){
    return Container(
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: ElevatedButton(
        onPressed: () {

          Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpForParticularScreen()));
          // Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: SplashScreen4()));

        },
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7))),
        child: Ink(

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7.0)
          ),
          child: Container(

            height: 50,
            alignment: Alignment.center,
            child:  Text(
              "Use Current Location",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userInputEmail(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 0,bottom: 0, right: 20),
        child: TextField(
          controller: userInput,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: false,
          cursorColor: intello_input_text_color,
          autofocus: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIconConstraints: BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            suffixIcon: Icon(
              Icons.search,
              color:hint_color,
              size: 25.0,
            ),


            // suffixIcon: Icon(Icons.email,color: Colors.hint_color,),

            hintText: hintTitle,
            hintStyle:TextStyle(fontSize: 18, color:hint_color, fontStyle: FontStyle.normal),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  //You can create a function with your desirable animation


}

