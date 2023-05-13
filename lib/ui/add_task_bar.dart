import 'package:agendamento/ui/theme.dart';
import 'package:agendamento/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime='9:30 PM';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
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
                ),
                MyInputField(title: 'Titulo', hint: 'Digite seu titulo'),
                MyInputField(title: 'Observação', hint: 'Digite sua observação'),
                MyInputField(
                  title: 'Data',
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon:
                        Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    onPressed: () {
                      print('oi');
                      _getDateFromUser();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: 'Data de inicio',
                        hint: _startTime,
                        widget: IconButton(
                          onPressed: (){

                          },
                          icon: Icon(
                            Icons.access_time_rounded,
                            color:Colors.grey,
                          )
                        )
                      )
                    )
                  ]
                )
              ],
            )));
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

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print('oi');
    }
  }
}
