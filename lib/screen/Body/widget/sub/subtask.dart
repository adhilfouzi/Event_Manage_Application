import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/model/Task/task_model.dart';

class SubTask extends StatefulWidget {
  const SubTask({
    super.key,
  });

  @override
  State<SubTask> createState() => _SubTaskState();
}

class _SubTaskState extends State<SubTask> {
  ValueNotifier<List<Subtaskmodel>>? subtasksNotifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sub Task', style: raleway()),
              IconButton(
                icon: const Icon(Icons.add_circle_outline_sharp,
                    color: buttoncolor),
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) => widget.goto),
                  // );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
