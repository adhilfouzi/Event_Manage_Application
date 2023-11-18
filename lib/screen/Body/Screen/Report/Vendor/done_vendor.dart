import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_vendor.dart';
import 'package:project_event/screen/Body/Screen/View/view_vendor.dart';
import 'package:project_event/screen/Body/widget/List/list.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class DoneRpVendorList extends StatelessWidget {
  const DoneRpVendorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [
        AppAction(
            icon: Icons.search,
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (ctr) => const VendorSearch(),
              // ));
            }),
        AppAction(icon: Icons.more_vert, onPressed: () {})
      ], titleText: 'Vendors'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: vendorDonelist,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = value[index];
                  final categoryItem = category.firstWhere(
                    (item) => item['text'] == data.category,
                    orElse: () => {
                      'image':
                          const AssetImage('assets/UI/icons/Accommodation.png'),
                    },
                  );
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
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewVendor(vendor: data))),
                        onLongPress: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditVendor(vendordataway: data))),
                        leading: Image(image: categoryItem['image']),
                        title: Text(
                          data.name,
                          style: raleway(color: Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.status == 0 ? 'Pending' : 'Completed',
                                  style: raleway(
                                    color: data.status == 0
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '₹ ${data.esamount}',
                                  style: racingSansOne(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pending: ₹${data.pending}',
                                  style: racingSansOne(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Paid: ₹${data.paid}',
                                  style: racingSansOne(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No Vendors available',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
