

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// pushNotification(String title,String body){
//
// }
const AndroidNotificationChannel channel=AndroidNotificationChannel(
  'my_channel',
  'my channel',
    importance: Importance.high,

);
class NotificationHelper{
  static Future init()async{
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification=message.notification;
      AndroidNotification android=message.notification?.android;
      if (notification != null && android != null) {
        // IOSNotificationDetails(
        //   presentBadge: true,
        // );
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,

            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: 'ic_launcher.png',
                channelShowBadge: true
              ),
            ));
      }
    });
  }

}
