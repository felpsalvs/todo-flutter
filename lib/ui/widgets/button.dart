import 'package:agendamento/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 120,
          height: 60,
          decoration: BoxDecoration(
            color: primaryClr,
            borderRadius: BorderRadius.circular(20),
          ),
          child:Text(
            label,
            style: TextStyle(
              color:Colors.white,
            )
          )
        ));
  }
}
