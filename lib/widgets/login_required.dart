import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:tadweer_alkheer/screens/authn_screen.dart';

class LoginRequired extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:SizerUtil.orientation==Orientation.portrait? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/login_required.png',height: 25.h,),
            SizedBox(height: 1.h),
            Text(AppLocalizations.of(context).loginRequired,style: TextStyle(fontSize: 15.sp),),
            SizedBox(height: 1.h),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed(
                AuthnScreen.routeName,
                arguments: true,
              );
            }, child: Text(AppLocalizations.of(context).login))
          ],
        ),
      ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/login_required.png',height: 18.h,),
            SizedBox(height: 1.h),
            Text(AppLocalizations.of(context).loginRequired,style: TextStyle(fontSize: 15.sp),),
            SizedBox(height: 1.h),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamed(
                AuthnScreen.routeName,
                arguments: true,
              );
            }, child: Text(AppLocalizations.of(context).login))
          ],
        ),
      ),
    );
  }
}
