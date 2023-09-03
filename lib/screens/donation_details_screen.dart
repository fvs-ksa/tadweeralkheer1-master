// ignore_for_file: missing_required_param

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tadweer_alkheer/models/issue.dart';
import 'package:tadweer_alkheer/palette.dart';
import 'package:tadweer_alkheer/providers/issue_provider.dart';
import 'package:tadweer_alkheer/screens/tabs_screen.dart';
import '../models/user.dart' as userModel;
import 'package:tadweer_alkheer/models/points.dart';
import 'package:tadweer_alkheer/screens/rating_done_screen.dart';
import 'package:tadweer_alkheer/widgets/location_View.dart';
import 'package:tadweer_alkheer/models/donation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadweer_alkheer/providers/locale_provider.dart';
import '../providers/donation_points_provider.dart';
import '../providers/donations_provider.dart';

class DonationDetailsScreen extends StatefulWidget {
  final Donation donation;

  DonationDetailsScreen(this.donation);

  @override
  State<DonationDetailsScreen> createState() => _DonationDetailsScreenState();
}

class _DonationDetailsScreenState extends State<DonationDetailsScreen> {
  double rate = 1;
  TextEditingController controller = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final issueProvider = Provider.of<IssueProvider>(context, listen: false);
    print(widget.donation.id.toString());
    // print(widget.issue.id);
    print(widget.donation.date.toString());
    print(widget.donation.location.latitude);
    print(widget.donation.location.address);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;

    // var donationStatusText = widget.donation.status;
    // if (currentLocale.languageCode == 'ar') {
    //   donationStatusText = "في انتظار الاستلام";
    // }
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    // DataColumn pickupDateCol = DataColumn(
    //     label: Text(
    //   AppLocalizations.of(context).pickupDate,
    //   style: TextStyle(color: Colors.white),
    // ));
    // DataColumn dividerCol = DataColumn(
    //     label: VerticalDivider(
    //   width: 3,
    //   color: Colors.black,
    // ));
    // DataColumn pickupTimeCol = DataColumn(
    //     label: Text(AppLocalizations.of(context).pickupTime,
    //         style: TextStyle(color: Colors.white)));

    DataCell pickupDateCell = DataCell(Text(
      DateFormat('dd/MM/yyyy')
          .format(widget.donation.pickupDateTime)
          .toString(),
    ));
    DataCell pickupTimeCell = DataCell(Text(
      DateFormat('HH:mm').format(widget.donation.pickupDateTime).toString(),
    ));

    // DataRow tableRow = DataRow(cells: [
    //   pickupDateCell,
    //   DataCell(VerticalDivider(
    //     width: 3,
    //     color: Colors.black,
    //   )),
    //   pickupTimeCell
    // ]);
    // int rating = 0;
    // DateTime dateLemite =
    //     widget.donation.date.add(Duration(hours: 47, minutes: 59, seconds: 59));
    DateTime dateCurrent = widget.donation.date;

    // Jiffy(dateCurrent).fromNow();
    //

