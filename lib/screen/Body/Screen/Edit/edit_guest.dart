import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/model/Guest_Model/guest_model.dart';
import 'package:project_event/screen/Body/Screen/Search/guest_search.dart';
import 'package:project_event/screen/Body/widget/List/sexdropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/ContactState.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';

class EditGuest extends StatefulWidget {
  final GuestModel guestdata;

  const EditGuest({super.key, required this.guestdata});

  @override
  State<EditGuest> createState() => _EditGuestState();
}

class _EditGuestState extends State<EditGuest> {
  final _formKey = GlobalKey<FormState>();
  PhoneContact? _phoneContact;

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
                dodeleteguest(context, widget.guestdata);
              }),
          AppAction(
              icon: Icons.done,
              onPressed: () {
                editGuestclick(context, widget.guestdata);
                Navigator.of(context).pop();
              }),
        ],
        titleText: 'Edit Guest',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
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

  Future<void> editGuestclick(BuildContext ctx, GuestModel guest) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final name = _nameController.text.toUpperCase();
      final sex = _sexController.text;
      final note = _noteController.text;
      final email = _econtroller.text;
      final eventId = guest.eventid;
      final number = _pcontroller.text;
      final adress = _acontroller.text;

      await editGuest(guest.id, eventId, name, sex, note, _statusController,
          number, email, adress);

      refreshguestdata(guest.eventid);
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("Successfully Edited"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(ctx);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("Fill the Guest Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
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
        print('User cancelled picking contact');
        // Handle the cancellation (e.g., show a message to the user)
      } else {
        // Handle other exceptions
        print('Error picking contact: $e');
      }
    }
  }
}
