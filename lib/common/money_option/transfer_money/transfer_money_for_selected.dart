
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nova_lexxa/common/money_option/transfer_money/transfer_money_details_particular.dart';

import '../../static/Colors.dart';


class TransferMoneyParticularAndCompanyScreen extends StatefulWidget {
  const TransferMoneyParticularAndCompanyScreen({Key? key}) : super(key: key);

  @override
  State<TransferMoneyParticularAndCompanyScreen> createState() => _TransferMoneyParticularAndCompanyScreenState();
}

class _TransferMoneyParticularAndCompanyScreenState extends State<TransferMoneyParticularAndCompanyScreen> {

int _particular_company_selected_status=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body: SingleChildScrollView(
        child: Column(

          children: [
            const SizedBox(
              height: 55,
            ),
            Padding(
                padding:
                const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 30),
                child: Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left:00),
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: novalexxa_text_color,
                              size: 30.0,
                            ),
                          ),
                        ),

                        Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 60),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Transfer Money",
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
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      "Who would you like to transfer the money to?",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          color: novalexxa_text_color,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur do adipiscing elit, sed do eiusmod tempor.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: novalexxa_hint_text_color,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    if(_particular_company_selected_status==1)...[
                      _buildParticularSelectedSection(),

                    ]else...{
                      _buildCompanySelectedSection(),
                    },
                    const SizedBox(
                      height: 50,
                    ),

                    DelayedWidget(

                      delayDuration: const Duration(milliseconds: 100),// Not required
                      animationDuration: const Duration(milliseconds: 1000),// Not required
                      animation: DelayedAnimations.SLIDE_FROM_BOTTOM,// Not required
                      child:Flex(direction: Axis.vertical,
                        children: [
                          _buildNextButton(),

                        ],
                      ),
                    )

                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildParticularSelectedSection() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child:Stack(
        children: [
          Container(
              margin:const EdgeInsets.only(right:00.0,top: 10,left: 142,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                  setState(() {
                    _particular_company_selected_status=2;
                  });
                },
                child: Image.asset(
                  "assets/images/company_unselected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )
          ),


          Container(
              margin:const EdgeInsets.only(right:00.0,top: 10,left: 00,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                  setState(() {
                    _particular_company_selected_status=1;
                  });

                },
                child:  Image.asset(
                  "assets/images/particular_selected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )
          )
        ],
      ),
    );
  }

  Widget _buildCompanySelectedSection() {
    return Container(
      margin: const EdgeInsets.only(left: 00.0, right: 00.0),
      child:Stack(
        children: [
          Container(
              margin:const EdgeInsets.only(right:00.0,top: 10,left: 00,
                bottom: 20,
              ),
              child: InkResponse(
                onTap: (){
                  //_showToast("particular");
                  setState(() {
                    _particular_company_selected_status=1;
                  });

                },
                child: Image.asset(
                  "assets/images/particular_unselected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )

          ),
          Container(
              margin:const EdgeInsets.only(right:00.0,top: 10,left: 142,
                bottom: 20,
              ),
              child:InkResponse(
                onTap: (){
                 // _showToast("company");
                  setState(() {
                    _particular_company_selected_status=2;
                  });

                },
                child: Image.asset(
                  "assets/images/company_selected.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              )




          ),

        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ElevatedButton(
        onPressed: () {
          if(_particular_company_selected_status==1){
            Fluttertoast.cancel();
           // _showToast("1");

           Navigator.push(context,MaterialPageRoute(builder: (context)=>const TransferMoneyDetailForParticularScreen()));
          }
          else{
            Fluttertoast.cancel();
            _showToast("2");
            //Navigator.push(context,MaterialPageRoute(builder: (context)=>PrivacyPolicyForCompanyScreen()));
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
              "Proceed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 18,
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

