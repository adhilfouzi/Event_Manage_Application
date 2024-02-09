import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_event/controller/event_controller/vendor_event/vendor_delete_conformation.dart';
import 'package:project_event/model/core/color/color.dart';
import 'package:project_event/model/core/font/font.dart';
import 'package:project_event/model/db_functions/fn_paymentdetail.dart';
import 'package:project_event/model/data_model/event/event_model.dart';
import 'package:project_event/model/data_model/vendors/vendors_model.dart';
import 'package:project_event/view/body_screen/vendor_event/edit_vendor_screen.dart';

import 'package:project_event/controller/widget/box/viewbox.dart';
import 'package:project_event/controller/widget/scaffold/app_bar.dart';
import 'package:project_event/controller/widget/scaffold/bottomborderappbar.dart';
import 'package:project_event/controller/widget/sub/paymentbar_widget.dart';
import 'package:project_event/controller/widget/sub/view_payment_per_person_screen.dart';
import 'package:sizer/sizer.dart';

class ViewVendor extends StatelessWidget {
  final Eventmodel eventModel;
  final int step;
  final VendorsModel vendor;

  const ViewVendor(
      {super.key,
      required this.vendor,
      required this.eventModel,
      required this.step});

  @override
  Widget build(BuildContext context) {
    refreshPaymentTypeData(vendor.id!, vendor.eventid);
    refreshbalancedata(vendor.id!, vendor.eventid, 1, vendor.esamount);

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(
              icon: Icons.delete,
              onPressed: () {
                doDeleteVendor(vendor, step, eventModel);
              }),
          AppAction(
              icon: Icons.edit,
              onPressed: () {
                Get.to(
                    transition: Transition.rightToLeftWithFade,
                    EditVendor(
                      step: step,
                      eventModel: eventModel,
                      vendordataway: vendor,
                    ));
              }),
        ],
        titleText: ' ',
        bottom: const BottomBorderNull(),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(1.h, 0, 1.h, 1.h),
            child: Column(children: [
              SizedBox(height: 1.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(2.3.h),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(216, 239, 225, 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    ViewBox(textcontent: 'Name ', controller: vendor.name),
                    ViewBoxAccommodation(
                        textcontent: 'Category', controller: vendor.category!),
                    ViewBox(textcontent: 'Note', controller: vendor.note!),
                    SizedBox(height: 1.h),
                    ViewBox(
                        textcontent: 'Estimatrd Amount',
                        controller: vendor.esamount),
                    SizedBox(height: 1.h),
                    ValueListenableBuilder(
                      valueListenable: balance,
                      builder: (context, value, child) => PaymentsBar(
                          eAmount: value.total.toString(),
                          pending: value.pending.toString(),
                          paid: value.paid.toString()),
                    ),
                    SizedBox(height: 1.h),
                    Payments(valueListenable: vendorPaymentDetails),
                    Container(
                      margin: EdgeInsets.all(1.h),
                      padding: EdgeInsets.fromLTRB(0.5.h, 1.h, 0.5.h, 1.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: buttoncolor, width: 1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Contact Details',
                            style: raleway(),
                          ),
                          Divider(
                            color: buttoncolor,
                            height: 1.h,
                            thickness: 2,
                            endIndent: 40,
                            indent: 40,
                          ),
                          SizedBox(height: 1.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ViewBox(
                                  textcontent: 'Clientname ',
                                  controller: vendor.clientname),
                              ViewBox(
                                  textcontent: 'Phone Number',
                                  controller: vendor.number!),
                              ViewBox(
                                  textcontent: 'Email Id',
                                  controller: vendor.email!),
                              ViewBox(
                                  textcontent: 'Address',
                                  controller: vendor.address!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
