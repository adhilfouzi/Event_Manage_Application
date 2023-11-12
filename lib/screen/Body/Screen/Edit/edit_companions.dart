import 'package:flutter/material.dart';
import 'package:project_event/screen/Body/widget/List/sexdropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/ContactState.dart';

class EditCompanions extends StatelessWidget {
  const EditCompanions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.delete, onPressed: () {}),
          AppAction(icon: Icons.contacts, onPressed: () {}),
          AppAction(icon: Icons.done, onPressed: () {}),
        ],
        titleText: 'Edit Companions',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          TextFieldBlue(textcontent: 'Name'),
          SexDown(),
          TextFieldBlue(textcontent: 'Note'),
          ContactState()
        ]),
      ),
    );
  }
}
