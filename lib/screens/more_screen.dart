import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './aboutus_screen.dart';
import './alwalaa_screen.dart';
import './image_gallery_screen.dart';
import './support_center.dart';
import 'package:url_launcher/url_launcher.dart';
import '../palette.dart';
import './settings_screen.dart';
import 'points_map.dart';

class Morescreen extends StatefulWidget {
  @override
  State<Morescreen> createState() => _MorescreenState();
}

class _MorescreenState extends State<Morescreen> {
  _ourAppUrlAndroid() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.tadweer.alkheer';
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: false, forceSafariVC: false, enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  _ourAppUrlIos() async {
    const url =
        'https://apps.apple.com/sa/app/%D8%AA%D8%AF%D9%88%D9%8A%D8%B1-%D8%A7%D9%84%D8%AE%D9%8A%D8%B1/id1603250576';
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: false, forceSafariVC: false, enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  _ourAppUrlHuawei() async {
    const url = "https://appgallery.huawei.com/app/C104829837";
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: false, forceSafariVC: false, enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  _ourWebsiteUrl() async {
    const url = 'https://tadweeralkheer.com.sa/';
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: true, forceSafariVC: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
    // await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              // settings
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                    color: Palette.darkGreen,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen())),
                    child: Text(
                      AppLocalizations.of(context).settings,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Divider(),
              // about us
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: MaterialButton(
                  color: Palette.darkGreen,
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutUsScreen())),
                  child: Text(
                    AppLocalizations.of(context).aboutus,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Divider(),
              // map
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                    color: Palette.darkGreen,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PointsMapScreen())),
                    child: Text(
                      AppLocalizations.of(context).markedPoint,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Divider(),

              // SizedBox(
              //   width: double.infinity,
              //   child: RaisedButton(
              //       color: Colors.green[100],
              //       onPressed: () => Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) =>
              //                   PartnersScreen()
              //           )),
              //       child: Text(AppLocalizations.of(context).markedPoint)),
              // ),
              // Divider(),
              // photo gallery
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                    color: Palette.darkGreen,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageGalleryScreen())),
                    child: Text(
                      AppLocalizations.of(context).imageGallery,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Divider(),
              //website
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                    color: Palette.darkGreen,
                    onPressed: _ourWebsiteUrl,
                    child: Text(
                      AppLocalizations.of(context).ourWebsite,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Divider(),
              // contact us
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                    color: Palette.darkGreen,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SupportCenter())),
                    child: Text(
                      AppLocalizations.of(context).supportcenter,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Divider(),
              // Rate the app
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                    color: Palette.darkGreen,
                    onPressed: () {
                      if (Platform.isAndroid) {
                        _ourAppUrlAndroid();
                      } else if (Platform.isIOS) {
                        _ourAppUrlIos();
                      } else {
                        _ourAppUrlHuawei();
                      }
                    },
                    /*() {
                      LaunchReview.launch(
                        androidAppId: 'com.example.tadweer_alkheer',
                        iOSAppId: 'com.tadweer.alkher',
                      );
                    },
                    */

                    child: Text(
                      AppLocalizations.of(context).rateText,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Divider(),
              // alwalaa program
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                    color: Palette.darkGreen,
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Points())),
                    child: Text(
                      AppLocalizations.of(context).contributionpoints,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Divider(),
              /*
              Container(
                width: 360,
                height: 70,
                child: ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => )),
                    child: Text("nome")),
              ),
              */
            ],
          ),
        ),
      ),
    );
  }
}

/*
Card(
                child: Container(
                  width: double.infinity,
                  height: 70,
                  child: RaisedButton(
                      color: Colors.green[100],
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsScreen())),
                      child: Text(AppLocalizations.of(context).aboutus)),
                ),
              ),
*/
