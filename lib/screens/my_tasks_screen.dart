import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';
import '../widgets/task_item.dart';
import '../widgets/empty_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task.dart';

class MyTasksScreen extends StatelessWidget {
  List<dynamic> tasks;
  var notCompletedOrCancelled;
  @override
  Widget build(BuildContext context) {

    final tasksProvider = Provider.of<TasksProvider>(context);
    print(FirebaseAuth.instance.currentUser.uid);
    return Scaffold(
        body: StreamBuilder(
            stream: tasksProvider
              // .fetchAllTasksAsStream(),
              .fetchTasksAsStream(FirebaseAuth.instance.currentUser.uid),
            // stream:tasksProvider.fetchAllTasksAsStream() ,
            builder: (ctx, donationsSnapshot) {
              if (donationsSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (donationsSnapshot.hasData) {
               // print(tasks.length);
                print('mmmmmmmmmmmmmmmmm///////////');

                tasks = donationsSnapshot.data.docs
                    .map((doc) => Task.fromMap(doc.data(), doc.id))
                    .toList();

                // tasks = donationsSnapshot
                //     .data
                //     .docs
                //     .map((doc) => Task.fromMap(doc.data(), doc.id))
                //     .toList();
                 notCompletedOrCancelled = tasks
                    .where(
                      (element) =>
                  element.status != "Completed" &&
                      element.status != "Cancelled",
                )
                    .toList();
              } else {
                return Center(child:CircularProgressIndicator.adaptive() ,) ;
              }
             // print(tasks[0]['driverId']);
               print(tasks);
              return tasks.isEmpty
                  ? EmptyList(false)
                  :
              Container(
                      padding: EdgeInsets.only(top: 30, right: 10),
                      child: ListView.builder(
                        itemCount: notCompletedOrCancelled.length,
                        itemBuilder: (buildContext, index) {
                          return Container(
                            child: TaskItem(notCompletedOrCancelled[index]),
                          );
                        },
                      ),
                    );
            }));
  }
}
