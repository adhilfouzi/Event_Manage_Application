import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Vendors/vendors_model.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_vendor.dart';

class VendorSearch extends StatefulWidget {
  const VendorSearch({super.key});

  @override
  State<VendorSearch> createState() => _VendorSearchState();
}

class _VendorSearchState extends State<VendorSearch> {
  List<VendorsModel> finduser = [];

  @override
  void initState() {
    super.initState();
    finduser = vendortlist.value;
    // Initialize with the current student list
  }

  void _runFilter(String enteredKeyword) {
    List<VendorsModel> result = [];
    if (enteredKeyword.isEmpty) {
      result = vendortlist.value;
    } else {
      result = vendortlist.value
          .where((student) =>
              student.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.clientname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      finduser = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<List<VendorsModel>>(
            valueListenable: vendortlist,
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(
                              color: buttoncolor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: buttoncolor,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search',
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    Expanded(
                      child: finduser.isEmpty
                          ? const Center(
                              child: Text(
                                'No Data Available',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              itemCount: finduser.length,
                              itemBuilder: (context, index) {
                                final finduserItem = finduser[index];
                                return Card(
                                  color: Colors.blue[100],
                                  elevation: 4,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    title: Text(
                                      finduserItem.name,
                                      style: raleway(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    subtitle: Text(
                                      finduserItem.clientname,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          dodeletevendor(context, finduserItem);
                                        }),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (ctr) => EditVendor(
                                              vendordataway: finduserItem),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

void dodeletevendor(rtx, VendorsModel student) {
  try {
    showDialog(
      context: rtx,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: Text('Do You Want delete  ${student.name} ?'),
          actions: [
            TextButton(
                onPressed: () {
                  delectYes(context, student);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(rtx);
                },
                child: const Text('No'))
          ],
        );
      },
    );
  } catch (e) {
    print('Error deleting data: $e');
  }
}

void delectYes(ctx, VendorsModel student) {
  try {
    deleteVendor(student.id, student.eventid);
    Navigator.of(ctx).pop();
    Navigator.of(ctx).pop();

    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        content: Text("Successfully Deleted"),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: Colors.grey,
        duration: Duration(seconds: 2),
      ),
    );
  } catch (e) {
    print('Error inserting data: $e');
  }
}
