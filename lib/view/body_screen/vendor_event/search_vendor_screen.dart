import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event_controller/vendor_event/vendor_delete_conformation.dart';

import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_vendormodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/vendors/vendors_model.dart';
import 'package:project_event/view/body_screen/vendor_event/edit_vendor_screen.dart';

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
                                    doDeleteVendor(
                                        finduserItem, 1, widget.eventModel);
                                  }),
                              onTap: () {
                                Get.to(
                                    transition: Transition.rightToLeftWithFade,
                                    EditVendor(
                                      step: 2,
                                      eventModel: widget.eventModel,
                                      vendordataway: finduserItem,
                                    ));
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
