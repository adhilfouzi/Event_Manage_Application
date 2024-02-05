import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_event/core/color/color.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/database/functions/fn_taskmodel.dart';
import 'package:project_event/database/model/event/event_model.dart';
import 'package:project_event/screen/body/screen/add/add_task.dart';
import 'package:project_event/screen/body/screen/edit/edit_task.dart';
import 'package:project_event/screen/body/screen/main/event/viewevent.dart';
import 'package:project_event/screen/body/screen/search/tasklist_search.dart';
import 'package:project_event/screen/body/widget/list/list.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:project_event/screen/body/widget/scaffold/floatingpointx.dart';

import 'package:sizer/sizer.dart';

class TaskList extends StatelessWidget {
  final Eventmodel eventModel;

  final int eventid;

  const TaskList({
    super.key,
    required this.eventid,
    required this.eventModel,
  });

  @override
  Widget build(BuildContext context) {
    refreshEventtaskdata(eventid);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => ViewEvent(eventModel: eventModel)),
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: CustomAppBar(
            leading: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => ViewEvent(eventModel: eventModel),
                ),
                (route) => false,
              );
            },
            actions: [
              AppAction(
                  icon: Icons.search,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctr) => TaskSearch(eventModel: eventModel),
                    ));
                  }),
              SizedBox(
                width: 2.w,
              )
            ],
            titleText: 'Task List'),
        body: Padding(
          padding: EdgeInsets.all(1.h),
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
                        'image': const AssetImage(
                            'assets/UI/icons/Accommodation.png'),
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
                              int fine = data.status = 0;
                              editTask(data.id, data.taskname, data.category,
                                  data.note, fine, data.date, data.eventid);
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
                              int fine = data.status = 1;
                              editTask(
                                data.id,
                                data.taskname,
                                data.category,
                                data.note,
                                fine,
                                data.date,
                                data.eventid,
                              );
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
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.status == 0 ? 'Pending' : 'Completed',
                                  style: raleway(
                                    color: data.status == 0
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  data.date,
                                  style: racingSansOne(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditTask(
                                        taskdata: data,
                                        eventModel: eventModel,
                                      )));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    'No Task available',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingPointx(
            goto: AddTask(
          eventID: eventid,
        )),
      ),
    );
  }
}
