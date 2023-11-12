import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Vendors/vendors.dart';
import 'package:project_event/screen/Body/widget/List/categorydropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/ContactState.dart';

class AddVendor extends StatefulWidget {
  final int eventid;

  AddVendor({super.key, required this.eventid});

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
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
        titleText: 'Add Vendors',
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

  final _nameController = TextEditingController();

  final _categoryController = TextEditingController();

  final _noteController = TextEditingController();

  final _acontroller = TextEditingController();

  final _econtroller = TextEditingController();

  final _budgetController = TextEditingController();
  final TextEditingController _clientnameController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> addVendorclick(mtx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final vendordata = VendorsModel(
          clientname: _clientnameController.text.toUpperCase(),
          name: _nameController.text.toUpperCase().trimLeft().trimRight(),
          category: _categoryController.text,
          esamount: _budgetController.text.trimLeft().trimRight(),
          eventid: widget.eventid,
          note: _noteController.text.trimLeft().trimRight(),
          number: _phoneController.text.trimLeft().trimRight(),
          address: _acontroller.text.trimLeft().trimRight(),
          email: _econtroller.text.trimLeft().trimRight());
      await addVendor(vendordata);
      refreshVendorData(widget.eventid);
      ScaffoldMessenger.of(mtx).showSnackBar(
        const SnackBar(
          content: Text("Successfully added"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
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
        print('User cancelled picking contact');
        // Handle the cancellation (e.g., show a message to the user)
      } else {
        // Handle other exceptions
        print('Error picking contact: $e');
      }
    }
  }
}
