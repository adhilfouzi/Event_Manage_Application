import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/Screen/main/Event/edit_event.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
import 'package:project_event/screen/Body/widget/box/viewbox.dart';

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
                dodeleteevent(context, eventModel);
              }),
          AppAction(
              icon: Icons.edit,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditEvent(event: eventModel),
                ));
              }),
          const SizedBox(width: 15)
        ],
        titleText: ' ',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Event Details',
                      style: raleway(fontSize: 22, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: SizedBox(
                        width: double.infinity,
                        height: 175,
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
                              height: 160,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
            const SizedBox(height: 15),
            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Client Details',
                      style: raleway(fontSize: 22, color: Colors.black),
                    ),
                    const SizedBox(height: 15),
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

void dodeleteevent(rtx, Eventmodel student) {
  try {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text(
              'Do You Want delete  ${student.eventname} of ${student.clientname}?'),
          actions: [
            TextButton(
                onPressed: () {
                  delecteventYes(context, student);
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

void delecteventYes(
  ctx,
  Eventmodel student,
) {
  deleteEventdata(
    student.id,
  );
  Navigator.of(ctx).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const MainBottom(),
    ),
    (route) => false,
  );
  ScaffoldMessenger.of(ctx).showSnackBar(
    const SnackBar(
      content: Text("Successfully Deleted"),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      backgroundColor: Colors.grey,
      duration: Duration(seconds: 2),
    ),
  );
}
