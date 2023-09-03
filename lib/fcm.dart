import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'locator.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
   await Firebase.initializeApp();
  _onMessageStreamController.add(message.data);
   // FlutterLocalNotificationsPlugin _notificationsPlugin;
   // _notificationsPlugin = FlutterLocalNotificationsPlugin();
   //
   // _notificationsPlugin
   //     .resolvePlatformSpecificImplementation<
   //     IOSFlutterLocalNotificationsPlugin>()
   //     ?.requestPermissions(
   //   alert: true,
   //   badge: true,
   //   sound: true,
   // );
   // var android = AndroidInitializationSettings('@mipmap/ic_launcher');
   // var ios = IOSInitializationSettings(
   //     defaultPresentBadge: true,
   //     defaultPresentAlert: true,
   //     defaultPresentSound: true);
   // var initSetting = InitializationSettings(android: android, iOS: ios);
   // _notificationsPlugin.initialize(initSetting,
   //     onSelectNotification: onSelectNotificationBackGround
   // );
  print("Handling a background message: ${message.data}");
}

StreamController<Map<String, dynamic>> _onMessageStreamController =
StreamController.broadcast();

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void killNotification() {
    _onMessageStreamController.close();
  }

  FlutterLocalNotificationsPlugin _notificationsPlugin;

  Map<String, dynamic> _not;

  Future<void> setUpFirebase() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    // checkLastMessage();
    firebaseCloudMessagingListeners();

    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = IOSInitializationSettings(
        defaultPresentBadge: true,
        defaultPresentAlert: true,
        defaultPresentSound: true);
    var initSetting = InitializationSettings(android: android, iOS: ios);
    _notificationsPlugin.initialize(initSetting,
      onSelectNotification: onSelectNotification
    );
  }

  // Future<void> checkLastMessage() async {
  //   RemoteMessage initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();

  //   if (initialMessage != null) {
  //     print(initialMessage.data.toString());
  //     handlePath(initialMessage.data);
  //   }
  // }

  Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print("TOOOKEN" + token);
      fcmToken = token;
      print(fcmToken);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage data) {
      print('on message ${data.data['order_id']}');
      print('on message notification body ${data.notification.body}');
      print('on message notification title ${data.notification.title}');
      _onMessageStreamController.add(data.data);

      _not = data.data;

      showNotification(
          data.data, data.notification.title, data.notification.body);
      // if (Platform.isAndroid) {
      //   showNotificationWithAttachment(data.data, data.notification.title,
      //       data.notification.body, data.notification.android.imageUrl);
      // } else {
      //   showNotificationWithAttachment(data.data, data.notification.title,
      //       data.notification.body, data.notification.apple.imageUrl);
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
      print('on Opened ' + data.data.toString());

      handlePath(data.data);
    });
  }

  showNotification(
      Map<String, dynamic> _message, String title, String body) async {
    print("Notification Response : $_message");

    var androidt = AndroidNotificationDetails(
        'تدوير الخير', 'channel_name',
        priority: Priority.high,
        channelShowBadge: true,
        playSound: true,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher",
        enableVibration: true,
        enableLights: true,
        importance: Importance.max);
    var iost = IOSNotificationDetails();
    var platform = NotificationDetails(android: androidt, iOS: iost);
    await _notificationsPlugin.show(0, title, body, platform, payload: "");
  }

  Future<void> showNotificationWithAttachment(Map<String, dynamic> _message,
      String title, String body, String imageUrl) async {
    print("Notification Response : $_message");
    var attachmentPicturePath = await _downloadAndSaveFile(
        imageUrl ?? 'https://via.placeholder.com/800x200',
        'attachment_img.jpg');
    var iOSPlatformSpecifics = IOSNotificationDetails(
      attachments: [IOSNotificationAttachment(attachmentPicturePath)],
    );
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachmentPicturePath),
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: '$body',
      htmlFormatSummaryText: true,
    );
    var androidChannelSpecifics = AndroidNotificationDetails(
      'تدوير الخير',
      'channel_name',
      //'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    var notificationDetails = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
    print("notificationDetails $notificationDetails");
    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  void iOSPermission() {
    _firebaseMessaging.requestPermission(
        alert: true, announcement: true, badge: true, sound: true);
  }

  void handlePath(
      Map<String, dynamic> dataMap,
      ) {
    // handlePathByRoute(
    //   dataMap,
    // );
  }

  // Future<void> handlePathByRoute(
  //     Map<String, dynamic> dataMap,
  //     ) async {
  //   print(dataMap);
  //   String orderId = dataMap["order_id"].toString();
  //   String userId = dataMap["user_id"].toString();
  //   String supplierId = dataMap["provider_id"].toString();
  //   String roomId = dataMap["chat_id"].toString();
  //   String type = dataMap["type"].toString();
  //
  //   print(orderId);
  //   print(userId);
  //   print(supplierId);
  //   print(roomId);
  //   if (type == '6') {
  //     navigateForward(
  //         ChatScreen(
  //           orderId: orderId,
  //           chatId: roomId,
  //           supplierId: supplierId,
  //           userId: userId,
  //         )
  //     );
  //   }else if(supplierId == '9' || type =='1'){
  //     navigateForward(NotificationScreen(
  //
  //     ));
  //   }
  //   else{
  //     navigateForward(DetailsScreen(
  //       orderId: orderId,
  //       userId: userId,
  //       roomId: roomId,
  //       supplierId: supplierId,
  //     ));
  //   }
  //
  // }

 Future<void> onSelectNotification(String payload) async {
    print(payload.toString());
  //  handlePath(_not);
   // _ourAppUrlAndroid() async {
    if(Platform.isIOS){
      const url =
          'https://apps.apple.com/sa/app/%D8%AA%D8%AF%D9%88%D9%8A%D8%B1-%D8%A7%D9%84%D8%AE%D9%8A%D8%B1/id1603250576';

      if (await canLaunch(url)) {
        await launch(url,forceWebView: false,forceSafariVC: false,enableJavaScript: false);
      } else {
        throw 'Could not launch $url';
      }
    }else{
      const url =
          'https://play.google.com/store/apps/details?id=com.tadweer.alkheer';
      if (await canLaunch(url)) {
        await launch(url,forceWebView: false,forceSafariVC: false,enableJavaScript: false);
      } else {
        throw 'Could not launch $url';
      }
    }

   // }
  }
}
Future<void> onSelectNotificationBackGround(String payload) async {
  print(payload.toString());
  //  handlePath(_not);
  // _ourAppUrlAndroid() async {
  if(Platform.isIOS){
    const url =
        'https://apps.apple.com/sa/app/%D8%AA%D8%AF%D9%88%D9%8A%D8%B1-%D8%A7%D9%84%D8%AE%D9%8A%D8%B1/id1603250576';

    if (await canLaunch(url)) {
      await launch(url,forceWebView: false,forceSafariVC: false,enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }else{
    const url =
        'https://play.google.com/store/apps/details?id=com.tadweer.alkheer';
    if (await canLaunch(url)) {
      await launch(url,forceWebView: false,forceSafariVC: false,enableJavaScript: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  // }
}