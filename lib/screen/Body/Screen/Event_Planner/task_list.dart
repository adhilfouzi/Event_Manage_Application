import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/model/Task/task_model.dart';
import 'package:project_event/screen/Body/Screen/Add/add_task.dart';
import 'package:project_event/screen/Body/widget/List/list.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/floatingpointx.dart';

class TaskList extends StatefulWidget {
  final String eventid;

  const TaskList({
    super.key,
    required this.eventid,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<TaskModel> eventTasks = [];

  @override
  Widget build(BuildContext context) {
    refreshEventtaskdata();

    final String eventId = widget.eventid;
    eventTasks =
        taskList.value.where((task) => task.eventid == eventId).toList();
    final String eventdata = widget.eventid.toString();

    return Scaffold(
      appBar: CustomAppBar(actions: [
        AppAction(icon: Icons.search, onPressed: () {}),
        AppAction(icon: Icons.more_vert, onPressed: () {})
      ], titleText: 'Task List'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: taskList,
          builder: (context, value, child) {
            log(taskList.value.length.toString());

            if (eventTasks.isEmpty) {
              return const Center(
                child: Text(
                  'No Task available',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: eventTasks.length,
                itemBuilder: (context, index) {
                  final data = value[index];
                  final datas = eventTasks[index];
                  if (data != null) {
                    final categoryItem = category.firstWhere(
                      (item) => item['text'] == datas.category,
                      orElse: () => {
                        'image': const AssetImage(
                            'assets/UI/icons/Accommodation.png'),
                      },
                    );
                    return InkWell(
                      onTap: () {},
                      child: Slidable(
                        key: const ValueKey(1),
                        startActionPane: ActionPane(
                          dragDismissible: false,
                          motion: const ScrollMotion(),
                          dismissible: DismissiblePane(onDismissed: () {}),
                          children: const [
                            SlidableAction(
                              onPressed: doNothing,
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              icon: Icons.pending_actions,
                              label: 'Pending',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          dragDismissible: false,
                          dismissible: DismissiblePane(onDismissed: () {}),
                          children: const [
                            SlidableAction(
                              onPressed: doNothing,
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              icon: Icons.verified,
                              label: 'Done',
                            ),
                          ],
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: buttoncolor, width: 1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ListTile(
                              leading: Image(image: categoryItem['image']),
                              title: Text(
                                datas.taskname,
                                style: raleway(color: Colors.black),
                              ),
                              subtitle: Text(
                                data.status == false ? 'Pending' : 'Completed',
                                style: raleway(
                                  color: data.status == false
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                              onTap: () {},
                              trailing: Column(children: [
                                Text(
                                  data.date,
                                  style: racingSansOne(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  'Subtask: 0/3',
                                  style: racingSansOne(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(); // Handle the case where task is null
                  }
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingPointx(
          goto: AddTask(
        eventID: eventdata,
      )),
    );
  }
}

void doNothing(BuildContext context) {}
