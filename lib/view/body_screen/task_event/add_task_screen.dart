import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/db_functions/fn_taskmodel.dart';
import 'package:project_event/model/data_model/task/task_model.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/services/categorydropdown_widget.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/controller/widget/sub/date_widget.dart';
import 'package:project_event/controller/widget/sub/status_button_widget.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';
import 'package:project_event/view/body_screen/task_event/task_screen.dart';

import 'package:sizer/sizer.dart';

class AddTask extends StatefulWidget {
  final int eventID;
  final Eventmodel eventModel;

  const AddTask({super.key, required this.eventID, required this.eventModel});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    log(widget.eventID.toString());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBar(
          actions: [],
          titleText: 'Add Task',
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(2.h),
            child: Column(children: [
              TextFieldBlue(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Task name is required';
                    }
                    return null;
                  },
                  keyType: TextInputType.name,
                  textcontent: 'Task Name',
                  controller: _tasknameController),
              CategoryDown(
                onCategorySelected: (String value) {
                  _categoryController.text = value;
                },
              ),
              TextFieldBlue(textcontent: 'Note', controller: _noteController),
              StatusBar(
                textcontent1: 'Pending',
                textcontent2: 'Completed',
                onStatusChange: (bool status) {
                  _statusController = status == true ? 1 : 0;
                },
              ),
              Date(
                controller: _dateController,
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.all(2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 4.h),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(buttoncolor),
                        ),
                        onPressed: () {
                          addTaskclick(context);
                        },
                        child: Text(
                          'Add Task',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  final TextEditingController _tasknameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int _statusController = 0;
  final TextEditingController _dateController = TextEditingController();

  Future<void> addTaskclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final taskdata = TaskModel(
          taskname: _tasknameController.text.toUpperCase(),
          category: _categoryController.text,
          status: _statusController,
          note: _noteController.text,
          date: _dateController.text,
          eventid: widget.eventID);
      await addTask(taskdata).then((value) => log("success "));
      SnackbarModel.successSnack();
      Get.off(TaskList(eventid: widget.eventID, eventModel: widget.eventModel));
    } else {
      SnackbarModel.errorSnack();
    }
  }
}
