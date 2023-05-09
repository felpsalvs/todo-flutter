import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/notification_services.dart';
import '../services/theme_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Column(children: const [
          Text(
            'Welcome to Flutter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]));
  }

  _appBar() {
    return AppBar(
        backgroundColor: context.theme.backgroundColor,
        leading: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();
            notifyHelper.displayNotification(
                title: "Theme Changed",
                body: Get.isDarkMode
                    ? "Activated Dark Mode"
                    : "Activated Light Mode");

            notifyHelper.scheduledNotification();
          },
          child: Icon(Get.isDarkMode ? Icons.wb_sunny_outlined :
            Icons.nightlight_round,
            size: 20,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              "images/unnamed.png",
            ),
          ),
          SizedBox(
            width: 20,
          )
        ]);
  }
}
