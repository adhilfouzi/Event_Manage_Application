import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:project_event/database/functions/fn_guestmodel.dart';
import 'package:project_event/database/model/event/event_model.dart';
import 'package:project_event/database/model/guest_model/guest_model.dart';
import 'package:project_event/screen/body/screen/search/guest_search.dart';
import 'package:project_event/screen/body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/body/widget/list/sexdropdown.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:project_event/screen/body/widget/sub/contactstate.dart';
import 'package:project_event/screen/body/widget/sub/status.dart';

import 'package:sizer/sizer.dart';

class EditGuest extends StatefulWidget {
  final Eventmodel eventModel;

  final GuestModel guestdata;

  const EditGuest(
      {super.key, required this.guestdata, required this.eventModel});

  @override
  State<EditGuest> createState() => _EditGuestState();
}

class _EditGuestState extends State<EditGuest> {
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
                icon: Icons.delete,
                onPressed: () {
                  dodeleteguest(
                      context, widget.guestdata, 2, widget.eventModel);
                }),
            AppAction(
                icon: Icons.done,
                onPressed: () {
                  editGuestclick(context, widget.guestdata);
                }),
          ],
          titleText: 'Edit Guest',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.2.h),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFieldBlue(
                textcontent: 'Name',
                controller: _nameController,
                keyType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' name is required';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              SexDown(
                  onChanged: (String? status) {
                    _sexController.text = status ?? 'Male';
                  },
                  defaultdata: _sexController.text),
              TextFieldBlue(textcontent: 'Note', controller: _noteController),
              StatusBar(
                defaultdata: _statusController == 1 ? true : false,
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
            ]),
          ),
        ),
      ),
    );
  }

  late int _statusController;
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _econtroller = TextEditingController();
  final TextEditingController _acontroller = TextEditingController();
  final TextEditingController _pcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _statusController = widget.guestdata.status;
    _sexController.text = widget.guestdata.sex;
    _nameController.text = widget.guestdata.gname;
    _noteController.text = widget.guestdata.note!;
    _econtroller.text = widget.guestdata.email!;
    _acontroller.text = widget.guestdata.address!;
    _pcontroller.text = widget.guestdata.number!;
  }

  Future<void> editGuestclick(BuildContext context, GuestModel guest) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final name = _nameController.text.toUpperCase();
      final sex = _sexController.text;
      final note = _noteController.text;
      final email = _econtroller.text;
      final eventId = guest.eventid;
      final number = _pcontroller.text;
      final adress = _acontroller.text;
      Navigator.pop(context);

      await editGuest(guest.id, eventId, name, sex, note, _statusController,
          number, email, adress);

      refreshguestdata(guest.eventid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Fill the Guest Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(1.h),
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
