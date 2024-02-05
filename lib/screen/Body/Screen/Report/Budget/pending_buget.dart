import 'package:flutter/material.dart';
import 'package:project_event/core/color/color.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/database/functions/fn_budgetmodel.dart';
import 'package:project_event/database/model/event/event_model.dart';
import 'package:project_event/screen/body/screen/edit/edit_budget.dart';
import 'package:project_event/screen/body/screen/view/budget_view.dart';
import 'package:project_event/screen/body/widget/list/list.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:sizer/sizer.dart';

class PendingRpBudget extends StatelessWidget {
  final Eventmodel eventModel;

  const PendingRpBudget({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    // refreshBudgetData(eventid);
    return Scaffold(
      appBar: const CustomAppBar(actions: [], titleText: 'Budget'),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: ValueListenableBuilder(
          valueListenable: budgetPendinglist,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = value[index];
                  final categoryItem = category.firstWhere(
                    (item) => item['text'] == data.category,
                    orElse: () => {
                      'image':
                          const AssetImage('assets/UI/icons/Accommodation.png'),
                    },
                  );
                  return Card(
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BudgetView(
                                    budget: data,
                                    eventModel: eventModel,
                                  )));
                        },
                        onLongPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditBudget(
                                    budgetdata: data,
                                    eventModel: eventModel,
                                  )));
                        },
                        leading: Image(image: categoryItem['image']),
                        title: Text(
                          data.name,
                          style: raleway(color: Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.status == 0 ? 'Pending' : 'Completed',
                                  style: raleway(
                                    color: data.status == 0
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: 11.sp,
                                  ),
                                ),
                                Text(
                                  '₹ ${data.esamount}',
                                  style: racingSansOne(
                                    color: Colors.black,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pending: ₹${data.pending}',
                                  style: racingSansOne(
                                    color: Colors.black54,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  'Paid: ₹${data.paid}',
                                  style: racingSansOne(
                                    color: Colors.black54,
                                    fontSize: 10.sp,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No Budget available',
                  style: TextStyle(fontSize: 15.sp),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
