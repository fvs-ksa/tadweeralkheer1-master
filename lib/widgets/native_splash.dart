import 'package:flutter/material.dart';

class NativeSplash extends StatelessWidget {
 // const NativeSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
class Init{
  Init._();
  static final instance= Init._();
  Future initialize()async{
    await Future.delayed(const Duration(seconds: 3));
  }
}