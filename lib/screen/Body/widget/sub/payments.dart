import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:sizer/sizer.dart';

class Payments extends StatelessWidget {
  final ValueListenable<Object?> valueListenable;
  // final Widget goto;
  const Payments({
    super.key,
    required this.valueListenable,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Payments', style: raleway()),
            ],
          ),
          SizedBox(height: 1.h),
          Container(
            constraints: BoxConstraints(maxHeight: 18.h, minHeight: 0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: buttoncolor, width: 1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ValueListenableBuilder(
              valueListenable: valueListenable as ValueNotifier,
              builder: (context, value, child) {
                if (value.isNotEmpty) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = value[index];
                      return ListTile(
                        onTap: () {},
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/UI/icons/nodata.png',
                            height: 70, width: 70),
                        SizedBox(height: 2.h),
                        Text(
                          'No Payments Found',
                          style: raleway(fontSize: 13, color: Colors.black),
                        )
                      ]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
