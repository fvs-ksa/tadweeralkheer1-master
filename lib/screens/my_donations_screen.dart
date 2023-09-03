import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadweer_alkheer/models/donation.dart';
import 'package:tadweer_alkheer/providers/donations_provider.dart';
import 'package:tadweer_alkheer/widgets/empty_list.dart';
import 'package:tadweer_alkheer/widgets/login_required.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/donation_item.dart';
import '../widgets/donatoin_item.dart';

class MyDonationsScreen extends StatelessWidget {
  List<dynamic> donations;
  @override
  Widget build(BuildContext context) {
    final donationsProvider = Provider.of<DonationsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).mydonations),
      ),
      body:  StreamBuilder(
            stream: donationsProvider
                .fetchDonationsAsStream(FirebaseAuth.instance.currentUser.uid),
            builder: (ctx, donationsSnapshot) {
              if(donationsSnapshot.hasData){
                print('object');
                donations = donationsSnapshot.data.docs
                    .map((doc) => Donation.fromMap(doc.data(), doc.id))
                    .toList();
                print(donations[1].category);
                print(donations[1].id);
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              } return ListView.builder(
                itemCount: donations.length,
                itemBuilder: (buildContext, index) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16.0),
                    child:
                    DonationItem(
                      donation:donations[index],
                      description: donations[index].category,
                    ),
                  );
                },
              );
              // if (donationsSnapshot.connectionState ==
              //     ConnectionState.waiting) {
              //   return Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              //
              // if (donationsSnapshot.hasData) {
              //   donations = donationsSnapshot.data.docs
              //       .map((doc) => Donation.fromMap(doc.data(), doc.id))
              //       .toList();
              //   print(donations.length);
              //   print(donations[0].description);
              //   return donations.isEmpty
              //       ? EmptyList(true)
              //       : ListView.builder(
              //           itemCount: donations.length,
              //           itemBuilder: (buildContext, index) {
              //             return Padding(
              //               padding:
              //                   const EdgeInsets.symmetric(horizontal: 16.0),
              //               child:
              //               DonationItem(
              //                   donation:donations[index],
              //                 description: donations[index].description,
              //                   ),
              //             );
              //           },
              //         );
              // }
              //
              // return EmptyList(true);
            },
          )

    );
  }
}
