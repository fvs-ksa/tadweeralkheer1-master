//The splash screen

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/ColorizeAnimatedText.dart';
import 'package:splash_screen_view/ScaleAnimatedText.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:splash_screen_view/TyperAnimatedText.dart';
import 'package:tadweer_alkheer/screens/onboarding_screen.dart';
import 'package:tadweer_alkheer/screens/tabs_screen.dart';

import '../main.dart';

class SplashScreen2 extends StatefulWidget {
  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    Timer(
        Duration(milliseconds: 3010),
            () =>
            Navigator.push(context,MaterialPageRoute(builder: (context)=>OnBoardingScreen()))
            // Navigator.of(context)
            //     .pushReplacement(MaterialPageRoute(builder: (_)
            // => TabsScreen(0)
            // ))
    );
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 35),
        child: Column(
          children: [
            Image.asset('assets/images/vsion.2030.jpg',width: 150,height: 150,),
            Image.asset(
              'assets/images/logodown.png',
              width: MediaQuery.of(context).size.height.toInt() - 25.toDouble(),
            ),
          ],
        ),
      ),
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
