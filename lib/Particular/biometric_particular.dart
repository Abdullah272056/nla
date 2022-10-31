
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service/sharePreferenceDataSaveName.dart';
import '../common/static/Colors.dart';
import 'create_password_particular.dart';

class BiometricParticularScreen extends StatefulWidget {
  String userId;
  BiometricParticularScreen(this.userId);

  @override
  State<BiometricParticularScreen> createState() => _BiometricParticularScreenState(this.userId);
}

class _BiometricParticularScreenState extends State<BiometricParticularScreen> {
  String _userId;
  _BiometricParticularScreenState(this._userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body:Column(
        children: [

          Column(
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

  ///user instruction message box
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

  ///next button
  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {

          saveFingerPrintStatus('1');
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePasswordParticularScreen(_userId)));

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

  ///may be later button
  Widget _buildMayBeLaterButton() {
    return InkWell(
      onTap: (){
        saveFingerPrintStatus('');
        Navigator.push(context,MaterialPageRoute(builder: (context)=>CreatePasswordParticularScreen(_userId)));

      },
      child: Container(

        height: 50,
        alignment: Alignment.center,
        child:  const Text(
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


  void saveFingerPrintStatus(String fingerPrintStatus) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString(pref_user_finger_print_permission_status,fingerPrintStatus);

    } catch (e) {
      //code
    }
  }

}

