import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/contact.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String? imagepath;
  File? imageevent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(
              icon: Icons.done,
              onPressed: () {
                addEventcliked(context);
              }),
        ],
        titleText: 'Add Event',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Text(
              'Event Details',
              style: raleway(fontSize: 22),
            ),
            const Divider(
              color: buttoncolor,
              height: 20,
              thickness: 2,
              endIndent: 40,
              indent: 40,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: InkWell(
                onTap: () {
                  addphoto(context);
                },
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
                      child: imageevent == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/UI/icons/addimage.png',
                                  width: 75,
                                  height: 70,
                                ),
                                Text(
                                  'Add image of event',
                                  style: raleway(color: Colors.black),
                                )
                              ],
                            )
                          : Image.file(
                              imageevent!,
                              height: 160,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
              ),
            ),
            TextFieldBlue(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Name';
                  }
                  return null;
                },
                keyType: TextInputType.name,
                textcontent: 'Event Name',
                controller: _eventnameController),
            TextFieldBlue(
              keyType: TextInputType.number,
              textcontent: 'Budget',
              controller: _budgetController,
            ),
            TextFieldBlue(
              keyType: TextInputType.streetAddress,
              textcontent: 'Location',
              posticondata: Icons.location_on,
              controller: _locationController,
            ),
            TextFieldBlue(
              textcontent: 'About',
              controller: _aboutController,
            ),
            Date(
              textdate: 'Event Day',
              controller: _stdateController,
            ),
            TextFieldBlue(
              textcontent: 'Event Time',
              controller: _sttimeController,
            ),
            const SizedBox(height: 25),
            Text(
              'Client Details',
              style: raleway(fontSize: 22),
            ),
            const Divider(
                color: buttoncolor,
                height: 20,
                thickness: 2,
                endIndent: 40,
                indent: 40),
            TextFieldBlue(
              keyType: TextInputType.name,
              textcontent: 'Client Name',
              controller: _clientnameController,
            ),
            Contact(
              acontroller: _addressController,
              econtroller: _emailController,
              pcontroller: _pnoController,
            )
          ],
        ),
      ),
    );
  }

  final _eventnameController = TextEditingController();
  final _budgetController = TextEditingController();
  final _locationController = TextEditingController();
  final _aboutController = TextEditingController();
  final _clientnameController = TextEditingController();
  final _stdateController = TextEditingController();
  final _sttimeController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _pnoController = TextEditingController();
  Future addEventcliked(context) async {
    final eventname = _eventnameController.text.toUpperCase();
    final budget = _budgetController.text.trim();
    final location = _locationController.text;
    final about = _aboutController.text;
    final clientname = _clientnameController.text.toUpperCase();
    final stdate = _stdateController.text;
    final sttime = _sttimeController.text;
    final address = _addressController.text;
    final email = _emailController.text.trim().toLowerCase();
    final pno = _pnoController.text.trim();

    if (imagepath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Add Profile Picture '),
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(10),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    if (eventname.isNotEmpty &&
            location.isNotEmpty &&
            budget.isNotEmpty &&
            sttime.isNotEmpty ||
        about.isNotEmpty ||
        email.isNotEmpty ||
        clientname.isNotEmpty ||
        address.isNotEmpty ||
        pno.isNotEmpty ||
        stdate.isNotEmpty) {
      final event = Eventmodel(
        eventname: eventname,
        budget: budget,
        location: location,
        startingDay: stdate,
        clientname: clientname,
        phoneNumber: pno,
        startingTime: sttime,
        imagex: imagepath!,
      );

      await addEvent(event);

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> getimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      setState(() {
        imageevent = File(image.path);
        imagepath = image.path.toString();
      });
    } catch (e) {
      print('Failed image picker:$e');
    }
  }

  void addphoto(ctxr) {
    showDialog(
      context: ctxr,
      builder: (ctxr) {
        return AlertDialog(
          content: const Text('Choose Image From.......'),
          actions: [
            IconButton(
              onPressed: () {
                getimage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                getimage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
