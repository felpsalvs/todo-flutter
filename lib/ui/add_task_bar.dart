import 'package:agendamento/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor, 
      appBar: _appBar(context), 
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Text(
              'Adicionar Agendamento',
              style: headingStyle,
            )
          ],)
      ));
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
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
        ),
      ],
    );
  }
}
