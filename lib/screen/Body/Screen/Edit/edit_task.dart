import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/model/Task/task_model.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/List/dropdowncategory.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

class EditTask extends StatefulWidget {
  final TaskModel taskdata;

  const EditTask({super.key, required this.taskdata});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [
        AppAction(icon: Icons.contacts, onPressed: () {}),
        AppAction(
            icon: Icons.delete,
            onPressed: () {
              deletetask(widget.taskdata.id, widget.taskdata.eventid!);
              Navigator.of(context).pop();
            }),
        AppAction(
            icon: Icons.done,
            onPressed: () {
              edittaskclicked(context, widget.taskdata);
            })
      ], titleText: 'Edit Task'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
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
              defaultdata: _statusController,
              textcontent1: 'Pending',
              textcontent2: 'Completed',
              onStatusChange: (bool status) {
                _statusController = status;
              },
            ),
            Date(
              controller: _dateController,
            ),
            // SubTask(
            //   subtasks: [],
            //   goto: AddSubTask(),
            // )
          ]),
        ),
      ),
    );
  }

  final _tasknameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  final List<Subtaskmodel> _subtasks = [];
  late bool _statusController;
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
    try {
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        final taskname = _tasknameController.text.toUpperCase();
        final category = _categoryController.text;
        final note = _noteController.text;
        final date = _dateController.text;
        final eventId = task.eventid;
        final subtask = _subtasks;

        await editTask(task.id, taskname, category, note, _statusController,
                date, eventId, subtask)
            .then((value) => log("Edit success "));
        refreshEventtaskdata(eventId!);
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Fill the Task Name"),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {}
  }
}
