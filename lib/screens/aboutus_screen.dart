import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sizer/sizer.dart';
import '../palette.dart';

class AboutUsScreen extends StatelessWidget {

  static const routeName = '/about-us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.white,
      // iconTheme: IconThemeData(color: Palette.yellow),
       // automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).aboutus,
         // style: TextStyle(color: Palette.yellow),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(20),
        child:
        SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Image.asset('assets/images/splash_1.png'),
            ),
            AutoSizeText(
              AppLocalizations.of(context).aboutTadweer,
              softWrap: true,
              style: TextStyle(fontSize: 18.sp,),
              //   minFontSize: 18,
              maxLines: 10,
              //overflow: TextOverflow.clip,


            ),
            SizedBox(height: 15,),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: AutoSizeText(
                AppLocalizations.of(context).vision,
                softWrap: true,
                style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),
                //   minFontSize: 18,
                maxLines: 2,

                //overflow: TextOverflow.clip,


              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: AutoSizeText(
                AppLocalizations.of(context).visiondetails,
                softWrap: true,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18.sp,),
                //   minFontSize: 18,
                maxLines: 10,
                //overflow: TextOverflow.clip,


              ),
            ),
            SizedBox(height: 15,),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: AutoSizeText(
                AppLocalizations.of(context).messageTadweer,
                softWrap: true,
                style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),
                //   minFontSize: 18,
                maxLines: 2,

                //overflow: TextOverflow.clip,


              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: AutoSizeText(
                AppLocalizations.of(context).messageDetails,
                softWrap: true,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18.sp,),
                //   minFontSize: 18,
                maxLines: 10,
                //overflow: TextOverflow.clip,


              ),
            ),
            // Row(children: [
            //   AutoSizeText(
            //     AppLocalizations.of(context).vision,
            //     softWrap: true,
            //     style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            //     //   minFontSize: 18,
            //     maxLines: 2,
            //
            //     //overflow: TextOverflow.clip,
            //
            //
            //   ),
            //   SizedBox(width: 7,),
            //   AutoSizeText(
            //     AppLocalizations.of(context).visiondetails,
            //     softWrap: true,
            //     style: TextStyle(fontSize: 15,),
            //     //   minFontSize: 18,
            //     maxLines: 10,
            //     //overflow: TextOverflow.clip,
            //
            //
            //   ),
            //
            // ],),
            // AutoSizeText(
            //   AppLocalizations.of(context).vision,
            //   softWrap: true,
            //   style: TextStyle(fontSize: 25,),
            //   //   minFontSize: 18,
            //   maxLines: 10,
            //   //overflow: TextOverflow.clip,
            //
            //
            // ),
          ]),
        )

      ),
    );
  }
}
