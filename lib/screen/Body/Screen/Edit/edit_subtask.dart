import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

class EditSubTask extends StatelessWidget {
  EditSubTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.delete, onPressed: () {}),
          AppAction(icon: Icons.done, onPressed: () {}),
        ],
        titleText: 'Edit SubTask',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextFieldBlue(textcontent: 'Name', controller: _nameController),
          TextFieldBlue(textcontent: 'Note', controller: _noteController),
          StatusBar(
            textcontent1: 'Pending',
            textcontent2: 'Completed',
            onStatusChange: (bool status) {
              _statusController.text = status.toString();
            },
          )
        ]),
      ),
    );
  }

  final _nameController = TextEditingController();
  final _statusController = TextEditingController();
  final _noteController = TextEditingController();
}
