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
  String _endTime = '9:30 PM';
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(context),
        body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(children: [
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
                  icon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
                  onPressed: () {
                    print('oi');
                    _getDateFromUser();
                  },
                ),
              ),
              Row(children: [
                Expanded(
                    child: MyInputField(
                        title: 'Data de inicio',
                        hint: _startTime,
                        widget: IconButton(
                            onPressed: () {
                              _getTimeFromUser(isStartTime: true);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            )))),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: MyInputField(
                        title: 'Data do fim',
                        hint: _endTime,
                        widget: IconButton(
                            onPressed: () {
                              _getTimeFromUser(isStartTime: false);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ))))
              ]),
              MyInputField(
                title: 'Lembrete',
                hint: '$_selectedRemind minutes early',
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                        value: value.toString(), child: Text(value.toString()));
                  }).toList(),
                ),
              ),
              MyInputField(
                title: 'Repetir',
                hint: '$_selectedRepeat',
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value!, style: TextStyle(color: Colors.grey)));
                  }).toList(),
                ),
              ),
              Row(children: [
                Column(
                  children: [
                    Text(
                      'Color',
                      style: titleStyle,
                    ),
                    Wrap(
                        children: List<Widget>.generate(
                          3, 
                          (int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.grey,
                        ),
                      );
                    }))
                  ],
                )
              ])
            ])));
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

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('cancelado');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(':')[0]),
          minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
        ));
  }
}
