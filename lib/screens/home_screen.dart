import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tadweer_alkheer/models/category.dart';
import 'package:tadweer_alkheer/models/reviws_model.dart';
import 'package:tadweer_alkheer/providers/categories_provider.dart';
import 'package:tadweer_alkheer/providers/review_provider.dart';
import 'package:tadweer_alkheer/screens/add_donation_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tadweer_alkheer/screens/partners_screen.dart';
import 'package:tadweer_alkheer/widgets/reviews_widget.dart';
import '../component.dart';
import 'package:sizer/sizer.dart';
import '../providers/locale_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  List<dynamic> categories = [];
  List<dynamic> reviews = [];
  String userID;

  @override
  Widget build(BuildContext context) {
    Size _size=MediaQuery.of(context).size;
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
      print(_size.height);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;
    //  userID = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      body: StreamBuilder(
          stream: categoriesProvider.fetchAllCategoriesAsStream(),
          builder: (ctx, categoriesSnapshot) {
          //  ScreenUtil.init(context, designSize: const Size(360, 690));
            // if (categoriesSnapshot.connectionState ==
            //     ConnectionState.waiting) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            if (categoriesSnapshot.hasData) {
              print('category');
              print(categories.length);
              // categories = categoriesSnapshot.data.doc
              //     .map((doc) => Categoryy.fromMap(doc.data(), doc.id))
              //     .toList();
              categories=categoriesSnapshot.data.docs.map((doc)=>Categoryy.fromMap(doc.data(), doc.id)).toList();
            }else{
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                children: <Widget>[
                  textCard(
                    align: TextAlign.center,
                    context: context,
                    text: AppLocalizations.of(context).help,
                    width: 90.w,
                  ),
                  // Card(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //
                  //   elevation: 4,
                  //   margin: EdgeInsets.all(12),
                  //   //The green box..
                  //
                  //   child: Container(
                  //     //color: Theme.of(context).primaryColor,
                  //     width: MediaQuery.of(context).size.width * 0.9,
                  //     padding: EdgeInsetsDirectional.only(
                  //         bottom: 10, top: 10, start: 17, end: 10),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(15),
                  //         color: Theme.of(context).primaryColor),
                  //     child: Text(
                  //       AppLocalizations.of(context).help,
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  //The space between the green box and the two row
                  //////////////////////////////
                  // ConstrainedBox(
                  //   constraints: BoxConstraints(
                  //     maxHeight: 110.0 * categories.length,
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: GridView.builder(
                  //           physics: BouncingScrollPhysics(),
                  //           padding: EdgeInsets.all(12),
                  //           gridDelegate:
                  //           SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             childAspectRatio: 0.9,
                  //             crossAxisSpacing: 10,
                  //             mainAxisSpacing: 20,
                  //           ),
                  //           itemCount: categories.length,
                  //           itemBuilder: (ctx, index) => Container(
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                     width: 1, color: Colors.grey),
                  //                 borderRadius: BorderRadius.circular(12)),
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(10),
                  //               child: GridTile(
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     Navigator.of(context).pushNamed(
                  //                       AddDonationScreen.routeName,
                  //                       arguments:
                  //                       currentLocale.languageCode == 'ar'
                  //                           ? categories[index].arabicName
                  //                           : categories[index].name,
                  //                     );
                  //                   },
                  //                   child: FadeInImage(
                  //                     //placeholder appears for afew minutes while the image loads
                  //                     placeholder: AssetImage(
                  //                         'assets/images/placeholder.jpg'),
                  //                     image: categories[index].imageUrl !=
                  //                         null
                  //                         ? NetworkImage(
                  //                         categories[index].imageUrl)
                  //                         : AssetImage(
                  //                         'assets/images/placeholder.jpg'),
                  //                     fit: BoxFit.cover,
                  //                     imageErrorBuilder:
                  //                         (context, error, stackTrace) {
                  //                       return Image.asset(
                  //                         "assets/images/placeholder.jpg",
                  //                         height: 260,
                  //                         width: 260,
                  //                       );
                  //                     },
                  //                   ),
                  //                 ),
                  //                 footer: GridTileBar(
                  //                   backgroundColor: Colors.black54,
                  //                   title: Text(
                  //                     currentLocale.languageCode == 'ar'
                  //                         ? categories[index].arabicName
                  //                         : categories[index].name,
                  //                     textAlign: TextAlign.center,
                  //                     style: TextStyle(
                  //                         fontFamily: 'Tajawal-Regular',
                  //                         fontWeight: FontWeight.w500,
                  //                         fontSize: 16),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //First Row...
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:SizedBox(
                          // padding: EdgeInsets.all(12),
                         // height:_size.height>900?MediaQuery.of(context).size.height*0.8:  MediaQuery.of(context).size.height*0.5,
                          height:SizerUtil.orientation == Orientation.portrait?50.h:112.h ,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.9,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: categories.length,
                              itemBuilder: (ctx,index)=>Container(
                                // height: 100,
                                //width: ScreenUtil().setWidth(50),
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: GridTile(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          AddDonationScreen.routeName,
                                          arguments:
                                          currentLocale.languageCode == 'ar'
                                              ? categories[index].arabicName
                                              : categories[index].name,
                                        );
                                      },
                                      child: FadeInImage(
                                        //placeholder appears for afew minutes while the image loads
                                        placeholder: AssetImage(
                                            'assets/images/placeholder.jpg'),
                                        image: categories[index].imageUrl != null
                                            ? NetworkImage(
                                            categories[index].imageUrl)
                                            : AssetImage(
                                            'assets/images/placeholder.jpg'),
                                        fit: BoxFit.cover,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            "assets/images/placeholder.jpg",
                                            height: 260,
                                            width: 260,
                                          );
                                        },
                                      ),
                                    ),
                                    footer: GridTileBar(
                                      backgroundColor: Colors.black54,
                                      title: Text(
                                        currentLocale.languageCode == 'ar'
                                            ? categories[index].arabicName
                                            : categories[index].name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Tajawal-Black',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              )),),
                      ),
                    ],
                  ),
                  /*
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ImageGalleryScreen.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Theme.of(context).colorScheme.primary),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(16),
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 32,
                              child: Column(

                                children: [
                                  Icon(Icons.collections,
                                      color: Colors.white, size: 50.0),
                                  SizedBox(height: 12),
                                  Text(
                                    AppLocalizations.of(context).imageGallery,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(VideoGalleryScreen.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Theme.of(context).colorScheme.primary),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(16),
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 32,
                              child: Column(
                                children: [
                                  Icon(Icons.video_library,
                                      color: Colors.white, size: 50.0),
                                  SizedBox(height: 12),
                                  Text(
                                    AppLocalizations.of(context).videoGallery,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      */
                  // Second row..
                  /*
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(PartnersScreen.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Theme.of(context).colorScheme.primary
                              ),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(16),
                              width: (MediaQuery.of(context).size.width / 2) - 32,
                              child: Column(
                                children: [
                                  Image.asset("assets/images/partners.png"),
                                  SizedBox(height: 12),
                                  Text(AppLocalizations.of(context).partners,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),)
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(AboutUsScreen.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Theme.of(context).colorScheme.primary
                              ),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(16),
                              width: (MediaQuery.of(context).size.width / 2) - 32,
                              child: Column(
                                children: [
                                  Image.asset("assets/images/logo_white.png"),
                                  SizedBox(height: 12),
                                  Text(AppLocalizations.of(context).aboutus,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),)
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                      */
                  PartnersScreen(),
                  SizedBox(height: 10,),
                //  ReviewsWidget(),
                ],
            ),
              ),);
          }),
    )
    ;
  }
}
