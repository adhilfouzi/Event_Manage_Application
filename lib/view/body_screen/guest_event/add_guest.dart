import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:project_event/model/db_functions/fn_guestmodel.dart';
import 'package:project_event/model/data_model/guest_model/guest_model.dart';
import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/widget/list/sexdropdown.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/controller/widget/sub/contact_form_widget.dart';
import 'package:project_event/controller/widget/sub/status_button_widget.dart';

import 'package:sizer/sizer.dart';

class AddGuest extends StatefulWidget {
  final int eventID;

  const AddGuest({
    super.key,
    required this.eventID,
  });

  @override
  State<AddGuest> createState() => _AddGuestState();
}

class _AddGuestState extends State<AddGuest> {
  final _formKey = GlobalKey<FormState>();
  PhoneContact? _phoneContact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                  addGuestclick(context);
                }),
          ],
          titleText: 'Add Guest',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.h),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFieldBlue(
                textcontent: 'Name',
                controller: _nameController,
                keyType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              SexDown(onChanged: (String? status) {
                _sexController.text = status ?? 'Male';
              }),
              TextFieldBlue(textcontent: 'Note', controller: _noteController),
              StatusBar(
                onStatusChange: (bool status) {
                  _statusController = status == true ? 1 : 0;
                },
                textcontent1: 'Not sent',
                textcontent2: 'Invitation sent',
              ),
              ContactState(
                  acontroller: _acontroller,
                  econtroller: _econtroller,
                  pcontroller: _pcontroller),
              // Compamions(goto: AddCompanions())
            ]),
          ),
        ),
      ),
    );
  }

  int _statusController = 0;

  final _sexController = TextEditingController();

  final _nameController = TextEditingController();

  final _noteController = TextEditingController();

  final _econtroller = TextEditingController();

  final _acontroller = TextEditingController();

  final _pcontroller = TextEditingController();

  Future<void> addGuestclick(context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final name = _nameController.text.toUpperCase();
      final sex = _sexController.text;
      final note = _noteController.text;
      final email = _econtroller.text;
      final eventId = widget.eventID;
      final number = _pcontroller.text;
      final adress = _acontroller.text;

      final guestdata = GuestModel(
        status: _statusController,
        gname: name,
        sex: sex,
        note: note,
        eventid: eventId,
        address: adress,
        email: email,
        number: number,
      );

      await addguest(guestdata);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(2.h),
          backgroundColor: Colors.greenAccent,
          duration: const Duration(seconds: 2),
        ),
      );
      setState(() {
        _statusController = 0;
        _nameController.clear();
        _noteController.clear();
        _econtroller.clear();
        _pcontroller.clear();
        _sexController.clear();
        _acontroller.clear();
      });

      Get.back();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Fill the  Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(2.h),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
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
                _nameController.text = _phoneContact!.fullName.toString();
              });
            }
            if (_phoneContact!.phoneNumber!.number!.isNotEmpty) {
              setState(() {
                _pcontroller.text =
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
