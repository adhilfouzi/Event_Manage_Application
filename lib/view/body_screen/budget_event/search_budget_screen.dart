import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_budgetmodel.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/data_model/budget_model/budget_model.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/view/body_screen/budget_event/edit_budget_screen.dart';
import 'package:project_event/view/body_screen/budget_event/budget_screen.dart';

import 'package:sizer/sizer.dart';

class BudgetSearch extends StatefulWidget {
  final Eventmodel eventModel;

  const BudgetSearch({super.key, required this.eventModel});

  @override
  State<BudgetSearch> createState() => _BudgetSearchState();
}

class _BudgetSearchState extends State<BudgetSearch> {
  List<BudgetModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = budgetlist.value;
    // Initialize with the current student list
  }

  void _runFilter(String enteredKeyword) {
    List<BudgetModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = budgetlist.value;
    } else {
      result = budgetlist.value
          .where((student) =>
              student.name
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
          backgroundColor:
              Colors.white, //const Color.fromRGBO(255, 200, 200, 1),

          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              autofocus: true,
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          )),
      body: SafeArea(
        child: ValueListenableBuilder<List<BudgetModel>>(
            valueListenable: budgetlist,
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
                                finduserItem.name,
                                style: raleway(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                              subtitle: Text(
                                finduserItem.category.isNotEmpty == true
                                    ? finduserItem.category
                                    : 'Accommodation',
                                style: raleway(
                                  color: Colors.black,
                                  fontSize: 10.sp,
                                ),
                              ),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    dodeletebudget(context, finduserItem, 3,
                                        widget.eventModel);
                                  }),
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    EditBudget(
                                        budgetdata: finduserItem,
                                        eventModel: widget.eventModel));
                              },
                            ),
                          );
                        }),
              );
            }),
      ),
    );
  }
}

void dodeletebudget(rtx, BudgetModel student, int step, Eventmodel eventModel) {
  try {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Do You Want delete  ${student.name} ?'),
          actions: [
            TextButton(
                onPressed: () {
                  delectYes(context, student, step, eventModel);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('No'))
          ],
        );
      },
    );
  } catch (e) {
    // print('Error deleting data: $e');
  }
}

void delectYes(ctx, BudgetModel student, int step, Eventmodel eventModel) {
  deleteBudget(student.id, student.eventid);
  deletePayBudget(student.eventid, student.id);

  if (step == 2) {
    Get.offAll(
        transition: Transition.rightToLeftWithFade,
        //     allowSnapshotting: false,
        fullscreenDialog: true,
        Budget(
          eventid: student.eventid,
          eventModel: eventModel,
        ));
  } else if (step == 3) {
    Get.back();

    refreshBudgetData(student.eventid);
  }
}
