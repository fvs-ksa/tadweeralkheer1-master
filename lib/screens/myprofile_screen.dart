// //profile user page
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tadweer_alkheer/screens/edit_profile.dart';
// import 'package:tadweer_alkheer/screens/tabs_screen.dart';
// import 'package:tadweer_alkheer/widgets/login_required.dart';
// import '../palette.dart';
// import '../providers/users_provider.dart';
// import '../models/user.dart' as TKDUser;
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'my_donations_screen.dart';
//
// class MyProfileScreen extends StatefulWidget {
//   @override
//   _MyProfileScreenState createState() => _MyProfileScreenState();
// }
//
// class _MyProfileScreenState extends State<MyProfileScreen> {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   String userid;
//
//   TKDUser.User user;
//
//   Future<void> _edit(String field) async {
//     //print(user.name + user.name + user.name+ user.name+ user.name+ user.name);
//
//     var userdata = await _db.collection('users').doc(userid).get();
//     user = TKDUser.User(
//      // imageUrl: userdata.data()['image_url'],
//      //  itemsDonated: userdata.data()['itemsDonated'],
//      //  joinDate: DateTime.parse(userdata.data()['joinDate']),
//       name: userdata.data()['name'],
//       phoneNumber: userdata.data()['phoneNumber'],
//       id: userid,
//     );
//
//     await showModalBottomSheet(
//         isScrollControlled: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40),
//             topRight: Radius.circular(40),
//           ),
//         ),
//         context: context,
//         builder: (bCtx) {
//           return Padding(
//             padding:
//                 EdgeInsets.only(bottom: MediaQuery.of(bCtx).viewInsets.bottom),
//             child: EditProfile(
//               user: user,
//               field: field,
//             ),
//           );
//         });
//     // Navigator.pushReplacement(context,
//     //     MaterialPageRoute(builder: (BuildContext context) => TabsScreen(2)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TKDUser.User user;
//     return Scaffold(
//         body:
//            // _db.collection('users').where('phoneNumber', isEqualTo: 966506977241)
//            //     .where('type', isEqualTo: 'donor')
//            //     .get()!=null?
//         FirebaseAuth.instance.currentUser != null?
//         FutureBuilder(
//           future: _db.collection('users').doc(FirebaseAuth.instance.currentUser.uid).get(),
//          // future: _db.collection('users').get(),
//           builder: (ctx, futureSnapshot) {
//             if (futureSnapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             // user = futureSnapshot.data;
//             // user.imageUrl
//
//            // print("user ID:   " + FirebaseAuth.instance.currentUser.uid);
//            // userid = FirebaseAuth.instance.currentUser.uid;
//            //  userid=FirebaseFirestore.instance.collection('users').doc().id;
//            //  print(FirebaseFirestore.instance.collection('users').get());
//
//             var profileList = [
//               {
//                 'name': AppLocalizations.of(context).joindate,
//                 'value': DateFormat('dd/MM/yyy')
//                     .format(DateTime.parse(futureSnapshot.data['joinDate']))
//               },
//               {
//                 'name': AppLocalizations.of(context).phonenumber,
//                 'value': futureSnapshot.data['phoneNumber']
//               },
//               {
//                 'name': AppLocalizations.of(context).itemsdonated,
//                 'value': futureSnapshot.data['itemsDonated'].toString()
//               }
//             ];
//
//             if (futureSnapshot.data['type'] == "donor") {
//               profileList.add(
//                 {
//                   'name': AppLocalizations.of(context).itemsdonated,
//                   'value': futureSnapshot.data['itemsDonated'].toString()
//                 },
//               );
//             }
//
//             if (futureSnapshot.data['type'] == "driver") {
//               profileList.add(
//                 {
//                   'name': AppLocalizations.of(context).completedtasks + ':',
//                   'value': futureSnapshot.data['completedTasks'].toString()
//                 },
//               );
//             }
//             //print(futureSnapshot.data['image_url']);
//
//             user = TKDUser.User(
//             //  imageUrl: futureSnapshot.data['image_url'],
//               itemsDonated: futureSnapshot.data['itemsDonated'],
//               joinDate: DateTime.parse(futureSnapshot.data['joinDate']),
//               name: futureSnapshot.data['name'],
//               phoneNumber: futureSnapshot.data['phoneNumber'],
//               id: FirebaseAuth.instance.currentUser.uid,
//             );
//             print(user.name);
//
//             return Container(
//               margin: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.only(bottom: 20),
//                     child: Stack(
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.all(10),
//                               height: 80,
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       width: 1, color: Colors.grey.shade400),
//                                   borderRadius: BorderRadius.circular(15)),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   // The second edting(The pencil) for the profile picture.
//
//                                   IconButton(
//                                     icon: Icon(
//                                       Icons.edit,
//                                       semanticLabel:
//                                           "To change the profile pic",
//                                       color:  Palette.darkGreen,
//                                     ),
//                                     onPressed: () {
//                                       _edit('Image');
//                                     },
//                                   ),
//                                   // In the profile page, the personal picture.
//                                   Container(
//                                     width:
//                                         MediaQuery.of(context).size.width * 0.2,
//                                     padding: EdgeInsets.all(10),
//                                     child: Stack(
//                                       children: <Widget>[
//                                         ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           child:
//                                                        true
//                                               ? Image.asset(
//                                                   'assets/images/profile.jpg',
//                                                   //height: 100,
//                                                   //width: 100,
//                                                   fit: BoxFit.cover,
//                                                 )
//                                               :
//                                                        Image.network(
//                                                   futureSnapshot
//                                                       .data['image_url'],
//                                                   width: MediaQuery.of(context)
//                                                           .size
//                                                           .width *
//                                                       0.4,
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .height *
//                                                       0.2,
//                                                   fit: BoxFit.cover,
//
//                                                   //fit: BoxFit.cover,
//                                                 ),
//                                         ),
//                                         Positioned(
//                                           top: 0,
//                                           right: 0,
//                                           child: Container(
//                                             width: 40,
//                                             padding: EdgeInsets.symmetric(
//                                               vertical: 1,
//                                               horizontal: 6,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Text(futureSnapshot.data['name']),
//                                   // This editing is for the name. (It is in the left side of the column.)
//                                   IconButton(
//                                     onPressed: () {
//                                       _edit('Profile');
//                                     },
//                                     icon: Icon(Icons.edit),
//                                     color:  Palette.darkGreen,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Divider(),
//                             // Mydonations Button..
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: profileList.length,
//                       itemBuilder: (ctx, index) {
//                         return Container(
//                           // decoration: BoxDecoration(
//                           //   border: Border.all(width: 1),
//                           // ),
//                           padding: EdgeInsets.all(15),
//                           child: Row(
//                             children: <Widget>[
//                               Expanded(
//                                   child: Text(
//                                 profileList[index]['name'],
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               )),
//                               Expanded(
//                                   child: Text(
//                                 profileList[index]['value'],
//                                 style: TextStyle(
//                                     color:  Palette.darkGreen,
//                                     fontWeight: FontWeight.bold),
//                               ))
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   //Two Boxes beside each other.
//                   /*
//                   Row(
//                     children: [
//                       Container(
//                         width: 360,
//                         height: 70,
//                         decoration: BoxDecoration(),
//                         child: RaisedButton(
//                             color: Colors.green[800],
//                             onPressed: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => MyDonationsScreen())),
//                             child: Text(
//                               AppLocalizations.of(context).donations,
//                             )),
//                       ),
//                     ],
//                   ),
//                   */
//                   Divider(),
//                   Center(
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: RaisedButton(
//                           color:  Palette.darkGreen,
//                           onPressed: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => MyDonationsScreen())),
//                           child: Text(
//                             AppLocalizations.of(context).donations,style: TextStyle(color: Colors.white),
//                           )),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//
//       },
//     )
//             :LoginRequired()
//     );
//   }
// }
//profile user page
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tadweer_alkheer/locator.dart';
import 'package:tadweer_alkheer/screens/edit_profile.dart';
import 'package:tadweer_alkheer/screens/tabs_screen.dart';
import 'package:tadweer_alkheer/widgets/login_required.dart';
import '../palette.dart';
import '../providers/users_provider.dart';
import '../models/user.dart' as TKDUser;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_donations_screen.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String userid;

  TKDUser.Users user;

  Future<void> _edit(String field) async {
    //print(user.name + user.name + user.name+ user.name+ user.name+ user.name);

    var userdata = await _db.collection('users').doc(userid).get();
    user = TKDUser.Users(
      imageUrl: userdata.data()['imageUrl'],
      itemsDonated: userdata.data()['itemsDonated'],
      joinDate: DateTime.parse(userdata.data()['joinDate']),
      name: userdata.data()['name'],
      phoneNumber: userdata.data()['phoneNumber'],
      id: userid,
    );

    await showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        context: context,
        builder: (bCtx) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(bCtx).viewInsets.bottom),
            child: EditProfile(
              user: user,
              field: field,
            ),
          );
        }).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => TabsScreen(1)));
    });
  }

  // File file;
  // bool pickImage = false;
  // final ImagePicker _picker = ImagePicker();
  // // final ImagePicker _picker = ImagePicker();
  // Future pickScooterImage() async {
  //    var pickedFile =
  //   await _picker.getImage(source: ImageSource.camera);
  //   file = (File(pickedFile.path));
  //   pickImage = true;
  //  // emit(pickImageSuccess());
  // }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UsersProvider>(context);
    TKDUser.Users user;
    return Scaffold(
        body: FirebaseAuth.instance.currentUser != null
            ? FutureBuilder(
                future: _db
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .get(),
                builder: (ctx, futureSnapshot) {
                  if (futureSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // user = futureSnapshot.data;
                  // user.imageUrl

                  print("user ID:   " + FirebaseAuth.instance.currentUser.uid);
                  userid = FirebaseAuth.instance.currentUser.uid;

                  var profileList = [
                    {
                      'name': AppLocalizations.of(context).joindate,
                      'value': DateFormat('yyyy-MM-dd').format(DateTime.parse(
                          futureSnapshot.data['joinDate'].toString()))
                      //  'value':Text('25/10/2022'),
                      //'${futureSnapshot.data['joinDate']}',
                      // futureSnapshot.data['joinDate']==null?
                      // DateFormat('yyyy-MM-dd','en').format(futureSnapshot.data['joinDate']),
                      //   :Text('data'),
                      //.format(
                      // DateTime.parse(
                      //     futureSnapshot.data['joinDate']
                      //)
                      //)
                    },
                    {
                      'name': AppLocalizations.of(context).phonenumber,
                      'value': futureSnapshot.data['phoneNumber']
                    },
                    {
                      'name': AppLocalizations.of(context).itemsdonated,
                      'value': futureSnapshot.data['itemsDonated'].toString()
                    }
                  ];

                  if (futureSnapshot.data['type'] == "donor") {
                    profileList.add(
                      {
                        'name': AppLocalizations.of(context).itemsdonated,
                        'value': futureSnapshot.data['itemsDonated'].toString()
                      },
                    );
                  }

                  if (futureSnapshot.data['type'] == "driver") {
                    profileList.add(
                      {
                        'name':
                            AppLocalizations.of(context).completedtasks + ':',
                        'value': futureSnapshot.data['completedTasks'] == null
                            ? '0'
                            : futureSnapshot.data['completedTasks'].toString()
                      },
                    );
                  }
                  //print(futureSnapshot.data['image_url']);

                  user = TKDUser.Users(
                    //  imageUrl: futureSnapshot.data['image_url'],
                    itemsDonated: futureSnapshot.data['itemsDonated'],
                    //  joinDate: DateTime.parse(futureSnapshot.data['joinDate']),
                    name: futureSnapshot.data['name'],
                    phoneNumber: futureSnapshot.data['phoneNumber'],
                    id: FirebaseAuth.instance.currentUser.uid,
                  );
                  print(user.name);

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    height: 80,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade400),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // The second edting(The pencil) for the profile picture.
                                        //
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            semanticLabel:
                                                "To change the profile pic",
                                            color: Palette.darkGreen,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'تغير الصوره الشخصيه',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        // InkWell(
                                                        //   onTap: () {
                                                        //     userProvider
                                                        //         .pickImageCamera()
                                                        //         .then((value) {
                                                        //       firebase_storage
                                                        //           .FirebaseStorage
                                                        //           .instance
                                                        //           .ref()
                                                        //           .child(
                                                        //               'users/${Uri.file(userProvider.file.path).pathSegments.last}')
                                                        //           .putFile(
                                                        //               userProvider
                                                        //                   .file)
                                                        //           .then(
                                                        //               (value) {
                                                        //         value.ref
                                                        //             .getDownloadURL()
                                                        //             .then(
                                                        //                 (value) {
                                                        //           userProvider
                                                        //               .updateUser(
                                                        //                   TKDUser
                                                        //                       .User(
                                                        //                     imageUrl:
                                                        //                         value,
                                                        //                     fcmToken:
                                                        //                         fcmToken,
                                                        //                     itemsDonated:
                                                        //                         futureSnapshot.data['itemsDonated'],
                                                        //                     joinDate:
                                                        //                         DateTime.parse(futureSnapshot.data['joinDate']),
                                                        //                     name:
                                                        //                         futureSnapshot.data['name'],
                                                        //                     phoneNumber:
                                                        //                         futureSnapshot.data['phoneNumber'],
                                                        //                     id: FirebaseAuth.instance.currentUser.uid,
                                                        //                   ),
                                                        //                   FirebaseAuth
                                                        //                       .instance
                                                        //                       .currentUser
                                                        //                       .uid);
                                                        //         });
                                                        //       });
                                                        //       Navigator.pop(
                                                        //           context);
                                                        //     });
                                                        //   },
                                                        //   child: Container(
                                                        //     child: Text(
                                                        //       'الكاميرا',
                                                        //       style: TextStyle(
                                                        //           color: Colors
                                                        //               .white),
                                                        //     ),
                                                        //     color: Palette
                                                        //         .darkGreen,
                                                        //   ),
                                                        // ),
                                                        MaterialButton(
                                                          onPressed: () {
                                                            userProvider
                                                                .pickImageCamera()
                                                                .then((value) {
                                                              firebase_storage
                                                                  .FirebaseStorage
                                                                  .instance
                                                                  .ref()
                                                                  .child(
                                                                      'users/${Uri.file(userProvider.file.path).pathSegments.last}')
                                                                  .putFile(
                                                                      userProvider
                                                                          .file)
                                                                  .then(
                                                                      (value) {
                                                                value.ref
                                                                    .getDownloadURL()
                                                                    .then(
                                                                        (value) {
                                                                  userProvider
                                                                      .updateUser(
                                                                          TKDUser
                                                                              .Users(
                                                                            imageUrl:
                                                                                value,
                                                                            fcmToken:
                                                                                fcmToken,
                                                                            itemsDonated:
                                                                                futureSnapshot.data['itemsDonated'],
                                                                            joinDate:
                                                                                DateTime.parse(futureSnapshot.data['joinDate']),
                                                                            name:
                                                                                futureSnapshot.data['name'],
                                                                            phoneNumber:
                                                                                futureSnapshot.data['phoneNumber'],
                                                                            id: FirebaseAuth.instance.currentUser.uid,
                                                                          ),
                                                                          FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .uid);
                                                                });
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          color:
                                                              Palette.darkGreen,
                                                          child: Text(
                                                            'الكاميرا',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        MaterialButton(
                                                          onPressed: () {
                                                            userProvider
                                                                .pickImageGallery()
                                                                .then((value) {
                                                              firebase_storage
                                                                  .FirebaseStorage
                                                                  .instance
                                                                  .ref()
                                                                  .child(
                                                                      'users/${Uri.file(userProvider.file.path).pathSegments.last}')
                                                                  .putFile(
                                                                      userProvider
                                                                          .file)
                                                                  .then(
                                                                      (value) {
                                                                value.ref
                                                                    .getDownloadURL()
                                                                    .then(
                                                                        (value) {
                                                                  userProvider
                                                                      .updateUser(
                                                                          TKDUser
                                                                              .Users(
                                                                            imageUrl:
                                                                                value,
                                                                            fcmToken:
                                                                                fcmToken,
                                                                            itemsDonated:
                                                                                futureSnapshot.data['itemsDonated'],
                                                                            joinDate:
                                                                                DateTime.parse(futureSnapshot.data['joinDate']),
                                                                            name:
                                                                                futureSnapshot.data['name'],
                                                                            phoneNumber:
                                                                                futureSnapshot.data['phoneNumber'],
                                                                            id: FirebaseAuth.instance.currentUser.uid,
                                                                          ),
                                                                          FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              .uid);
                                                                });
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          color:
                                                              Palette.darkGreen,
                                                          child: Text(
                                                            'المعرض',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'تراجع',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    ],
                                                    actionsPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                  );
                                                });
                                            //_edit('Image');
                                          },
                                        ),
                                        //  In the profile page, the personal picture.
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          padding: EdgeInsets.all(10),
                                          child: Stack(
                                            children: <Widget>[
                                              userProvider.isPickedImage
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Image.file(
                                                        userProvider.file,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.2,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: futureSnapshot
                                                                      .data[
                                                                  'imageUrl'] ==
                                                              ''
                                                          ? Image.asset(
                                                              'assets/images/profile.png',
                                                              //height: 100,
                                                              //width: 100,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.network(
                                                              futureSnapshot
                                                                      .data[
                                                                  'imageUrl'],
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.4,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.2,
                                                              fit: BoxFit.cover,

                                                              //fit: BoxFit.cover,
                                                            ),
                                                    ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(
                                                  width: 40,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 1,
                                                    horizontal: 6,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(futureSnapshot.data['name']),
                                        // This editing is for the name. (It is in the left side of the column.)
                                        IconButton(
                                          onPressed: () {
                                            _edit('Profile');
                                          },
                                          icon: Icon(Icons.edit),
                                          color: Palette.darkGreen,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  // Mydonations Button..
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: profileList.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                // decoration: BoxDecoration(
                                //   border: Border.all(width: 1),
                                // ),
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      profileList[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Expanded(
                                        child: Text(
                                      profileList[index]['value'].toString(),
                                      style: TextStyle(
                                          color: Palette.darkGreen,
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        //Two Boxes beside each other.
                        /*
                  Row(
                    children: [
                      Container(
                        width: 360,
                        height: 70,
                        decoration: BoxDecoration(),
                        child: RaisedButton(
                            color: Colors.green[800],
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyDonationsScreen())),
                            child: Text(
                              AppLocalizations.of(context).donations,
                            )),
                      ),
                    ],
                  ),
                  */
                        Divider(),
                        futureSnapshot.data['type'] == "donor"
                            ? Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: MaterialButton(
                                      color: Palette.darkGreen,
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyDonationsScreen())),
                                      child: Text(
                                          AppLocalizations.of(context)
                                              .donations,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ))),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                },
              )
            : LoginRequired());
  }

// showDialog(
// context: context,
// builder: (context) {
// return AlertDialog(
// title: Text('تغير الصوره الشخصيه'),
// content: userProvider.isPickedImage
// ? Container(
// height: 200,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: FileImage(userProvider.file),
// fit: BoxFit.fill,
// )),
// )
//     : Container(
// height: 200,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(25)),
// border: Border.all(color: Colors.grey, width: 3)),
// child: Icon(Icons.add),
// ),
// actions: [
// InkWell(
// onTap: () async {
// await userProvider.pickImage();
// },
// child: Text('المعرض'),
// ),
// Text('الكاميرا'),
// Text('تراجع')
// ],
// );
// });

}
