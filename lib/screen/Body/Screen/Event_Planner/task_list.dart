import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/screen/Body/Screen/Add/add_task.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_task.dart';
import 'package:project_event/screen/Body/widget/List/list.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/floatingpointx.dart';

class TaskList extends StatelessWidget {
  final int eventid;

  const TaskList({
    super.key,
    required this.eventid,
  });

  @override
  Widget build(BuildContext context) {
    final int eventdata = eventid;
    refreshEventtaskdata(eventdata);

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
            if (value.isNotEmpty) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  final data = value[index];
                  final categoryItem = category.firstWhere(
                    (item) => item['text'] == data.category,
                    orElse: () => {
                      'image':
                          const AssetImage('assets/UI/icons/Accommodation.png'),
                    },
                  );
                  return Slidable(
                    key: const ValueKey(1),
                    startActionPane: ActionPane(
                      dragDismissible: false,
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            var fine = data.status = false;
                            editTask(
                                data.id,
                                data.taskname,
                                data.category,
                                data.note,
                                fine,
                                data.date,
                                data.eventid,
                                data.subtask);
                          },
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
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            bool fine = data.status = true;
                            editTask(
                                data.id,
                                data.taskname,
                                data.category,
                                data.note,
                                fine,
                                data.date,
                                data.eventid,
                                data.subtask);
                          },
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
                            data.taskname,
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
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditTask(
                                      taskdata: data,
                                    )));
                          },
                          trailing: Text(
                            data.date,
                            style: racingSansOne(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No Task available',
                  style: TextStyle(fontSize: 18),
                ),
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
