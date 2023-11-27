import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/Database/model/Payment/pay_model.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_payments.dart';
import 'package:sizer/sizer.dart';

class VendorSettlementSearch extends StatefulWidget {
  const VendorSettlementSearch({super.key});

  @override
  State<VendorSettlementSearch> createState() => _VendorSettlementSearchState();
}

class _VendorSettlementSearchState extends State<VendorSettlementSearch> {
  List<PaymentModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = vendorPaymentlist.value;
  }

  void _runFilter(String enteredKeyword) {
    List<PaymentModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = vendorPaymentlist.value;
    } else {
      result = vendorPaymentlist.value
          .where((student) =>
              student.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.pyamount
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.date.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      finduser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:
              Colors.white, //const Color.fromRGBO(255, 200, 200, 1),

          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: TextField(
              autofocus: true,
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          )),
      body: SafeArea(
        child: ValueListenableBuilder<List<PaymentModel>>(
            valueListenable: vendorPaymentlist,
            builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.all(1.h),
                child: finduser.isEmpty
                    ? Center(
                        child: Text(
                          'No Vendor settlement Available',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      )
                    : ListView.builder(
                        itemCount: finduser.length,
                        itemBuilder: (context, index) {
                          final finduserItem = finduser[index];
                          return Card(
                            color: Colors.blue[100],
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text(
                                finduserItem.name,
                                style: raleway(
                                  color: Colors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                              subtitle: Text(
                                finduserItem.date,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Text(
                                "₹${finduserItem.pyamount}",
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctr) => EditPayments(
                                      paydata: finduserItem,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
              );
            }),
      ),
    );
  }
}
