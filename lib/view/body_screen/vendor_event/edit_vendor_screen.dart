import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_event/controller/event_controller/vendor_event/vendor_delete_conformation.dart';

import 'package:project_event/model/db_functions/fn_vendormodel.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/vendors/vendors_model.dart';

import 'package:project_event/controller/widget/box/textfield_blue.dart';
import 'package:project_event/controller/services/categorydropdown_widget.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/controller/widget/sub/contact_form_widget.dart';
import 'package:project_event/model/getx/snackbar/getx_snackbar.dart';
import 'package:project_event/view/body_screen/vendor_event/vendor_report/rp_done_vendor_screen.dart';
import 'package:project_event/view/body_screen/vendor_event/vendor_report/rp_pending_vendors_screen.dart';
import 'package:project_event/view/body_screen/vendor_event/vendors_screen.dart';

import 'package:sizer/sizer.dart';

class EditVendor extends StatefulWidget {
  final Eventmodel eventModel;
  final int step;

  final VendorsModel vendordataway;
  const EditVendor(
      {super.key,
      required this.vendordataway,
      required this.eventModel,
      required this.step});

  @override
  State<EditVendor> createState() => _EditVendorState();
}

class _EditVendorState extends State<EditVendor> {
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
                icon: Icons.delete,
                onPressed: () {
                  doDeleteVendor(
                      widget.vendordataway, widget.step, widget.eventModel);
                }),
            AppAction(
                icon: Icons.contacts,
                onPressed: () {
                  getcontact();
                }),
            AppAction(
                icon: Icons.done,
                onPressed: () {
                  editVendorclick(widget.step);
                }),
          ],
          titleText: 'Edit Vendors',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(2.h),
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
              // PaymentsBar(),
              // Payments(),
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

  Future<void> editVendorclick(int step) async {
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
          widget.vendordataway.paid,
          widget.vendordataway.pending,
          widget.vendordataway.status);

      await refreshVendorData(widget.vendordataway.eventid);

      if (step == 2) {
        Get.offAll(
            transition: Transition.rightToLeftWithFade,
            //     allowSnapshotting: false,
            fullscreenDialog: true,
            Vendors(
              eventModel: widget.eventModel,
              eventid: widget.eventModel.id!,
            ));
      } else if (step == 1) {
        Get.back();
      } else if (step == 3) {
        Get.offAll(PendingRpVendorList(eventModel: widget.eventModel));
      } else if (step == 4) {
        Get.offAll(DoneRpVendorList(eventModel: widget.eventModel));
      }
      SnackbarModel.successSnack();
    } else {
      SnackbarModel.errorSnack();
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
