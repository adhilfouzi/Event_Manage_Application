import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project_event/core/color/font.dart';
import 'package:project_event/database/functions/fn_budgetmodel.dart';
import 'package:project_event/database/functions/fn_evenmodel.dart';
import 'package:project_event/database/functions/fn_guestmodel.dart';
import 'package:project_event/database/functions/fn_paymodel.dart';
import 'package:project_event/database/functions/fn_taskmodel.dart';
import 'package:project_event/database/functions/fn_vendormodel.dart';
import 'package:project_event/database/model/event/event_model.dart';
import 'package:project_event/screen/body/screen/main/event/viewevent.dart';
import 'package:project_event/screen/body/widget/scaffold/app_bar.dart';
import 'package:project_event/screen/body/widget/box/textfield.dart';
import 'package:sizer/sizer.dart';

ValueNotifier<List<Eventmodel>> eventdata = ValueNotifier([]);

class HomeScreen extends StatefulWidget {
  final int profileid;
  const HomeScreen({super.key, required this.profileid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode(); // Create a FocusNode

  DateTime timeback = DateTime.now();
  @override
  void initState() {
    super.initState();
    search.value.pass = 0;
    finduser = eventList.value;
  }

  List<Eventmodel> finduser = [];

  void _runFilter(String enteredKeyword) {
    List<Eventmodel> result = [];
    if (enteredKeyword.isEmpty) {
      result = eventList.value;
    } else {
      result = eventList.value
          .where((student) =>
              student.eventname
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.clientname!
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              student.startingDay
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
    refreshEventdata(widget.profileid);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child:
          //  PopScope(
          //   canPop: false, // prevent back
          //   onPopInvoked: (_) async {
          //     timeback = DateTime.now();
          //     final difference = DateTime.now().difference(timeback);

          //     if (difference <= const Duration(seconds: 2)) {
          //       return false;
          //     }
          //     else {
          //       return true;
          //     }
          //   },
          //   child:
          Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, //appbarcolor,
          toolbarHeight: 12.h,
          title: SizedBox(
            height: 10.h,
            child: Image.asset(
              'assets/UI/Event Logo/event logo.png',
            ),
          ),
          actions: [
            AppAction(
              icon: search.value.pass == 0
                  ? Ionicons.search_outline
                  : Ionicons.close_outline,
              sizer: 4.h,
              onPressed: () {
                setState(() {
                  if (search.value.pass == 0) {
                    search.value.pass = 8;
                  } else {
                    search.value.pass = 0;
                    searchController.clear();
                    finduser = eventList.value;
                  }
                });
              },
            ),
          ],
          centerTitle: false,
        ),
        body: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: search,
              builder: (context, value, child) {
                return Container(
                  constraints:
                      BoxConstraints(maxHeight: value.pass.h, minHeight: 0),
                  child: TextFieldicon(
                    onChanged: (value) => _runFilter(value),
                    controller: searchController,
                    textcontent: 'Search event...',
                  ),
                );
              },
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: eventList,
                builder: (context, value, child) {
                  if (finduser.isEmpty) {
                    return Center(
                      child: Text(
                        'No Event available',
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: finduser.length,
                      itemBuilder: (context, index) {
                        eventdata.value.clear();
                        final data = finduser[index];
                        eventdata.value.add(data);
                        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                        eventdata.notifyListeners();
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 0.5.h),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewEvent(
                                        eventModel: data,
                                      )));
                            },
                            child: Stack(
                              children: [
                                Card(
                                  color: const Color.fromARGB(255, 26, 27, 28),
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: SizedBox(
                                        height: 28.h,
                                        width: double.infinity,
                                        child: Image.file(
                                          File(data.imagex),
                                          fit: BoxFit.fill,
                                        ),
                                      )),
                                ),
                                Container(
                                  height: 28.8.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  right: 20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.eventname,
                                            style:
                                                racingSansOne(fontSize: 13.sp),
                                          ),
                                          Text(
                                            overflow: TextOverflow.ellipsis,
                                            data.location,
                                            style:
                                                racingSansOne(fontSize: 10.sp),
                                          ),
                                          Text(
                                            '${data.startingDay}  at  ${data.startingTime}',
                                            style:
                                                racingSansOne(fontSize: 10.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  top: 15,
                                  child: IconButton(
                                    onPressed: () {
                                      isFavorite(data);
                                    },
                                    icon: Icon(
                                      data.favorite == 1
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: data.favorite == 1
                                          ? Colors.red
                                          : Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      // ),
    );
  }
}

void clearDb() {
  clearEventDatabase();
  clearTaskDatabase();
  clearBudgetDatabase();
  clearGuestDatabase();
  clearVendorDatabase();
  clearPaymentDatabase();
}

isFavorite(Eventmodel data) {
  int fine = data.favorite == 0 ? 1 : 0;
  editeventdata(
      data.id,
      data.eventname,
      data.budget,
      fine,
      data.location,
      data.about,
      data.startingDay,
      data.startingTime,
      data.clientname,
      data.phoneNumber,
      data.emailId,
      data.address,
      data.imagex,
      data.profile);
}
