import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/ContactState.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/sub/time.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  PhoneContact? _phoneContact;

  String? imagepath;
  File? imageevent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(
              icon: Icons.contacts,
              onPressed: () {
                getcontact();
              }),
          AppAction(
              icon: Icons.done,
              onPressed: () {
                addEventcliked(context);
              }),
        ],
        titleText: ' ',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Form(
          key: _formKey,
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
                textcontent: 'Venue',
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
              Time(
                textdate: 'Event Time',
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
              ContactState(
                acontroller: _addressController,
                econtroller: _emailController,
                pcontroller: _pnoController,
              )
            ],
          ),
        ),
      ),
    );
  }

  final TextEditingController _eventnameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _clientnameController = TextEditingController();
  final TextEditingController _stdateController = TextEditingController();
  final TextEditingController _sttimeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pnoController = TextEditingController();
  final int favorite = 0;
  Future addEventcliked(context) async {
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
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (_eventnameController.text.toUpperCase().isNotEmpty &&
          _locationController.text.toUpperCase().isNotEmpty) {
        final event = Eventmodel(
          favorite: favorite,
          eventname: _eventnameController.text.toUpperCase(),
          budget: _budgetController.text.trim(),
          location: _locationController.text.toUpperCase(),
          startingDay: _stdateController.text,
          clientname: _clientnameController.text.toUpperCase(),
          phoneNumber: _pnoController.text.trim(),
          startingTime: _sttimeController.text,
          imagex: imagepath!,
          emailId: _emailController.text.trim().toLowerCase(),
          about: _aboutController.text.trimLeft().trimRight(),
          address: _addressController.text.trimLeft().trimRight(),
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Fill the Task Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
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

  Future<void> getcontact() async {
    try {
      bool permission = await FlutterContactPicker.requestPermission();
      if (permission) {
        if (await FlutterContactPicker.hasPermission()) {
          _phoneContact = await FlutterContactPicker.pickPhoneContact();

          if (_phoneContact != null) {
            if (_phoneContact!.fullName!.isNotEmpty) {
              setState(() {
                _clientnameController.text = _phoneContact!.fullName.toString();
              });
            }
            if (_phoneContact!.phoneNumber!.number!.isNotEmpty) {
              setState(() {
                _pnoController.text =
                    _phoneContact!.phoneNumber!.number.toString();
              });
            }
          }
        }
      }
    } catch (e) {
      if (e is UserCancelledPickingException) {
        print('User cancelled picking contact');
        // Handle the cancellation (e.g., show a message to the user)
      } else {
        // Handle other exceptions
        print('Error picking contact: $e');
      }
    }
  }
}
