// Driver home page
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tadweer_alkheer/models/task.dart';
import 'package:tadweer_alkheer/models/user.dart' as TKDUser;
import 'package:tadweer_alkheer/providers/users_provider.dart';
import '../models/user.dart';
import '../providers/tasks_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DriverHomeScreen extends StatelessWidget {
  List<dynamic> tasks;

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final userProvider = Provider.of<UsersProvider>(context);
    List<dynamic> newTasks;
    List<dynamic> completed;
    List<dynamic> cancelled;
    Users user;
    return Scaffold(
        body: FutureBuilder(
            future:
                userProvider.getUserById(FirebaseAuth.instance.currentUser.uid),
            builder: (ctx, userData) {
              if (userData.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              user = userData.data;

              return StreamBuilder(
                stream: tasksProvider
                    .fetchTasksAsStream(FirebaseAuth.instance.currentUser.uid),
                builder: (ctx, tasksSnapshot) {
                  if (tasksSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (tasksSnapshot.hasData) {
                    //  print(tasksSnapshot.data.);
                    tasks = tasksSnapshot.data.docs
                        .map((doc) => Task.fromMap(doc.data(), doc.id))
                        .toList();
                    print(tasks.length);
                    newTasks = tasks
                        .where(
                          (element) =>
                              element.status == "Ongoing" ||
                              element.status == "Pickedup" ||
                              element.status == "Delivered",
                        )
                        .toList();
                    completed = tasks
                        .where(
                          (element) => element.status == "Completed",
                        )
                        .toList();
                    cancelled = tasks
                        .where(
                          (element) => element.status == "Cancelled",
                        )
                        .toList();
                    print('${newTasks.length}/////////////////////////////');
                    List<Map<String, Object>> _groups = [
                      {
                        "name": AppLocalizations.of(context).currenttasks,
                        "number": newTasks.length,
                        "color": Colors.grey
                      },
                      {
                        "name": AppLocalizations.of(context).completedtasks,
                        "number": completed.length,
                        "color": Colors.blue[800],
                      },
                      {
                        "name": AppLocalizations.of(context).cancelledtasks,
                        "number": cancelled.length,
                        "color": Colors.yellow
                      },
                      {
                        "name": AppLocalizations.of(context).alltasks,
                        "number": tasks.length,
                        "color": Colors.lightGreen.shade900,
                      }
                    ];
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 20),

                        // Center(
                        //   child: Card(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(15),
                        //     ),
                        //     elevation: 4,
                        //     margin: EdgeInsets.all(10),
                        //     child: Container(
                        //       //color: Theme.of(context).primaryColor,
                        //       width: MediaQuery.of(context).size.width * 0.9,
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 20, horizontal: 30),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(15),
                        //         color: Theme.of(context).primaryColor,
                        //       ),
                        //       child: Row(
                        //         children: [
                        //           // user.displayName==null?Expanded(
                        //           //   child: Text(
                        //           //     'user.displayName',
                        //           //     style: TextStyle(
                        //           //         color: Colors.white,
                        //           //         fontSize: 18),
                        //           //   ),
                        //           // ):
                        //           Expanded(
                        //             child: Text(
                        //               user.name,
                        //               style: TextStyle(
                        //                   color: Colors.white, fontSize: 18),
                        //             ),
                        //           ),
                        //           SizedBox(
                        //             width: 10,
                        //           ),
                        //           // ClipRRect(
                        //           //   borderRadius:
                        //           //   BorderRadius.circular(
                        //           //       15),
                        //           //   child: futureSnapshot
                        //           //       .data[
                        //           //   'imageUrl'] ==
                        //           //       ''
                        //           //       ? Image.asset(
                        //           //     'assets/images/profile.png',
                        //           //     //height: 100,
                        //           //     //width: 100,
                        //           //     fit: BoxFit.cover,
                        //           //   )
                        //           //       : Image.network(
                        //           //     futureSnapshot
                        //           //         .data[
                        //           //     'imageUrl'],
                        //           //     width: MediaQuery.of(
                        //           //         context)
                        //           //         .size
                        //           //         .width *
                        //           //         0.4,
                        //           //     height: MediaQuery.of(
                        //           //         context)
                        //           //         .size
                        //           //         .height *
                        //           //         0.2,
                        //           //     fit: BoxFit.cover,
                        //           //
                        //           //     //fit: BoxFit.cover,
                        //           //   ),
                        //           // ),
                        //           Container(
                        //             // color: Colors.yellow,
                        //             //  child: Column(
                        //             //    children: [
                        //             //      Text('${user.fcmToken}'),
                        //             //
                        //             //    ],
                        //             //  ),
                        //             height: 50,
                        //             width: 50,
                        //             decoration: BoxDecoration(
                        //                 image: DecorationImage(
                        //                     image: NetworkImage(
                        //               user.imageUrl == ''
                        //                   ? 'https://i.im.ge/2022/11/02/2VnvCC.1200px-User-icon-cp-svg.png'
                        //                   : user.imageUrl,
                        //             ))),
                        //           )
                        //           // ClipRRect(
                        //           //   borderRadius: BorderRadius.circular(15),
                        //           //   child: user.imageUrl == null
                        //           //       ? Image.asset(
                        //           //           'assets/images/profile.png',width: 50,
                        //           //     height: 50,)
                        //           //       : Image.network(
                        //           //           user.imageUrl,
                        //           //           width: 50,
                        //           //           height: 50,
                        //           //           fit: BoxFit.cover,
                        //           //         ),
                        //           // ),
                        //           // CircleAvatar(
                        //           //   radius: 40,
                        //           //   // backgroundColor: Colors.grey,
                        //           //   backgroundImage: user.imageUrl != null
                        //           //       ? NetworkImage(user.imageUrl)
                        //           //       : AssetImage(
                        //           //           'assets/images/profile.png'),
                        //           // ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Center(
                          child: Container(
                            // color: Colors.yellow,
                            //  child: Column(
                            //    children: [
                            //      Text('${user.fcmToken}'),
                            //
                            //    ],
                            //  ),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                              user.imageUrl == ''
                                  ? 'https://i.im.ge/2022/11/02/2VnvCC.1200px-User-icon-cp-svg.png'
                                  : user.imageUrl,
                            ))),
                          ),
                        ),
                           SizedBox(height: 15,),
                        Text(
                          '${user.name} ',
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                        ),

                        // Expanded(
                        //   child: GridView.builder(
                        //     padding: EdgeInsets.all(12),
                        //     gridDelegate:
                        //         SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 2,
                        //       childAspectRatio: 0.9,
                        //       crossAxisSpacing: 10,
                        //       mainAxisSpacing: 20,
                        //     ),
                        //     //reverse: true,
                        //     itemCount: _groups.length,
                        //     itemBuilder: (ctx, index) => Container(
                        //       decoration: BoxDecoration(
                        //           border:
                        //               Border.all(width: 1, color: Colors.grey),
                        //           borderRadius: BorderRadius.circular(12)),
                        //       child: ClipRRect(
                        //         borderRadius: BorderRadius.circular(10),
                        //         child: GridTile(
                        //           child: GestureDetector(
                        //             onTap: () {
                        //               // Navigator.of(context).pushNamed(
                        //               //   AddDonationScreen.routeName,
                        //               //   arguments: categories[index].name,
                        //               // );
                        //             },
                        //             child: Container(
                        //               padding: EdgeInsets.only(bottom: 20),
                        //               color: _groups[index]['color'],
                        //               child: Center(
                        //                 child: Text(
                        //                   _groups[index]['number'].toString(),
                        //                   style: TextStyle(
                        //                       fontSize: 30,
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //           footer: GridTileBar(
                        //             backgroundColor: _groups[index]['color'],
                        //             title: Text(
                        //               _groups[index]['name'],
                        //               style: TextStyle(color: Colors.black),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                           child: ListView.separated(itemBuilder:(context,index){
                             return donationContainer(context:context, name:_groups[index]['name'], number:_groups[index]['number']);
                           }, separatorBuilder: (context,index){
                             return SizedBox();
                           }, itemCount:  _groups.length),)
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }));
  }
  Widget donationContainer({BuildContext context, String name, int number}){
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Theme.of(context).primaryColor)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(25),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    number.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    //textAlign: TextAlign.center,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(25),
                    border: Border.all(
                        color: Theme.of(context)
                            .primaryColor)),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
