
import 'package:flutter/material.dart';

import 'package:nova_lexxa/common/static/Colors.dart';

import '../../navigation_page/money_option.dart';
import '../../navigation_page/navigation_bar_page.dart';





class PayNFCScanScreen extends StatefulWidget {
  const PayNFCScanScreen({Key? key}) : super(key: key);

  @override
  State<PayNFCScanScreen> createState() => _PayNFCScanScreenState();
}

class _PayNFCScanScreenState extends State<PayNFCScanScreen> {

  int loging_status=1;

  @override
  @mustCallSuper
  initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child:Container(
              decoration:BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
                // color: loging_loading_bg_color,
              ),
              child:Column(

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
                            size: 25.0,
                          ),
                        ),
                      ),

                      Expanded(
                          child: Container(
                            margin: new EdgeInsets.only(right: 60),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Pay with NFC",
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

                  Row(
                    children: [
                      Expanded(child: Container(

                        decoration: BoxDecoration(
                            color: scan_text_box_color,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        padding:EdgeInsets.only(left: 30.0, right: 30.0,top: 20,bottom: 20),
                        margin:EdgeInsets.only(left: 20.0, right: 20.0,top: 50,bottom: 18),
                        child: Column(

                          children: [


                            Text("Pay with NFC",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:novalexxa_text_color,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),

                            SizedBox(
                              height: 15,
                            ),


                            Text("Move your phone closer to the terminal to make payment",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color:novalexxa_hint_text_color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),


                          ],
                        ),
                      ))
                    ],
                  ),

                  Expanded(child: Container(
                    //color:Colors.pink,
                    child: Center(
                      child:  Image.asset(
                        "assets/images/qr_nfc.png",
                        height: 260,
                        width: 280,
                        fit: BoxFit.fill,
                        ////color: Colors.white,
                      ),
                    ),
                  )),

                  Row(
                    children: [
                      Expanded(child: _buildOkButton())
                    ],
                  ),

                  SizedBox(
                    height: 50,
                  )

                ],

              ),
            ),
          ),
        ],
      )


    );


  }

  Widget _buildOkButton() {
    return InkResponse(
      onTap: (){
        Route route = MaterialPageRoute(builder: (context) => NavigationBarScreen(2,MoneyOptionScreen()));
        Navigator.pushReplacement(context, route);

      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 45.0, right: 45.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [novalexxa_color, novalexxa_color],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(7.0)
        ),
        child: Center(
          child: Text(
            "Ok",
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

}
