import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    leading: GestureDetector(
      onTap: () {
        print('Menu');
      },
      child: Icon(Icons.nightlight_round,
      size: 20,),
    ),
    actions: [
      Icon(Icons.person,
      size: 20,),
      SizedBox(width: 20,),
    ]
  );
}
}
