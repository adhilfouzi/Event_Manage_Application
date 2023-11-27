import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/model/Task/task_model.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_task.dart';
import 'package:sizer/sizer.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white, //const Color.fromRGBO(255, 200, 200, 1),

        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: TextField(
            autofocus: true,
            onChanged: (value) => _runFilter(value),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<List<TaskModel>>(
            valueListenable: taskList,
            builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.all(1.h),
                child: finduser.isEmpty
                    ? Center(
                        child: Text(
                          'No Data Available',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      )
                    : ListView.builder(
                        itemCount: finduser.length,
                        itemBuilder: (context, index) {
                          final finduserItem = finduser[index];
                          return Card(
                            color: Colors.blue[100],
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 1.h),
                            child: ListTile(
                              title: Text(
                                finduserItem.taskname,
                                style: raleway(
                                  color: Colors.black,
                                  fontSize: 13.sp,
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
      SnackBar(
        content: const Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(2.h),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 2),
      ),
    );
  } catch (e) {
    print('Error inserting data: $e');
  }
}
