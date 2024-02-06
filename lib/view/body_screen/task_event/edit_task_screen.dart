import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/db_functions/fn_taskmodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/task/task_model.dart';
import 'package:project_event/view/body_screen/task_event/search_tasklist_screen.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/services/categorydropdown_widget.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/controller/widget/sub/date_widget.dart';
import 'package:project_event/controller/widget/sub/status_button_widget.dart';

import 'package:sizer/sizer.dart';

class EditTask extends StatefulWidget {
  final Eventmodel eventModel;

  final TaskModel taskdata;

  const EditTask({super.key, required this.taskdata, required this.eventModel});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(actions: [
          AppAction(
              icon: Icons.delete,
              onPressed: () {
                dodeletetask(context, widget.taskdata, 2, widget.eventModel);
              }),
          AppAction(
              icon: Icons.done,
              onPressed: () {
                edittaskclicked(context, widget.taskdata);
                Get.back();
              })
        ], titleText: 'Edit Task'),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.5.h),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFieldBlue(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Task name is required';
                    }
                    return null; // Return null if the input is valid
                  },
                  keyType: TextInputType.name,
                  textcontent: 'Task Name',
                  controller: _tasknameController),
              CategoryDown(
                defaultdata: _categoryController.text,
                onCategorySelected: (String value) {
                  _categoryController.text = value;
                },
              ),
              TextFieldBlue(textcontent: 'Note', controller: _noteController),
              StatusBar(
                defaultdata: _statusController == 1 ? true : false,
                textcontent1: 'Pending',
                textcontent2: 'Completed',
                onStatusChange: (bool status) {
                  _statusController = status == true ? 1 : 0;
                },
              ),
              Date(
                defaultdata: _dateController.text,
                controller: _dateController,
              ),
              // SubTask(
              //   subtasks: [],
              //   goto: AddSubTask(),
              // )
            ]),
          ),
        ),
      ),
    );
  }

  final _tasknameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  late int _statusController;
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tasknameController.text = widget.taskdata.taskname;
    _categoryController.text = widget.taskdata.category;
    _noteController.text = widget.taskdata.note!;
    _statusController = widget.taskdata.status;
    _dateController.text = widget.taskdata.date;
  }

  Future<void> edittaskclicked(BuildContext context, TaskModel task) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final taskname = _tasknameController.text.toUpperCase();
      final category = _categoryController.text;
      final note = _noteController.text;
      final date = _dateController.text;
      final eventId = task.eventid;

      await editTask(
          task.id, taskname, category, note, _statusController, date, eventId);
      refreshEventtaskdata(eventId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Fill the Task Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(1.5.h),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
