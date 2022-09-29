

import 'package:flutter/material.dart';
import 'package:nova_lexxa/common/static/Colors.dart';

class QRInvalidScreen extends StatefulWidget {
  const QRInvalidScreen({Key? key}) : super(key: key);


  @override
  State<QRInvalidScreen> createState() => _QRInvalidScreenState();

}

class _QRInvalidScreenState extends State<QRInvalidScreen> {

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
                const SizedBox(
                  height: 55,
                ),

                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 00),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Scan QR Code",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: novalexxa_text_color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                    ),

                  ],
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const SizedBox(height: 55,),

                      Image.asset(
                        "assets/images/no_data_pana.png",
                        width: 280,
                        height: 207,
                        fit: BoxFit.fill,
                      ),

                      Container(
                        margin: const EdgeInsets.only(left:30, top: 60, right: 30, bottom: 00),
                        child:const Text(
                          "The QR code you just scanned is not valid",

                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.5,
                              color: novalexxa_text_color,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      Container(
                        child: _buildTryAgainButton(),
                      ),

                      const SizedBox(height: 25,),

                    ],
                  ),
                )

              ],
            ),
          ),
        ],
      )

    );
  }


  Widget _buildTryAgainButton() {
    return Container(
      margin: const EdgeInsets.only(left: 50.0, right: 50.0,top: 60),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          // Route route = MaterialPageRoute(builder: (context) => NavigationBarScreen(2,MoneyOptionScreen()));
          // Navigator.pushReplacement(context, route);

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
            child:const Text(
              "TryAgain",
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

