import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/model/Guest_Model/guest_model.dart';
import 'package:project_event/screen/Body/widget/List/dropdownsex.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/contact.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';

class EditGuest extends StatefulWidget {
  final GuestModel guestdata;

  const EditGuest({super.key, required this.guestdata});

  @override
  State<EditGuest> createState() => _EditGuestState();
}

class _EditGuestState extends State<EditGuest> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.contacts, onPressed: () {}),
          AppAction(
              icon: Icons.delete,
              onPressed: () {
                deleteGuest(widget.guestdata.id, widget.guestdata.eventid);
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
            Contact(
                acontroller: _acontroller,
                econtroller: _econtroller,
                pcontroller: _pcontroller),
          ]),
        ),
      ),
    );
  }

  late int _statusController;
  final _sexController = TextEditingController();
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  final _econtroller = TextEditingController();
  final _acontroller = TextEditingController();
  final _pcontroller = TextEditingController();

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
}
