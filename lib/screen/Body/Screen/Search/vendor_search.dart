import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/Database/model/Vendors/vendors_model.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_vendor.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/vendors.dart';
import 'package:sizer/sizer.dart';

class VendorSearch extends StatefulWidget {
  final Eventmodel eventModel;

  const VendorSearch({super.key, required this.eventModel});

  @override
  State<VendorSearch> createState() => _VendorSearchState();
}

class _VendorSearchState extends State<VendorSearch> {
  List<VendorsModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = vendortlist.value;
  }

  void _runFilter(String enteredKeyword) {
    List<VendorsModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = vendortlist.value;
    } else {
      result = vendortlist.value
          .where((student) =>
              student.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.clientname
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
          )),
      body: SafeArea(
        child: ValueListenableBuilder<List<VendorsModel>>(
            valueListenable: vendortlist,
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
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(
                                finduserItem.name,
                                style: raleway(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                              subtitle: Text(
                                finduserItem.clientname,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    dodeletevendor(context, finduserItem, 1,
                                        widget.eventModel);
                                  }),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctr) => EditVendor(
                                      eventModel: widget.eventModel,
                                      vendordataway: finduserItem,
                                      val: 1,
                                    ),
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

void dodeletevendor(
    rtx, VendorsModel student, int step, Eventmodel eventModel) {
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

void delectYes(ctx, VendorsModel student, int step, Eventmodel eventModel) {
  try {
    deleteVendor(student.id, student.eventid);
    deletePayVendor(student.eventid, student.id);

    if (step == 2) {
      Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (ctx) => Vendors(
                  eventModel: eventModel,
                  eventid: student.eventid,
                )),
        (route) => false,
      );
    } else if (step == 1) {
      Navigator.pop(ctx);
      refreshVendorData(student.eventid);
    }
  } catch (e) {
    print('Error inserting data: $e');
  }
}
