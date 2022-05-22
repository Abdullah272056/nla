
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nova_lexxa/splash_screen/splash_screen1.dart';

import 'Particular/scan_doc_front_particular.dart';



void main() {
  runApp( MyApp());
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    // statusBarColor: Colors.intello_bd_color_dark.withOpacity(0.0),
    //
    // systemNavigationBarColor: Colors.intello_bd_color_dark,
    //
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
            //ScanDocFrontScreen(),
            SplashScreen1(),
          ],
        ),
      ),
    );
  }


}