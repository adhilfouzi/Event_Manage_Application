import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymentdetail.dart';
import 'package:project_event/Database/model/Vendors/vendors_model.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomborderappbar.dart';
import 'package:project_event/screen/Body/widget/box/viewbox.dart';
import 'package:project_event/screen/Body/widget/sub/paymentbar.dart';

class ViewVendor extends StatelessWidget {
  final VendorsModel vendor;

  const ViewVendor({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    refreshPaymentTypeData(vendor.id!, vendor.eventid);
    refreshbalancedata(vendor.id!, vendor.eventid, 1, vendor.esamount);

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.delete, onPressed: () {}),
          AppAction(
              icon: Icons.edit,
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => EditBudget(vendordata: vendor),
                // ));
              }),
        ],
        titleText: ' ',
        bottom: const BottomBorderNull(),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                      ViewBox(
                          textcontent: 'Category',
                          controller: vendor.category!),
                      ViewBox(textcontent: 'Note', controller: vendor.note!),
                      const SizedBox(height: 15),
                      ViewBox(
                          textcontent: 'Estimatrd Amount',
                          controller: vendor.esamount),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: balance,
                        builder: (context, value, child) => PaymentsBar(
                            eAmount: value.total.toString(),
                            pending: value.pending.toString(),
                            paid: value.paid.toString()),
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Payments', style: raleway()),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            constraints: const BoxConstraints(
                                maxHeight: 150, minHeight: 0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: buttoncolor, width: 1),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ValueListenableBuilder(
                              valueListenable: vendorPaymentDetails,
                              builder: (context, value, child) {
                                if (value.isNotEmpty) {
                                  return ListView.builder(
                                    itemCount: value.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final data = value[index];
                                      return ListTile(
                                        onTap: () {
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         EditPayments(paydata: data)));
                                        },
                                        leading: Image.asset(
                                          'assets/UI/icons/person.png',
                                        ),
                                        title: Text(
                                          data.name,
                                          style: raleway(color: Colors.black),
                                        ),
                                        trailing: Text(
                                          "₹${data.pyamount}",
                                          style: racingSansOne(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                            'assets/UI/icons/nodata.png',
                                            height: 70,
                                            width: 70),
                                        const SizedBox(height: 10),
                                        Text(
                                          'No Payments Found',
                                          style: raleway(
                                              fontSize: 13,
                                              color: Colors.black),
                                        )
                                      ]);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
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
                            const Divider(
                              color: buttoncolor,
                              height: 20,
                              thickness: 2,
                              endIndent: 40,
                              indent: 40,
                            ),
                            const SizedBox(height: 15),
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
            ),
          )
        ]),
      ),
    );
  }
}
