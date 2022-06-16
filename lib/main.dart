
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_lexxa/splash_screen/splash_screen1.dart';

import 'Particular/biometric_particular.dart';
import 'Particular/particular_information.dart';
import 'Particular/particular_information2.dart';
import 'common/log_in/finger_print_done.dart';
import 'common/log_in/finger_print_input_for_loging.dart';
import 'common/log_in/login_by_pin.dart';
import 'common/money_option/send_money/top_up_account/add_credit_cart.dart';
import 'common/money_option/send_money/top_up_account/no_credit_cart.dart';
import 'common/money_option/send_money/top_up_account/save_card.dart';
import 'common/navigation_page/money_option.dart';
import 'common/navigation_page/navigation_bar_page.dart';
import 'company/registration_for_company.dart';
import 'finger_print_auth.dart';





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
        body: AddInformationForParticularScreen("43"),
      ),
    );
  }


}