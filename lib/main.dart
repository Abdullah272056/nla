
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_lexxa/splash_screen/splash_screen1.dart';

import 'Particular/scan_done_particular.dart';
import 'common/card_page.dart';
import 'common/customer_services.dart';
import 'common/home_page.dart';
import 'common/navigation_bar_page.dart';
import 'common/no_notifications.dart';
import 'common/notification.dart';
import 'common/notification_details.dart';
import 'common/notifications_deleted.dart';
import 'common/notifications_settings.dart';
import 'company/biometric_Company.dart';


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
          children: [
            //NotificationsSettingsScreen(),
            CardPageScreen(),
          ],
        ),
      ),
    );
  }


}