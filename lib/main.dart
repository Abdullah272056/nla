
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_lexxa/splash_screen/splash_screen1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:nova_lexxa/splash_screen/splash_screen2.dart';
import 'package:nova_lexxa/splash_screen/splash_screen4.dart';

import 'Particular/biometric_particular.dart';
import 'Particular/create_confirm_pin_particular.dart';
import 'Particular/create_pin_particular.dart';
import 'Particular/email_verification_particular.dart';
import 'Particular/message_verification_particular.dart';
import 'Particular/particular_acount_information.dart';
import 'Particular/particular_information.dart';
import 'Particular/particular_information2.dart';
import 'Particular/registration_for_particular.dart';
import 'Particular/scan_face_particular.dart';
import 'common/call_contact/contact_support.dart';
import 'common/call_contact/contact_support_message.dart';
import 'common/call_contact/customer_services.dart';
import 'common/call_contact/email_us.dart';
import 'common/log_in/finger_print_done.dart';
import 'common/log_in/finger_print_input_for_loging.dart';
import 'common/log_in/log_in.dart';
import 'common/log_in/login_by_pin.dart';

import 'common/money_option/pay_with_qr_code/pay_with_qr_amount_page.dart';
import 'common/money_option/request_money/request_money_amount_page.dart';
import 'common/money_option/send_money/send_money_amount_page.dart';
import 'common/money_option/top_up_account/top_up_credit_card/add_credit_cart.dart';
import 'common/money_option/top_up_account/top_up_credit_card/top_up_amount_page.dart';
import 'common/money_option/top_up_account/top_up_mobile_bank/save_number.dart';
import 'common/money_option/top_up_account/top_up_mobile_bank/top_up_account_mobile_amount_page.dart';
import 'common/money_option/top_up_account/top_up_mobile_bank/top_up_try_again.dart';
import 'common/money_option/top_up_account/top_up_mobile_bank/top_up_your_account_for_mobile.dart';
import 'common/money_option/transfer_money/transfer_money_details_particular.dart';
import 'common/money_option/transfer_money/transfer_money_details_particular2.dart';
import 'common/money_option/transfer_money/transfer_money_for_selected.dart';
import 'common/navigation_page/cart/card_page.dart';
import 'common/navigation_page/home_page.dart';
import 'common/navigation_page/money_option.dart';
import 'common/navigation_page/navigation_bar_page.dart';
import 'common/notification/notification.dart';
import 'common/static/Colors.dart';
import 'company/company_account.dart';
import 'company/company_information.dart';
import 'company/create_confirm_pin_company.dart';
import 'company/create_pin_Company.dart';
import 'company/email_verification_company.dart';
import 'company/message_verification_company.dart';
import 'company/registration_for_company.dart';
import 'company/scan_doc_front_company.dart';

import 'finger_print_auth.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );


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
  Widget build(BuildContext context){
    return  MaterialApp(
      color:novalexxa_color,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          //body:CustomerServicesScreen()
         // body:NavigationBarScreen(0,HomePageScreen())
         // body:MessageVerificationCompanyScreen("1")
         body: AddInformationForParticular2Screen("1")

        // body:PayWithQRAmountPageScreen("2","Boss")
      ),
    );
  }

}