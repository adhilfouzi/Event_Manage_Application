import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';

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
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      child: Column(
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
            constraints: const BoxConstraints(maxHeight: 150, minHeight: 0),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: buttoncolor, width: 1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ValueListenableBuilder(
              valueListenable: valueListenable,
              builder: (context, value, child) {
                if (value == null) {
                  return ListView.builder(
                    itemCount: (value as List).length,
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
                            // subtitle: Text(
                            //   'Paid on ${data.date}, ${data.time}',
                            //   style: readexPro(
                            //     color: Colors.black45,
                            //     fontSize: 10,
                            //   ),
                            // ),
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
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/UI/icons/nodata.png',
                            height: 70, width: 70),
                        const SizedBox(height: 10),
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
