import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class LocalNotifications  with ChangeNotifier {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  late AndroidInitializationSettings androidInitializationSettings;
  late IOSInitializationSettings iosInitializationSettings;
  late InitializationSettings initializationSettings;


  void initializing() async {
    androidInitializationSettings =
    const AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotifications() async {
    await notification();
  }

  void showNotificationsAfterSecond() async {
    await notificationAfterSec();
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
        'Channel ID', 'Channel title',
        priority: Priority.high,
        importance: Importance.max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = const IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        0, 'Thông báo', 'Có vẻ hôm nay thời tiết rất tốt',
        notificationDetails);
  }

  Future<void> notificationAfterSec() async {
    var timeDelayed = DateTime.now().add(const Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
        'second channel ID', 'second Channel title',
        priority: Priority.high,
        importance: Importance.max,
        ticker: 'test');

    IOSNotificationDetails iosNotificationDetails = const IOSNotificationDetails();

    NotificationDetails notificationDetails =
    NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(1, 'Thông báo',
        'Nhiệt độ ngoài trời hôm nay rất nóng', timeDelayed,
        notificationDetails);
  }


  Future onDidReceiveLocalNotification(int? id, String? title, String? body,
      String? payload) async {
    return CupertinoAlertDialog(
      title: Text(title ?? ''),
      content: Text(body ?? ''),
      actions: <Widget>[
        CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
            },
            child: const Text("Okay")),
      ],
    );
  }
}