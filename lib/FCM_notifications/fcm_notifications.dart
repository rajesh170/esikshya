import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:esikshya/data/app_shared_preferences.dart';
import 'package:esikshya/views/common/bottom_nav_bar_screen.dart';
import 'package:esikshya/views/notifications_screen/notification_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
  if (message.notification != null) {
    log(message.notification!.title.toString());
    log(message.notification!.body.toString());
    localNotification(message);
  }
}

class FcmNotifications {
  static Future<void> initialise() async {
    AppSharedPreferences _appSharedPreferences =
        Get.put(AppSharedPreferences());
    var isUserChild = await _appSharedPreferences.getChildAccessToken();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    var token = await messaging.getToken(); // This Creates a FirebaseToken
    log("Token = $token");
    if (token != null) {
      await _appSharedPreferences.saveFCMToken(token.toString());
    }

//requesting permission from device
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
      carPlay: false,
    );
    log("user granted permission: ${settings.authorizationStatus}");

    // handles missed notification and is must important one
    RemoteMessage? getInitMessage = await messaging.getInitialMessage();
    if (getInitMessage?.notification != null) {
      localNotification(getInitMessage);
    }

    //if app is background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("On MessageOpenedApp ${message.data}");
      if (message.notification != null) {
        localNotification(message);
      }
    });

    //if app is running on foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("On Message ${message.notification!.body}");
      log("On Message ${message.notification!.title}");
      if (message.notification != null) {
        localNotification(message);
      }

      // if(message.data["value"] == 'GameNotification'){

      //   Get.to( ()=> NotificationScreen(isUserChild: isUserChild!=""));
      //   // Navigator.push(context,MaterialPageRoute(builder: (context){return const ScreenA();}) );
      // }
    });

    //if app is terminated or closed
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}

localNotification(RemoteMessage? remoteMessage) async {
  try {
    print(remoteMessage?.data.toString());
    log(remoteMessage?.data.toString() ?? "");
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidNotificationSound mysound;
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'gadi_bazaar_channel_id', // id
      'gadi_bazaar_channel_name', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
      playSound: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIos,
    );
    var isUserChild =
        await Get.find<AppSharedPreferences>().getChildAccessToken();

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      if (remoteMessage?.data["value"] == 'GameNotification') {
        Get.offAll(() => BottomNavBarScreen(
              isUserChild: isUserChild != "",
              index: 1,
            ));
      }
    });

    RemoteNotification? notification = remoteMessage?.notification;
    AndroidNotification? android = remoteMessage?.notification?.android;
    if (notification != null && android != null) {
      await _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
              priority: Priority.max,
              importance: Importance.max,
            ),
          ),
          payload: "I am Payload");
    }

//For IOS No set up has been made -----///

  } catch (e) {
    Get.snackbar("Exception", e.toString());
  }
}
