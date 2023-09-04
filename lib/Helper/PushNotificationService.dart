import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:sellermultivendor/Helper/ApiBaseHelper.dart';
import '../Provider/settingProvider.dart';
import '../Screen/OrderDetail/OrderDetail.dart';
import '../Widget/api.dart';
import '../Widget/routes.dart';
import '../Widget/sharedPreferances.dart';
import '../Widget/parameterString.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
FirebaseMessaging messaging = FirebaseMessaging.instance;

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

class PushNotificationService {
  late BuildContext context;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

  PushNotificationService({required this.context});

//==============================================================================
//============================= initialise =====================================
  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    Routes.navigateToMyApp(context);
  }

  Future initialise() async {
    iOSPermission();
    messaging.getToken().then(
      (token) async {
        print("token firebase****$token");
        if (context.read<SettingProvider>().CUR_USERID != null ||
            context.read<SettingProvider>().CUR_USERID != "") {

          _registerToken(token);
        }
      },
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings();
    DarwinInitializationSettings initializationSettingsMacOS =
        const DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        List<String> pay = notificationResponse.payload!.split(',');
        if (pay[0] == 'order' || pay[1] != '') {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => OrderDetail(
                id: pay[1],
              ),
            ),
          );
        } else {
          Routes.navigateToMyApp(context);
        }

        /* switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            break;
        }*/
      },
    );

//==============================================================================
//============================= onMessage ======================================
// when app in foreground (running state) (open)

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        var data = message.notification!;
        var title = data.title.toString();
        var body = data.body.toString();
        var type = message.data['type'];
        var orderId = message.data['order_id'] ?? '';

        generateSimpleNotication(title, body, type, orderId);

      },
    );

//==============================================================================
//============================= onMessage ======================================
// when app in terminated state

    messaging.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        print("notification message initial****${message.data.toString()}");
        var orderId = message.data['order_id'] ?? '';
        bool back = await getPrefrenceBool(iSFROMBACK);
        if (back) {
          if (orderId != '') {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => OrderDetail(
                  id: orderId,
                ),
              ),
            );
          } else {
            Routes.navigateToMyApp(context);
          }
        }
      }
    });

//==============================================================================
//========================= onMessageOpenedApp =================================
// when app is background

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        print(
            "notification message on message open app****${message.data.toString()}");
        var type = message.data['type'] ?? '';
        var orderId = message.data['order_id'] ?? '';
        if (orderId != '') {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => OrderDetail(
                id: orderId,
              ),
            ),
          );
        } else {
          Routes.navigateToMyApp(context);
        }

        setPrefrenceBool(iSFROMBACK, false);
      },
    );
  }

//==============================================================================
//========================= iOSPermission ======================================
//done

  void iOSPermission() async {
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

//==============================================================================
//========================= _registerToken =====================================

  void _registerToken(String? token) async {
    var parameter = {
      'user_id': context.read<SettingProvider>().CUR_USERID,
      FCMID: token,
    };
    apiBaseHelper.postAPICall(updateFcmApi, parameter).then(
          (getdata) async {},
          onError: (error) {},
        );
  }
}

//done above

//==============================================================================
//========================= myForgroundMessageHandler ==========================

Future<dynamic> myForgroundMessageHandler(RemoteMessage message) async {
  await setPrefrenceBool(iSFROMBACK, true);
  bool back = await getPrefrenceBool(iSFROMBACK);
  return Future<void>.value();
}

//==============================================================================
//========================= generateSimpleNotication ===========================

Future<void> generateSimpleNotication(
    String title, String body, String type, String payload) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
    playSound: true,
  );
  var iosDetail = const DarwinNotificationDetails();

  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics, iOS: iosDetail);
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: '$type,$payload',
  );
}

//==============================================================================
//==============================================================================
