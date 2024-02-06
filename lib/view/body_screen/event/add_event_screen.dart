import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_evenmodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/view/body_screen/main/main_screem.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/widget/sub/contact_form_widget.dart';
import 'package:project_event/controller/widget/sub/date_widget.dart';

import 'package:project_event/controller/widget/sub/fn_time.dart';
import 'package:sizer/sizer.dart';

class AddEvent extends StatefulWidget {
  final int profileid;

  const AddEvent({super.key, required this.profileid});

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
    log('profile id in AddEvent  : ${widget.profileid}');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Get.offAll(
              transition: Transition.leftToRightWithFade,
              //     allowSnapshotting: false,
              fullscreenDialog: true,
              MainBottom(profileid: widget.profileid));
        },
        child: Scaffold(
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
            padding: EdgeInsets.all(0.5.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Event Details',
                    style: raleway(fontSize: 18.sp),
                  ),
                  Divider(
                    color: buttoncolor,
                    height: 1.h,
                    thickness: 2,
                    endIndent: 40,
                    indent: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1.h, 1.h, 1.h, 1.h),
                    child: InkWell(
                      onTap: () {
                        addPhoto();
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 25.h,
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
                                        height: 10.h,
                                      ),
                                      Text(
                                        'Add image of event',
                                        style: raleway(color: Colors.black),
                                      )
                                    ],
                                  )
                                : Image.file(
                                    imageevent!,
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
                    onChanged: (value) {
                      String numericValue =
                          value.replaceAll(RegExp(r'[^0-9]'), '');
                      final formatValue = _formatCurrency(numericValue);
                      _budgetController.value =
                          _budgetController.value.copyWith(
                        text: formatValue,
                        selection:
                            TextSelection.collapsed(offset: formatValue.length),
                      );
                    },
                    keyType: TextInputType.number,
                    textcontent: 'Budget',
                    controller: _budgetController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  TextFieldBlue(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a Venue';
                      }
                      return null;
                    },
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
                  SizedBox(height: 2.h),
                  Text(
                    'Client Details',
                    style: raleway(fontSize: 18.sp),
                  ),
                  Divider(
                      color: buttoncolor,
                      height: 2.h,
                      thickness: 2,
                      endIndent: 40,
                      indent: 40),
                  SizedBox(height: 2.h),
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
        ),
      ),
    );
  }

  String _formatCurrency(String value) {
    if (value.isNotEmpty) {
      final format = NumberFormat("#,##0", "en_US");
      return format.format(int.parse(value));
    } else {
      return value;
    }
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
  Future addEventcliked(context) async {
    if (imagepath == null) {
      Get.snackbar('Warning', 'Add Profile Picture',
          colorText: Colors.black,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          instantInit: false,
          duration: const Duration(milliseconds: 1100),
          dismissDirection: DismissDirection.startToEnd);
    }
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (_eventnameController.text.toUpperCase().isNotEmpty &&
          _locationController.text.toUpperCase().isNotEmpty) {
        log('profile id in AddEvent after click : ${widget.profileid}');

        final event = Eventmodel(
          eventname: _eventnameController.text.toUpperCase(),
          location: _locationController.text.toUpperCase(),
          startingDay: _stdateController.text,
          startingTime: _sttimeController.text,
          imagex: imagepath!,
          favorite: 0,
          profile: widget.profileid,
          about: _aboutController.text.trimLeft().trimRight(),
          address: _addressController.text.trimLeft().trimRight(),
          budget: _budgetController.text.trim(),
          emailId: _emailController.text.trim().toLowerCase(),
          clientname: _clientnameController.text.toUpperCase(),
          phoneNumber: _pnoController.text.trim(),
        );

        await addEvent(event);
        Get.offAll(
            //     allowSnapshotting: false,
            fullscreenDialog: true,
            MainBottom(profileid: widget.profileid));
        Get.snackbar(
          'Great',
          "Successfully added",
          colorText: Colors.blueAccent,
          backgroundColor: Colors.greenAccent,
          duration: const Duration(milliseconds: 1100),
        );
      }
    }
  }

  Future<void> getimage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      } else {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
          ],
          uiSettings: [
            AndroidUiSettings(
                lockAspectRatio: true,
                toolbarTitle: 'Crop',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.ratio4x3),
            IOSUiSettings(
              title: 'Crop',
            ),
          ],
        );
        if (croppedFile != null) {
          setState(() {
            imageevent = File(croppedFile.path);
            imagepath = croppedFile.path;
          });
        }
      }
    } catch (e) {
      // print('Failed image picker: $e');
    }
  }

  void addPhoto() {
    Get.defaultDialog(
      title: 'Choose Image Source',
      content: const Text('Choose Image From.......'),
      actions: [
        IconButton(
          onPressed: () {
            getimage(ImageSource.camera);
            Get.back();
          },
          icon: const Icon(
            Icons.camera_alt_rounded,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () {
            getimage(ImageSource.gallery);
            Get.back();
          },
          icon: const Icon(
            Icons.image,
            color: Colors.red,
          ),
        ),
      ],
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
        // print('User cancelled picking contact');
        // Handle the cancellation (e.g., show a message to the user)
      } else {
        // Handle other exceptions
        // print('Error picking contact: $e');
      }
    }
  }
}
