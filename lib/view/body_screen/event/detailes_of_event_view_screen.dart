import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/controller/event/event_delete_confirmation.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/view/body_screen/event/edit_event_screen.dart';
import 'package:project_event/controller/widget/box/viewbox.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';

import 'package:sizer/sizer.dart';

class ViewEventDetails extends StatelessWidget {
  final Eventmodel eventModel;

  const ViewEventDetails({Key? key, required this.eventModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(
              icon: Icons.delete,
              onPressed: () {
                doDeleteEvent(eventModel);
              }),
          AppAction(
              icon: Icons.edit,
              onPressed: () {
                Get.to(
                    transition: Transition.rightToLeftWithFade,
                    EditEvent(event: eventModel));
              }),
          SizedBox(width: 2.h)
        ],
        titleText: ' ',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(1.h),
        child: Column(
          children: [
            Card(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Event Details',
                      style: raleway(fontSize: 15.sp, color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(2.h, 1.h, 2.h, 1.h),
                      child: SizedBox(
                        width: double.infinity,
                        height: 20.h,
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(
                              File(eventModel.imagex),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ViewBox(
                      textcontent: 'Event Name',
                      controller: eventModel.eventname,
                    ),
                    ViewBox(
                      textcontent: 'Budget',
                      controller: eventModel.budget!,
                    ),
                    ViewBox(
                      textcontent: 'Location',
                      controller: eventModel.location.toUpperCase(),
                    ),
                    ViewBox(
                      textcontent: 'About',
                      controller: eventModel.about!,
                    ),
                    ViewBox(
                      textcontent: 'Event Day',
                      controller: eventModel.startingDay,
                    ),
                    ViewBox(
                      textcontent: 'Event Time',
                      controller: eventModel.startingTime,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Card(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(2.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Client Details',
                      style: raleway(fontSize: 15.sp, color: Colors.black),
                    ),
                    SizedBox(height: 2.h),
                    ViewBox(
                      textcontent: 'Client Name',
                      controller: eventModel.clientname!,
                    ),
                    ViewBox(
                      textcontent: 'Contact Number',
                      controller: eventModel.phoneNumber!,
                    ),
                    ViewBox(
                      textcontent: 'Email Address',
                      controller: eventModel.emailId!,
                    ),
                    ViewBox(
                      textcontent: 'Address',
                      controller: eventModel.address!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
