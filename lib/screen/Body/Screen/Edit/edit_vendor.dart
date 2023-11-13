import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Vendors/vendors_model.dart';
import 'package:project_event/screen/Body/widget/List/categorydropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/ContactState.dart';

class EditVendor extends StatefulWidget {
  final VendorsModel vendordataway;
  const EditVendor({super.key, required this.vendordataway});

  @override
  State<EditVendor> createState() => _EditVendorState();
}

class _EditVendorState extends State<EditVendor> {
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
              icon: Icons.done,
              onPressed: () {
                addVendorclick(context);
              }),
        ],
        titleText: 'Edit Vendors',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFieldBlue(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Company Name';
                  }
                  return null;
                },
                textcontent: 'Company Name',
                controller: _nameController),
            CategoryDown(
              defaultdata: _categoryController.text,
              onCategorySelected: (String value) {
                _categoryController.text = value;
              },
            ),
            TextFieldBlue(textcontent: 'Note', controller: _noteController),
            TextFieldBlue(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Estimatrd Amount';
                  }
                  return null;
                },
                keyType: TextInputType.number,
                textcontent: 'Estimatrd Amount',
                controller: _budgetController),
            TextFieldBlue(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a Client Name';
                }
                return null;
              },
              keyType: TextInputType.name,
              textcontent: 'Client Name',
              controller: _clientnameController,
            ),
            ContactState(
                acontroller: _acontroller,
                econtroller: _econtroller,
                pcontroller: _phoneController),
            // PaymentsBar(),
            // Payments(),
          ]),
        ),
      ),
    );
  }

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  final TextEditingController _acontroller = TextEditingController();

  final TextEditingController _econtroller = TextEditingController();

  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _clientnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.vendordataway.name;
    _categoryController.text = widget.vendordataway.category ?? '';
    _noteController.text = widget.vendordataway.note ?? '';
    _acontroller.text = widget.vendordataway.address ?? '';
    _econtroller.text = widget.vendordataway.email ?? '';
    _budgetController.text = widget.vendordataway.esamount;
    _clientnameController.text = widget.vendordataway.clientname;
    _phoneController.text = widget.vendordataway.number ?? '';
  }

  Future<void> addVendorclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      await editVendor(
        widget.vendordataway.id,
        _nameController.text.toUpperCase().trimLeft().trimRight(),
        _categoryController.text,
        _noteController.text.trimLeft().trimRight(),
        _phoneController.text.trimLeft().trimRight(),
        _budgetController.text.trimLeft().trimRight(),
        widget.vendordataway.eventid,
        _econtroller.text.trimLeft().trimRight(),
        _acontroller.text.trimLeft().trimRight(),
        _clientnameController.text.toUpperCase(),
      );
      refreshVendorData(widget.vendordataway.eventid);

      Navigator.pop(mtx);
    } else {
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Fill the Name & Estimatrd Amount"),
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
                _clientnameController.text = _phoneContact!.fullName.toString();
              });
            }
            if (_phoneContact!.phoneNumber!.number!.isNotEmpty) {
              setState(() {
                _phoneController.text =
                    _phoneContact!.phoneNumber!.number.toString();
              });
            }
          }
        }
      }
    } catch (e) {
      if (e is UserCancelledPickingException) {
        log('User cancelled picking contact');
        // Handle the cancellation (e.g., show a message to the user)
      } else {
        // Handle other exceptions
        log('Error picking contact: $e');
      }
    }
  }
}
