
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/navigation_page/money_option.dart';
import 'common/navigation_page/navigation_bar_page.dart';
import 'common/pay_with_qr_code/pay_with_qr_amount_page.dart';
import 'common/pay_with_qr_code/pay_with_qr_code.dart';
import 'common/qr_demo.dart';
import 'common/pay_with_qr_code/qr_invalid.dart';

void main() {
  runApp( MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
   // systemNavigationBarColor: Color(0xFF000000),
   // systemNavigationBarIconBrightness: Brightness.light,
   // systemNavigationBarDividerColor: null,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children:  [
            NavigationBarScreen(2,MoneyOptionScreen())
           // PayWithQRCodeScreen(),
          ],
        ),
      ),
    );
  }


}