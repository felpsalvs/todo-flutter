
class NotifyHelper{
FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    //tz.initializeTimeZones();
   // this is for latest iOS settings
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

 final AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
       iOS: initializationSettingsIOS,
       android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification: selectNotification);

  }

}