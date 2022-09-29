



import 'package:flutter/material.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../navigation_page/money_option.dart';
import '../../navigation_page/navigation_bar_page.dart';
import '../../static/Colors.dart';



class TransferMoneyCongratsScreen extends StatefulWidget {
  const TransferMoneyCongratsScreen({Key? key}) : super(key: key);



  @override
  State<TransferMoneyCongratsScreen> createState() => _TransferMoneyCongratsScreenState();
}

class _TransferMoneyCongratsScreenState extends State<TransferMoneyCongratsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor:Colors.white ,
      body:CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:Column(
              children: [
                Expanded(
                  child: Column(

                    children: [



                      const SizedBox(height: 60,),
                      Container(
                        margin: const EdgeInsets.only(left:20, top: 10, right: 20, bottom: 00),
                        child: LinearPercentIndicator(
                          // width: MediaQuery.of(context).size.width - 80,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 1000,
                          percent: 1,
                          center: const Text("100%"),
                          barRadius: const Radius.circular(10),
                          fillColor:Colors.white,
                          backgroundColor: novalexxa_indicator_unselected_color,
                          progressColor: novalexxa_color,
                        ),
                      ),
                      Expanded(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/undraw_wallet_aym5.png",
                            width: 240,
                            height: 160,
                            fit: BoxFit.fill,
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          const Text(
                            "Congratulations!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: congratulation_text_color,
                                fontSize: 38,
                                fontWeight: FontWeight.bold),
                          ),

                          Container(
                            margin: const EdgeInsets.only(left:30, top: 18, right: 30, bottom: 00),
                            child:const Text(
                              "Your money is on the way!",

                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  color: novalexxa_text_color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),



                          const SizedBox(
                            height: 60,
                          ),

                          Container(
                            child: _buildTransferMoreMoneyButton(),
                          ),
                          const SizedBox(height: 25,),

                        ],

                      )),


                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      )

    );
  }


  Widget _buildTransferMoreMoneyButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: ElevatedButton(
        onPressed: () {

          Route route = MaterialPageRoute(builder: (context) => NavigationBarScreen(2,const MoneyOptionScreen()));
          Navigator.pushReplacement(context, route);


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
              "Transfer More Money",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PT-Sans',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }





}

