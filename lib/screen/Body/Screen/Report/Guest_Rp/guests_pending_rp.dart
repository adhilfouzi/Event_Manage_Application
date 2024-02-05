import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:project_event/core/color/color.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/database/functions/fn_guestmodel.dart';
import 'package:project_event/database/model/event/event_model.dart';
import 'package:project_event/screen/body/screen/edit/edit_guest.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:sizer/sizer.dart';

class PendingRpGuests extends StatelessWidget {
  final Eventmodel eventModel;

  const PendingRpGuests({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(actions: [], titleText: 'Guests List'),
      body: Padding(
        padding: EdgeInsets.all(1.h),
        child: ValueListenableBuilder(
          valueListenable: guestPendinglist,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = value[index];

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
                            editGuest(
                                data.id,
                                data.eventid,
                                data.gname,
                                data.sex,
                                data.note,
                                fine,
                                data.number,
                                data.email,
                                data.address);
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
                            editGuest(
                                data.id,
                                data.eventid,
                                data.gname,
                                data.sex,
                                data.note,
                                fine,
                                data.number,
                                data.email,
                                data.address);
                          },
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.verified,
                          label: 'invited',
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
                          leading: Image.asset('assets/UI/icons/person.png'),
                          title: Text(
                            data.gname,
                            style: raleway(color: Colors.black),
                          ),
                          subtitle: Text(
                            data.status == 0 ? 'Pending' : 'Completed',
                            style: raleway(
                              color:
                                  data.status == 0 ? Colors.red : Colors.green,
                              fontSize: 11.sp,
                            ),
                          ),
                          onTap: () {
                            Get.to(EditGuest(
                              eventModel: eventModel,
                              guestdata: data,
                            ));
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
                  'No Guest data available',
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
