import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/task_event/task_delete_conformation.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_taskmodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';

import 'package:project_event/model/data_model/task/task_model.dart';
import 'package:project_event/view/body_screen/task_event/edit_task_screen.dart';

import 'package:sizer/sizer.dart';

class TaskSearch extends StatefulWidget {
  final Eventmodel eventModel;

  const TaskSearch({super.key, required this.eventModel});

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
                                    doDeleteTask(
                                        finduserItem, 1, widget.eventModel);
                                  }),
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    EditTask(
                                        taskdata: finduserItem,
                                        eventModel: widget.eventModel));
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
