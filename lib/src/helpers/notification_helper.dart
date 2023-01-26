import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:lc_design/src/helpers/firebase_helper.dart';
import 'package:path_provider/path_provider.dart';

abstract class FCMNotificationListener {
  void didUpdateFCMToken(String token);
  void onClickNotification(Map<dynamic, dynamic> payload);
  void newNotificationOnForeground();
}

FCMNotificationListener? _delegate;


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await FirebaseHelper.instance.init();
  debugPrint("Handling a background message: ${message.messageId}");
}

class NotificationHelper {
  static final NotificationHelper instance = NotificationHelper._();

  NotificationHelper._();

  Future<String?> get fcmToken => _messaging.getToken();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _initializationSettingsAndroid =
      const AndroidInitializationSettings('app_icon');
  final AndroidNotificationChannel _channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.max,
  );

  Future<void> setup(FCMNotificationListener delegate) async {
    _delegate = delegate;
    if (Platform.isIOS) {
      await _messaging.requestPermission();
    }
    final androidNotification =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidNotification?.createNotificationChannel(_channel);
    if (Platform.isAndroid) {
      await androidNotification?.requestPermission();
      await _flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(android: _initializationSettingsAndroid),
        onDidReceiveBackgroundNotificationResponse: onSelectNotification,
        onDidReceiveNotificationResponse: onSelectNotification,
      );
    }
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _messaging.getInitialMessage().then((message) async {
      //event click notification
      if (message != null) {
        _delegate?.onClickNotification(message.data);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //event click notification
      _delegate?.onClickNotification(message.data);
    });
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
      _delegate?.newNotificationOnForeground();
    });
    _messaging.getToken().then((String? token) async {
      debugPrint(token ?? "");
      _delegate?.didUpdateFCMToken(token ?? "");
    });
    _messaging.onTokenRefresh.listen((String newToken) async {
      _delegate?.didUpdateFCMToken(newToken);
    });
  }

  static onSelectNotification(NotificationResponse detail) {
    final payload = detail.payload;
    if (payload != null) {
      final payloadJson = json.decode(payload) as Map<dynamic, dynamic>;
      _delegate?.onClickNotification(payloadJson);
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    var payload = json.encode(message.data);
    if (message.notification == null) {
      return;
    }
    if (Platform.isAndroid) {
      final random = Random();
      await _showNotificationAndroidStyleMedia(
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        message.notification?.android?.imageUrl ?? '',
        payload,
        id: random.nextInt(100000000),
      );
    }
  }

  Future<void> _showNotificationAndroidStyleMedia(
    String title,
    String message,
    String url,
    String payload, {
    int id = 0,
  }) async {
    String? largeIconPath;
    if (url != "") {
      largeIconPath = await _downloadAndSaveFile(url, 'largeIcon');
    }
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.max,
      priority: Priority.high,
      largeIcon:
          largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      message,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future<void> showNotificationLocal(
    String title,
    String message, {
    int code = 0,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      timeoutAfter: 10,
    );
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await _flutterLocalNotificationsPlugin.show(
      code,
      title,
      message,
      platformChannelSpecifics,
    );
  }

  Future<String> _downloadAndSaveFile(
    String url,
    String fileName,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
