import 'package:agendamento/controllers/task_controller.dart';
import 'package:agendamento/models/task.dart';
import 'package:agendamento/ui/theme.dart';
import 'package:agendamento/ui/widgets/button.dart';
import 'package:agendamento/ui/widgets/task_title.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/theme_services.dart';
import 'add_task_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            print(_taskController.taskList.length);
            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                    child: FadeInAnimation(
                        child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          _showBottomSheet(
                              context, _taskController.taskList[index]);
                        },
                        child: TaskTitle(_taskController.taskList[index]))
                  ],
                ))));
          });
    }));
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkGreyClr : Colors.white,
        child: Column(children: [
          Container(
            width: 120,
            height: 6,
            decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
          ),
          Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: 'Tarefa completa',
                  onTap: () {
                    Get.back();
                  },
                  clr: primaryClr,
                  context: context),
                  _bottomSheetButton(
                  label: 'Deletar tarefa',
                  onTap: () {
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  context: context),
                  SizedBox(
                    height: 20,
                  ),
                  _bottomSheetButton(
                  label: 'Fechar',
                  onTap: () {
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  isClose:true,
                  context: context),
                  SizedBox(
                    height: 10,
                  ),
        ])));
  }

  _bottomSheetButton(
      {required String label,
      required Function onTap,
      required Color clr,
      required BuildContext context,
      bool isClose = false}) {
    return GestureDetector(
        onTap:onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: isClose == true ? Colors.red : clr,
              ),
              borderRadius: BorderRadius.circular(20),
              color: isClose == true ? Colors.red : clr,
          ),
          child:Center(
            child: Text(
              label,
              style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
            ),
          )
        ));
  }

  _addDateBar() {
    return Container(
        margin: const EdgeInsets.only(left: 20, top: 10),
        child: DatePicker(DateTime.now(),
            height: 100,
            width: 80,
            initialSelectedDate: DateTime.now(),
            selectionColor: primaryClr,
            selectedTextColor: Colors.white,
            dateTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Get.isDarkMode ? Colors.white : Colors.black)),
            dayTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Get.isDarkMode ? Colors.white : Colors.black)),
            monthTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Get.isDarkMode ? Colors.white : Colors.black)),
            onDateChange: (date) {
          _selectedDate = date;
        }));
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  'Today',
                  style: headingStyle,
                )
              ],
            ),
          ),
          MyButton(
              label: "+ Adicionar Agendamento",
              onTap: () async {
                await Get.to(() => AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
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
