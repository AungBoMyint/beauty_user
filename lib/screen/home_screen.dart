import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/screen/shop.dart';
import 'package:kozarni_ecome/screen/view/hot.dart';
import 'package:kozarni_ecome/screen/view/home.dart';
import 'package:kozarni_ecome/widgets/bottom_nav.dart';
import 'package:kozarni_ecome/widgets/home_appbar/home_app_bar.dart';

import 'view/profile.dart';

List<Widget> _template = [
  HomeView(),
  Shop(),
  HotView(),
  // BrandView(),
  // CartView(),
  // FavouriteView(),
  ProfileView(),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? fltNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notitficationPermission();
    initMessaging();
  }

  void notitficationPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void initMessaging() async {
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInit = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification!.initialize(initSetting);

    if (messaging != null) {
      print('vvvvvvv');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  void showNotification(RemoteMessage message) async {
    var androidDetails = AndroidNotificationDetails(
      '1',
      message.notification!.title ?? '',
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF0f90f3),
    );
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await fltNotification!.show(0, message.notification!.title ?? '',
        message.notification!.body ?? '', generalNotificationDetails,
        payload: 'Notification');
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(),
      body: Obx(
        () => _template[controller.navIndex.value],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
