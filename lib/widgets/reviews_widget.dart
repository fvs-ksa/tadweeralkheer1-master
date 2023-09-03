import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadweer_alkheer/models/reviws_model.dart';
import 'package:tadweer_alkheer/providers/review_provider.dart';

import '../component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewsWidget extends StatelessWidget {
  List<dynamic> reviews = [];
  @override
  Widget build(BuildContext context) {
    final reviewsProvider = Provider.of<ReviewsProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textCard(
          align: TextAlign.start,
          context: context,
          text: AppLocalizations.of(context).costomerReview,
          width: MediaQuery.of(context).size.width * .30,
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder(stream: reviewsProvider.fetchAllReviewsAsStream(),
            builder: (ctx, reviewSnapshot){
              if (reviewSnapshot.hasData) {
                print('review');
                reviews = reviewSnapshot.data.docs
                    .map((doc) => Reviews.fromMap(doc.data(), doc.id))
                    .toList();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                padding: EdgeInsets.only(bottom: 25),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context,index){
                      return Divider(thickness: 1,color: Colors.grey,endIndent: 35,indent: 35,);
                    },
                    itemCount: reviews.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:reviews[index].imageUrl==''?AssetImage('assets/images/profile.jpg'): NetworkImage(reviews[index].imageUrl),
                          radius: 25,
                        ),
                        title: Text(reviews[index].name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        subtitle: Text(reviews[index].content),
                      );
                    }

                ),


              );
            }),
      ],
    );
  }
}
