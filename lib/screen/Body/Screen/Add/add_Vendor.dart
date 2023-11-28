import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:intl/intl.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Vendors/vendors_model.dart';
import 'package:project_event/screen/Body/widget/List/categorydropdown.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield_blue.dart';
import 'package:project_event/screen/Body/widget/sub/ContactState.dart';
import 'package:sizer/sizer.dart';

class AddVendor extends StatefulWidget {
  final int eventid;

  const AddVendor({super.key, required this.eventid});

  @override
  State<AddVendor> createState() => _AddVendorState();
}

class _AddVendorState extends State<AddVendor> {
  final _formKey = GlobalKey<FormState>();

  PhoneContact? _phoneContact;

  @override
  Widget build(BuildContext context) {
    log('event id : ${widget.eventid}');

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
                  addVendorclick(context);
                }),
          ],
          titleText: 'Add Vendors',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(1.h),
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
                onChanged: (value) {
                  String numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
                  final formatValue = _formatCurrency(numericValue);
                  _budgetController.value = _budgetController.value.copyWith(
                    text: formatValue,
                    selection:
                        TextSelection.collapsed(offset: formatValue.length),
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Estimated Amount is required';
                  }
                  return null;
                },
                keyType: TextInputType.number,
                textcontent: 'Estimated Amount',
                controller: _budgetController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
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
            ]),
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _acontroller = TextEditingController();
  final TextEditingController _econtroller = TextEditingController();

  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _clientnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> addVendorclick(BuildContext ctx) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      try {
        final vendordata = VendorsModel(
          name: _nameController.text.toUpperCase().trimLeft().trimRight(),
          category: _categoryController.text,
          esamount: _budgetController.text.trimLeft().trimRight(),
          eventid: widget.eventid,
          clientname: _clientnameController.text.toUpperCase(),
          note: _noteController.text.trimLeft().trimRight(),
          address: _acontroller.text.trimLeft().trimRight(),
          email: _econtroller.text,
          number: _phoneController.text.trimLeft().trimRight(),
          paid: 0,
          pending: int.parse(
              _budgetController.text.replaceAll(RegExp(r'[^0-9]'), '')),
          status: 0,
        );
        Navigator.pop(ctx);

        await addVendor(vendordata).then((value) => log("success "));
        await refreshVendorData(widget.eventid);
      } catch (e) {
        log('Error adding vendor: $e');
      }
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
      } else {
        print('Error picking contact: $e');
      }
    }
  }
}
