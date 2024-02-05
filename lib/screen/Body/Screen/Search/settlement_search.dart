import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/database/functions/fn_incomemodel.dart';
import 'package:project_event/database/model/payment/pay_model.dart';
import 'package:project_event/screen/body/screen/edit/edit_income.dart';
import 'package:sizer/sizer.dart';

class IncomeSearch extends StatefulWidget {
  const IncomeSearch({super.key});

  @override
  State<IncomeSearch> createState() => _IncomeSearchState();
}

class _IncomeSearchState extends State<IncomeSearch> {
  List<IncomeModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = incomePaymentList.value;
  }

  void _runFilter(String enteredKeyword) {
    List<IncomeModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = incomePaymentList.value;
    } else {
      result = incomePaymentList.value
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
        child: ValueListenableBuilder<List<IncomeModel>>(
            valueListenable: incomePaymentList,
            builder: (context, value, child) {
              return Padding(
                padding: EdgeInsets.all(1.h),
                child: finduser.isEmpty
                    ? Center(
                        child: Text(
                          'No Income Data Available',
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
                                finduserItem.pyamount,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                Get.to(EditIncome(
                                  paydata: finduserItem,
                                  // val: 1,
                                ));
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
