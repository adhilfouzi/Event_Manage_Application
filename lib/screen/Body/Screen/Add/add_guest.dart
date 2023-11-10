import 'package:flutter/material.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/model/Guest_Model/guest_model.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/List/dropdownsex.dart';
import 'package:project_event/screen/Body/widget/sub/contact.dart';
import 'package:project_event/screen/Body/widget/sub/status.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.contacts, onPressed: () {}),
          AppAction(
              icon: Icons.done,
              onPressed: () {
                addGuestclick(context);
              }),
        ],
        titleText: 'Add Guest',
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
            Contact(
                acontroller: _acontroller,
                econtroller: _econtroller,
                pcontroller: _pcontroller),
            // Compamions(goto: AddCompanions())
          ]),
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
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
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

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Fill the  Name"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
