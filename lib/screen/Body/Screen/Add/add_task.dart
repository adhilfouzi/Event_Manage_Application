import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/database/functions/fn_taskmodel.dart';
import 'package:project_event/database/model/task/task_model.dart';
import 'package:project_event/screen/body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/body/widget/list/categorydropdown.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:project_event/screen/body/widget/sub/date.dart';
import 'package:project_event/screen/body/widget/sub/status.dart';

import 'package:sizer/sizer.dart';

class AddTask extends StatefulWidget {
  final int eventID;

  const AddTask({super.key, required this.eventID});

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
        appBar: CustomAppBar(
          actions: [
            AppAction(
                icon: Icons.done,
                onPressed: () {
                  addTaskclick(context);
                }),
          ],
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

      setState(() {
        _statusController = 0;
        _tasknameController.clear();
        _categoryController.clear();
        _dateController.clear();
        _noteController.clear();
      });

      ScaffoldMessenger.of(mtx).showSnackBar(
        SnackBar(
          content: const Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(2.h),
          backgroundColor: Colors.greenAccent,
          duration: const Duration(seconds: 2),
        ),
      );
      Get.back();
    } else {
      ScaffoldMessenger.of(mtx).showSnackBar(
        SnackBar(
          content: const Text("Fill the Task Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(2.h),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
