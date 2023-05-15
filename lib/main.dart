import 'package:agendamento/db/db_helper.dart';
import 'package:agendamento/services/theme_services.dart';
import 'package:agendamento/ui/home_page.dart';
import 'package:agendamento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Adicione esta linha:
  await DBHelper.initDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Agendamento',
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
        home: const HomePage());
  }
}
