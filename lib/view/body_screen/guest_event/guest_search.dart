import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/guest_event/guest_delete_confirmatiion.dart';

import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_guestmodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/guest_model/guest_model.dart';
import 'package:project_event/view/body_screen/guest_event/edit_guest.dart';

import 'package:sizer/sizer.dart';

class GuestSearch extends StatefulWidget {
  final Eventmodel eventModel;

  const GuestSearch({super.key, required this.eventModel});

  @override
  State<GuestSearch> createState() => _GuestSearchState();
}

class _GuestSearchState extends State<GuestSearch> {
  List<GuestModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = guestlist.value;
    // Initialize with the current student list
  }

  void _runFilter(String enteredKeyword) {
    List<GuestModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = guestlist.value;
    } else {
      result = guestlist.value
          .where((student) =>
              student.gname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.number!
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
        child: ValueListenableBuilder<List<GuestModel>>(
            valueListenable: guestlist,
            builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.all(1.h),
                child: Column(
                  children: [
                    Expanded(
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
                                  margin: EdgeInsets.symmetric(vertical: 2.sp),
                                  child: ListTile(
                                    title: Text(
                                      finduserItem.gname,
                                      style: raleway(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    subtitle: Text(
                                      finduserItem.status == 0
                                          ? 'Pending invitation'
                                          : 'Invitation sent',
                                      style: TextStyle(
                                        color: finduserItem.status == 0
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          doDeleteGuest(finduserItem, 1,
                                              widget.eventModel);
                                        }),
                                    onTap: () {
                                      Get.to(
                                          transition:
                                              Transition.rightToLeftWithFade,
                                          EditGuest(
                                              step: 2,
                                              guestdata: finduserItem,
                                              eventModel: widget.eventModel));
                                    },
                                  ),
                                );
                              }),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
