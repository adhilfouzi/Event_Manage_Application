import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/List/dropdowncategory.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

class EditTask extends StatelessWidget {
  EditTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [
        AppAction(icon: Icons.contacts, onPressed: () {}),
        AppAction(icon: Icons.delete, onPressed: () {}),
        AppAction(icon: Icons.done, onPressed: () {})
      ], titleText: 'Edit Task'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          TextFieldBlue(
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
              _statusController.text = status.toString();
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
    );
  }

  final _tasknameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();
  final _statusController = TextEditingController();
  final _dateController = TextEditingController();
}