    // var jiffy = Jiffy(dateCurrent)..endOf(Units.HOUR);
    // DateTime date=dateLemite.subtract(dateLemite);
    // var date=dateLemite.subtract(dateCurrent.hour)
    Duration diff = DateTime.now().difference(dateCurrent);
    var reminder = 48 - diff.inHours;
    GlobalKey globalKey = GlobalKey();
    // var h=jiffy.subtract(hours: diff.inHours) ;
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        // backgroundColor: Colors.green,
        title: Text(
          AppLocalizations.of(context).mydonations,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapShot) {
          print(widget.donation.status);
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 26),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${AppLocalizations.of(context).order} #${widget.donation.id.substring(widget.donation.id.length - 5)}",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                //The Text below will be changed to Map Containaer.
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 18, 10, 0),
                    child: LocationView(widget.donation.location.latitude,
                        widget.donation.location.longitude),
                  ),
                ),
                widget.donation.status == 'Awaiting Pickup'
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                        child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                indecatorWidget(
                                    color: Colors.green,
                                    text: AppLocalizations.of(context).ready,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                indecatorWidget(
                                    color: Colors.grey,
                                    text:
                                        AppLocalizations.of(context).preparing,
                                    style: TextStyle(color: Colors.grey)),
                                indecatorWidget(
                                    color: Colors.grey,
                                    text: AppLocalizations.of(context).received,
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            reminder <= 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      widget.donation.isIssued
                                          ? Text(
                                              'تم رفع المشكله للاداره وسيتم الرد عليك في اقرب فرصه\n شكرا لاختيارك تدوير الخير',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            )
                                          : Text(
                                              'لم يتصل بي السائق',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                      widget.donation.isIssued
                                          ? SizedBox()
                                          : SizedBox(
                                              width: 25,
                                            ),
                                      widget.donation.isIssued
                                          ? SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                final donationsProvider =
                                                    Provider.of<
                                                            DonationsProvider>(
                                                        context,
                                                        listen: false);
                                                donationsProvider
                                                    .updateDonation(
                                                        Donation(
                                                            description: widget
                                                                .donation
                                                                .description,
                                                            category: widget
                                                                .donation
                                                                .category,
                                                            isRatings: false,
                                                            phoneNumber: user
                                                                .phoneNumber,
                                                            phoneNumberDetails:
                                                                widget.donation
                                                                    .phoneNumberDetails,
                                                            name: widget
                                                                .donation.name,
                                                            imageUrl: widget
                                                                .donation
                                                                .imageUrl,
                                                            videoUrl: widget
                                                                .donation
                                                                .videoUrl,
                                                            date: widget
                                                                .donation.date,
                                                            userId: user.uid,
                                                            isIssued: true,
                                                            pickupDateTime: widget
                                                                .donation
                                                                .pickupDateTime,
                                                            quantity: widget
                                                                .donation
                                                                .quantity,
                                                            location: widget
                                                                .donation
                                                                .location,
                                                            status: widget
                                                                .donation.status
                                                            // isRatings: false,
                                                            ),
                                                        widget.donation.id);
                                                issueProvider
                                                    .addIssue(Issue(
                                                  status:
                                                      widget.donation.status,
                                                  category:
                                                      widget.donation.category,
                                                  date: DateTime.now(),
                                                  donationDate:
                                                      widget.donation.date,
                                                  content: 'لم يتصل بي السائق',
                                                  phoneNumberDetails: widget
                                                      .donation
                                                      .phoneNumberDetails,
                                                  userId: FirebaseAuth
                                                      .instance.currentUser.uid,
                                                  location:
                                                      widget.donation.location,
                                                  donationId:
                                                      widget.donation.id,
                                                ))
                                                    .then((value) {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      TabsScreen(
                                                                          1)));
                                                  Fluttertoast.showToast(
                                                      fontSize: 18,
                                                      timeInSecForIosWeb: 20,
                                                      msg:
                                                          'تم رفع طلبك للاداره وسوف نقوم بالرد عليك في اقرب وقت',
                                                      backgroundColor:
                                                          Colors.green,
                                                      textColor: Colors.white);
                                                });
                                              },
                                              child: Image.asset(
                                                'assets/images/!!!!.png',
                                                height: 50,
                                                width: 50,
                                              ),
                                            ),
                                    ],
                                  )
                                : Text(
                                    '  سيتم التواصل معك في خلال $reminder  ساعه ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                          ],
                        ))
                    : widget.donation.status == 'Awaiting Deliver'
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 35, horizontal: 25),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    indecatorWidget(
                                        color: Colors.green,
                                        text:
                                            AppLocalizations.of(context).ready,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    indecatorWidget(
                                        color: Colors.green,
                                        text: AppLocalizations.of(context)
                                            .preparing,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    indecatorWidget(
                                        color: Colors.grey,
                                        text: AppLocalizations.of(context)
                                            .received,
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                reminder <= 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          widget.donation.isIssued
                                              ? Text(
                                                  'تم رفع المشكله للاداره وسيتم الرد عليك في اقرب فرصه\n شكرا لاختيارك تدوير الخير',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                )
                                              : Text(
                                                  'لم يتصل بي السائق',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                          widget.donation.isIssued
                                              ? SizedBox()
                                              : SizedBox(
                                                  width: 25,
                                                ),
                                          widget.donation.isIssued
                                              ? SizedBox()
                                              : InkWell(
                                                  onTap: () {
                                                    final donationsProvider =
                                                        Provider.of<
                                                                DonationsProvider>(
                                                            context,
                                                            listen: false);
                                                    donationsProvider
                                                        .updateDonation(
                                                            Donation(
                                                                description: widget
                                                                    .donation
                                                                    .description,
                                                                category: widget
                                                                    .donation
                                                                    .category,
                                                                isRatings:
                                                                    false,
                                                                phoneNumber: user
                                                                    .phoneNumber,
                                                                phoneNumberDetails:
                                                                    widget
                                                                        .donation
                                                                        .phoneNumberDetails,
                                                                name: widget
                                                                    .donation
                                                                    .name,
                                                                imageUrl: widget
                                                                    .donation
                                                                    .imageUrl,
                                                                videoUrl: widget
                                                                    .donation
                                                                    .videoUrl,
                                                                date: widget
                                                                    .donation
                                                                    .date,
                                                                userId:
                                                                    user.uid,
                                                                isIssued: true,
                                                                pickupDateTime:
                                                                    widget
                                                                        .donation
                                                                        .pickupDateTime,
                                                                quantity: widget
                                                                    .donation
                                                                    .quantity,
                                                                location: widget
                                                                    .donation
                                                                    .location,
                                                                status: widget
                                                                    .donation
                                                                    .status
                                                                // isRatings: false,
                                                                ),
                                                            widget.donation.id);
                                                    issueProvider
                                                        .addIssue(Issue(
                                                      status: widget
                                                          .donation.status,
                                                      category: widget
                                                          .donation.category,
                                                      date: DateTime.now(),
                                                      donationDate:
                                                          widget.donation.date,
                                                      content:
                                                          'لم يتصل بي السائق',
                                                      phoneNumberDetails: widget
                                                          .donation
                                                          .phoneNumberDetails,
                                                      userId: FirebaseAuth
                                                          .instance
                                                          .currentUser
                                                          .uid,
                                                      location: widget
                                                          .donation.location,
                                                      donationId:
                                                          widget.donation.id,
                                                    ))
                                                        .then((value) {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      TabsScreen(
                                                                          1)));
                                                      Fluttertoast.showToast(
                                                          fontSize: 18,
                                                          timeInSecForIosWeb:
                                                              20,
                                                          msg:
                                                              'تم رفع طلبك للاداره وسوف نقوم بالرد عليك في اقرب وقت',
                                                          backgroundColor:
                                                              Colors.green,
                                                          textColor:
                                                              Colors.white);
                                                    });
                                                  },
                                                  child: Image.asset(
                                                    'assets/images/!!!!.png',
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                        ],
                                      )
                                    : Text(
                                        '  سيتم التواصل معك في خلال $reminder  ساعه ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                //  widget.donation.isIssued?
                              ],
                            ))
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 35, horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                indecatorWidget(
                                    color: Colors.green,
                                    text: AppLocalizations.of(context).ready,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                indecatorWidget(
                                    color: Colors.green,
                                    text:
                                        AppLocalizations.of(context).preparing,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                indecatorWidget(
                                    color: Colors.green,
                                    text: AppLocalizations.of(context).received,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),

                widget.donation.status == 'delivered'
                    ? widget.donation.isRatings
                        ? Container(
                            child: Text(
                              'لقد قمت مسبقا برفع تقيمك الخاص بذلك الطلب',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : Column(
                            children: [
                              Text(AppLocalizations.of(context).rateText),
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.green,
                                ),
                                onRatingUpdate: (rating) {
                                  rate = rating;
                                },
                              ),
                              Form(
                                key: _form,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: TextFormField(
                                    controller: controller,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'من فضلك اضف ملاحظتك';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)
                                            .rateText),
                                    maxLines: 2,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                      onPressed: () async {
                                        if (_form.currentState.validate()) {
                                          var userData = await _db
                                              .collection('users')
                                              .doc(user.uid)
                                              .get();

                                          final donationsProvider =
                                              Provider.of<DonationsProvider>(
                                                  context,
                                                  listen: false);
                                          donationsProvider.updateDonation(
                                              Donation(
                                                  description: widget
                                                      .donation.description,
                                                  category:
                                                      widget.donation.category,
                                                  isRatings: true,
                                                  phoneNumber: user.phoneNumber,
                                                  phoneNumberDetails: widget
                                                      .donation
                                                      .phoneNumberDetails,
                                                  name: widget.donation.name,
                                                  imageUrl:
                                                      widget.donation.imageUrl,
                                                  videoUrl:
                                                      widget.donation.videoUrl,
                                                  date: widget.donation.date,
                                                  userId: user.uid,
                                                  isIssued: false,
                                                  pickupDateTime: widget
                                                      .donation.pickupDateTime,
                                                  quantity:
                                                      widget.donation.quantity,
                                                  location:
                                                      widget.donation.location,
                                                  status: widget.donation.status
                                                  // isRatings: false,
                                                  ),
                                              widget.donation.id);

                                          final pointsProvider = Provider.of<
                                                  DonationPointsProvider>(
                                              context,
                                              listen: false);
                                          pointsProvider.addPoints(Point(
                                              userId: FirebaseAuth
                                                  .instance.currentUser.uid,
                                              quantity: 5,
                                              date: DateTime.now(),
                                              donationId: widget.donation.id));

                                          final ratingProvider =
                                              Provider.of<RatingProvider>(
                                                  context,
                                                  listen: false);
                                          ratingProvider.addRating(Rating(
                                              userId: FirebaseAuth
                                                  .instance.currentUser.uid,
                                              phoneNumber: userData
                                                  .data()['phoneNumber'],
                                              rate: rate,
                                              imageUrl:
                                                  userData.data()['imageUrl'],
                                              name: userData.data()['name'],
                                              accepted: false,
                                              date: DateTime.now(),
                                              donationId: widget.donation.id,
                                              message: controller.text));

                                          print(widget.donation.isRatings);
                                          Navigator.of(context).pop();

                                          print(
                                            userData.data()['phoneNumber'],
                                          );
                                          await Navigator.of(context)
                                              .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RatingDoneScreen()));
                                        }
                                      },
                                      child: Text(AppLocalizations.of(context)
                                          .sendComment)),
                                ],
                              )
                            ],
                          )
                    : Container(),
                Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.green),
                  child: Text(
                    widget.donation.status == 'Awaiting Pickup'
                        ? AppLocalizations.of(context).ready
                        : widget.donation.status == 'Awaiting Deliver'
                            ? AppLocalizations.of(context).preparing
                            : AppLocalizations.of(context).received,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget indecatorWidget({String text, Color color, TextStyle style}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 10,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: style,
        ),
      ],
    );
  }
}
