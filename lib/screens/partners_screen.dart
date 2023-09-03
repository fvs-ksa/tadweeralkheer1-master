import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadweer_alkheer/models/partner.dart';
import 'package:tadweer_alkheer/providers/partners_provider.dart';
import 'package:tadweer_alkheer/widgets/empty_list.dart';
import 'package:tadweer_alkheer/widgets/partner_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../component.dart';
import 'package:sizer/sizer.dart';

class PartnersScreen extends StatefulWidget {
  static const routeName = '/partners';

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  List<Partner> partners;
  int _current=0;

  @override
  Widget build(BuildContext context) {
    final partnersProvider = Provider.of<PartnersProvider>(context);

    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textCard(
          align: TextAlign.start,
          context: context,
          text:  AppLocalizations.of(context).partners,
          width: MediaQuery.of(context).size.width*.30,
        ),

       // Text(AppLocalizations.of(context).partners,style: TextStyle(fontSize: 25),),
        Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: FutureBuilder(
              future: partnersProvider.fetchPartners(),
              builder: (ctx, partnersSnapshot) {
                // if (partnersSnapshot.connectionState == ConnectionState.waiting) {
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }

                if (partnersSnapshot.hasData) {
                  partners = partnersSnapshot.data;

                  print(partners);

                  return partners.isEmpty
                      ? EmptyList(true)
                      :Container(
                    child: CarouselSlider.builder(

                        itemCount: partners.length,
                        itemBuilder: (ctx,index,realIdx){
                      return Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: PartnerItem(partners[index])),
                      );
                    }, options: CarouselOptions(

                      height: MediaQuery.of(context).size.height * .30,
                      aspectRatio: 16 / 9,
                      viewportFraction: .80,
                      enlargeCenterPage: true,
                      autoPlay: true,


                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                         // print('555');
                        });
                      },
                    ),
                    ),
                  );

                }
                return Center(child: CircularProgressIndicator.adaptive());
              },
            ),

        ),
      ],
    );
  }
}

