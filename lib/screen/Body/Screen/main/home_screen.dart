import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';

import 'package:project_event/screen/Body/Screen/main/Event/viewevent.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/box/textfield.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
    refreshEventdata();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeback);
          timeback = DateTime.now();
          if (difference >= const Duration(seconds: 2)) {
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent, //appbarcolor,
            toolbarHeight: 12.h,
            title: SizedBox(
              height: 14.h,
              child: Image.asset(
                'assets/UI/Event Logo/event logo name.png',
              ),
            ),
            actions: [
              AppAction(
                icon: search.value.pass == 0
                    ? Ionicons.search_outline
                    : Ionicons.close_outline,
                sizer: 4.h,
                onPressed: () {
                  print("Before - search.value.pass: ${search.value.pass}");
                  setState(() {
                    if (search.value.pass == 0) {
                      search.value.pass = 8;
                    } else {
                      search.value.pass = 0;
                      searchController.clear();
                      FocusScope.of(context).unfocus();
                    }
                  });
                  print("After - search.value.pass: ${search.value.pass}");
                },
              ),
              AppAction(
                  icon: Ionicons.notifications_outline,
                  sizer: 4.h,
                  onPressed: () {}),
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
                      icondata: Icons.search,
                      textcontent: 'Search event',
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
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: finduser.length,
                        itemBuilder: (context, index) {
                          final data = finduser[index];
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
                                    color:
                                        const Color.fromARGB(255, 26, 27, 28),
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(19),
                                    ),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: SizedBox(
                                          height: 20.h,
                                          width: double.infinity,
                                          child: Image.file(
                                            File(data.imagex),
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                  ),
                                  Container(
                                    height: 21.2.h,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors
                                              .transparent, // Start with transparency
                                          Colors.black.withOpacity(
                                              0.9), // Adjust opacity as needed
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
                                              style: racingSansOne(
                                                  fontSize: 13.sp),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  '${data.startingDay}  at  ${data.startingTime}',
                                                  style: racingSansOne(
                                                      fontSize: 10.sp),
                                                ),
                                                const SizedBox(width: 30),
                                                Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  data.location,
                                                  style: racingSansOne(
                                                      fontSize: 10.sp),
                                                ),
                                              ],
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
      ),
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
      data.imagex);
}
