import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/screen/Body/Screen/Add/add_payments.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_payments.dart';
import 'package:project_event/screen/Body/widget/Scaffold/floatingpointx.dart';

class BudgetSettlement extends StatelessWidget {
  final int eventID;
  const BudgetSettlement({super.key, required this.eventID});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: budgetPaymentList,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = value[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: buttoncolor, width: 1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditPayments(paydata: data)));
                        },
                        leading: Image.asset(
                          'assets/UI/icons/person.png',
                        ),
                        title: Text(
                          data.name,
                          style: raleway(color: Colors.black),
                        ),
                        subtitle: Text(
                          'Paid on ${data.date}, ${data.time}',
                          style: readexPro(
                            color: Colors.black45,
                            fontSize: 10,
                          ),
                        ),
                        trailing: Text(
                          "₹${data.pyamount}",
                          style: racingSansOne(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No Budget Payment available',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingPointx(
            goto: AddPayments(
          eventID: eventID,
        )),
      ),
    );
  }
}
