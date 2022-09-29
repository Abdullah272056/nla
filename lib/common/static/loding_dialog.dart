import 'package:flutter/material.dart';

import 'Colors.dart';



void showLoadingDialog(BuildContext context,String _message){
  showDialog(
    context: context,
    builder: (context) {
      // return VerificationScreen();
      return Dialog(
        child: Wrap(
          children: [
            Container(
                margin:  const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 30, bottom: 30),
                child: Center(
                  child: Row(
                    children:  [
                      const SizedBox(
                        width: 10,
                      ),
                      const CircularProgressIndicator(
                        backgroundColor:novalexxa_start_bg_color,
                        strokeWidth: 5,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        _message,
                        style: const TextStyle(fontSize: 25),
                      )
                    ],
                  ),
                ))
          ],
          // child: VerificationScreen(),
        ),
      );
    },
  );
}