import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/model/Task/task_model.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_task.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/task_list.dart';

class TaskSearch extends StatefulWidget {
  const TaskSearch({super.key});

  @override
  State<TaskSearch> createState() => _TaskSearchState();
}

class _TaskSearchState extends State<TaskSearch> {
  List<TaskModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = taskList.value;
    // Initialize with the current student list
  }

  void _runFilter(String enteredKeyword) {
    List<TaskModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = taskList.value;
    } else {
      result = taskList.value
          .where((student) =>
              student.taskname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.category
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      finduser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<List<TaskModel>>(
            valueListenable: taskList,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: buttoncolor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: buttoncolor,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Expanded(
                      child: finduser.isEmpty
                          ? const Center(
                              child: Text(
                                'No Data Available',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              itemCount: finduser.length,
                              itemBuilder: (context, index) {
                                final finduserItem = finduser[index];
                                return Card(
                                  color: Colors.blue[100],
                                  elevation: 4,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    title: Text(
                                      finduserItem.taskname,
                                      style: raleway(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    subtitle: Text(
                                      finduserItem.status == 0
                                          ? 'Pending'
                                          : 'Completed',
                                      style: TextStyle(
                                        color: finduserItem.status == 0
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          dodeletetask(context, finduserItem);
                                        }),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctr) =>
                                              EditTask(taskdata: finduserItem),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

void dodeletetask(rtx, TaskModel student) {
  try {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Do You Want delete  ${student.taskname} ?'),
          actions: [
            TextButton(
                onPressed: () {
                  delectYes(context, student);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(rtx);
                },
                child: const Text('No'))
          ],
        );
      },
    );
  } catch (e) {
    print('Error deleting data: $e');
  }
}

void delectYes(
  ctx,
  TaskModel student,
) {
  try {
    deletetask(student.id, student.eventid);
    Navigator.of(ctx).pop();
    Navigator.of(ctx).pop();

    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );
  } catch (e) {
    print('Error inserting data: $e');
  }
}
