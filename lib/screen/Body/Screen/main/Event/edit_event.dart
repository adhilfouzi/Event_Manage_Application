import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/Screen/main/Event/view_event_details.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/ContactState.dart';
import 'package:project_event/screen/Body/widget/sub/date.dart';
import 'package:project_event/screen/Body/widget/sub/time.dart';

class EditEvent extends StatefulWidget {
  final Eventmodel event;

  const EditEvent({super.key, required this.event});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _formKey = GlobalKey<FormState>();
  PhoneContact? _phoneContact;

  late String imagepath;
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
              icon: Icons.delete,
              onPressed: () {
                dodeleteevent(context, widget.event);
              }),
          AppAction(
              icon: Icons.done,
              onPressed: () {
                editEventcliked(context);
              }),
        ],
        titleText: 'Add Event',
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
                    addoneditphoto(context);
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
                defaultdata: _sttimeController.text,
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
  int favorite = 0;

  @override
  void initState() {
    super.initState();
    _eventnameController.text = widget.event.eventname;
    _budgetController.text = widget.event.budget!;
    _locationController.text = widget.event.location;
    _aboutController.text = widget.event.about!;
    _clientnameController.text = widget.event.clientname!;
    _stdateController.text = widget.event.startingDay;
    _sttimeController.text = widget.event.startingTime;
    _addressController.text = widget.event.address!;
    _emailController.text = widget.event.emailId!;
    _pnoController.text = widget.event.phoneNumber!;
    imagepath = widget.event.imagex;
    imageevent = File(imagepath);
    favorite = widget.event.favorite;
  }

  Future editEventcliked(context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (imagepath.isEmpty) {
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

      if (_eventnameController.text.toUpperCase().isNotEmpty &&
          _locationController.text.toUpperCase().isNotEmpty) {
        await editeventdata(
            widget.event.id,
            _eventnameController.text.toUpperCase(),
            _budgetController.text.trim(),
            favorite,
            _locationController.text.toUpperCase(),
            _aboutController.text.trimLeft().trimRight(),
            _stdateController.text,
            _sttimeController.text,
            _clientnameController.text.toUpperCase(),
            _pnoController.text.trim(),
            _emailController.text.trim().toLowerCase(),
            _addressController.text.trimLeft().trimRight(),
            imagepath);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const MainBottom()),
          (route) => false,
        );
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
  }

  Future<void> getimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      setState(() {
        imageevent = File(image.path);
        imagepath = image.path; // Remove toString() here
      });
    } catch (e) {
      print('Failed image picker: $e');
    }
  }

  void addoneditphoto(ctx) {
    showDialog(
      context: ctx,
      builder: (ctx) {
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
