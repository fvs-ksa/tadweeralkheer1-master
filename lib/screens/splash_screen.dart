//The splash screen

import 'dart:async';
import 'package:sizer/sizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
import 'package:splash_screen_view/ColorizeAnimatedText.dart';
import 'package:splash_screen_view/ScaleAnimatedText.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:splash_screen_view/TyperAnimatedText.dart';
import 'package:tadweer_alkheer/screens/onboarding_screen.dart';
import 'package:tadweer_alkheer/screens/tabs_screen.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(milliseconds: 3010),
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => MainScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizerUtil.orientation == Orientation.portrait
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                //  mainAxisAlignment: M,
                children: [
                  Image.asset(
                    'assets/images/vsion.2030.jpg',
                    width: 50.w,
                    height: 10.h,
                  ),

                  ///  Container(

                  // child:
                  Image.asset(
                    'assets/images/logodown.png',
                    width: MediaQuery.of(context).size.height.toInt() -
                        25.toDouble(),
                  ),
                  // )
                ],
              ))
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 85.w),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                //  mainAxisAlignment: M,
                children: [
                  Image.asset(
                    'assets/images/vsion.2030.jpg',
                    width: 40.w,
                    height: 10.h,
                  ),

                  ///  Container(

                  // child:
                  Container(
// padding: EdgeInsets.zero,
                    width: 60.w,
                    height: 25.h,
                    child: Image.asset(
                      'assets/images/logodown.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  // )
                ],
              )),
//         backgroundColor: Colors.white,'),
    );
  }
}

// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SplashScreenView(
//         navigateRoute: MainScreen(),
//         duration: 3500,
//         imageSize: MediaQuery.of(context).size.height.toInt() - 25,
//         imageSrc: "assets/images/Comp2(1).gif",
//         backgroundColor: Colors.white,
//       ),
//     );
//   }
// }
// Image.asset(
// 'assets/images/vsion.2030.jpg',
// width: 40.w,
// height: 10.h,
// ),
//
//
//
// Container(
// // padding: EdgeInsets.zero,
// width: 60.w,
// height: 40.h,
// child: Image.asset(
// 'assets/images/logodown.png',
// fit: BoxFit.fitHeight,
//
// ),
// ),
