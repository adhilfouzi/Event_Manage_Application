import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/model/Task/task_model.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/List/dropdowncategory.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

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
    return Scaffold(
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
          padding: const EdgeInsets.all(10.0),
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
            // SubTask(
            //     //  goto: AddSubTask(subtasks: _subtasks),
            //     ),
          ]),
        ),
      ),
    );
  }

  final _tasknameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  final List<Subtaskmodel> _subtasks = [];
  int _statusController = 0;
  final _dateController = TextEditingController();

  Future<void> addTaskclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final taskname = _tasknameController.text.toUpperCase();
      final category = _categoryController.text;
      final note = _noteController.text;
      final date = _dateController.text;
      final eventId = widget.eventID;
      final subtask = _subtasks;

      final taskdata = TaskModel(
          taskname: taskname,
          category: category,
          status: _statusController,
          note: note,
          date: date,
          subtask: subtask,
          eventid: eventId);

      await addTask(taskdata).then((value) => log("success "));

      setState(() {
        _statusController = 0;
        _tasknameController.clear();
        _categoryController.clear();
        _dateController.clear();
        _noteController.clear();
      });

      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(mtx).pop();
    } else {
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Fill the Task Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
