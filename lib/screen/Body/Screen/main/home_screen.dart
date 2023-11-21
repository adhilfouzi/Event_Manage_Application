import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/Screen/Drawer/appinfo.dart';
import 'package:project_event/screen/Body/Screen/Drawer/calender.dart';
import 'package:project_event/screen/Body/Screen/Drawer/favorite.dart';
import 'package:project_event/screen/Body/Screen/Drawer/feedback.dart';
import 'package:project_event/screen/Body/Screen/Drawer/privacy.dart';
import 'package:project_event/screen/Body/Screen/Drawer/reset.dart';
import 'package:project_event/screen/Body/Screen/Drawer/terms.dart';
import 'package:project_event/screen/Body/Screen/main/Event/viewevent.dart';
import 'package:project_event/screen/Body/widget/List/listtiledrawer.dart';
import 'package:project_event/screen/Body/widget/box/textfield.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  DateTime timeback = DateTime.now();

  @override
  Widget build(BuildContext context) {
    refreshEventdata();
    return WillPopScope(
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
            actions: const [],
            backgroundColor: Colors.transparent, //appbarcolor,
            toolbarHeight: 12.h,
            title: SizedBox(
              height: 14.h,
              child: Image.asset(
                'assets/UI/Event Logo/event logo name.png',
              ),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 6.h),
              child: Column(
                children: [
                  TextFieldicon(
                    controller: searchController,
                    icondata: Icons.search,
                    textcontent: 'Search event',
                  ),
                  SizedBox(height: 5.sp)
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: eventList,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return Center(
                        child: Text(
                          'No Event available',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final data = value[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.h, vertical: 1.5.h),
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
                                          height: 26.h,
                                          width: double.infinity,
                                          child: Image.file(
                                            File(data.imagex),
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                                  ),
                                  Container(
                                    height: 27.2.h,
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
                                        )),
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
          drawer: Drawer(
            child: Container(
              color: const Color.fromRGBO(255, 200, 200, 0.7),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(height: 5.h),
                  // Header section
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: const Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/UI/image/shafeeq.png'),
                          radius: 40,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Abhishek Mishra",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.black, thickness: 0.5),
                  const SizedBox(height: 15),
                  const ListTileDrawer(
                      map: Privacy(),
                      imagedata: 'assets/UI/icons/icons8-settings-500.png',
                      textdata: 'Settings++++'),
                  const SizedBox(height: 15),
                  const ListTileDrawer(
                      map: Favorite(),
                      imagedata: 'assets/UI/icons/favorite.png',
                      textdata: 'Favorite'),
                  const SizedBox(height: 15),
                  const ListTileDrawer(
                      map: Calender(),
                      imagedata: 'assets/UI/icons/calendar.png',
                      textdata: 'Calendar'),
                  const SizedBox(height: 15),
                  const ListTileDrawer(
                      map: AppInfo(),
                      imagedata: 'assets/UI/icons/about us.png',
                      textdata: 'App info'),
                  const SizedBox(height: 15),
                  const ListTileDrawerEmail(),
                  const SizedBox(height: 15),
                  const ListTileDrawer(
                      map: Privacy(),
                      imagedata: 'assets/UI/icons/privacy.png',
                      textdata: 'Privacy'),
                  const SizedBox(height: 15),
                  const ListTileDrawer(
                      map: Terms(),
                      imagedata: 'assets/UI/icons/terms of service.png',
                      textdata: 'Terms of Service'),
                  const SizedBox(height: 15),
                  const ListTileDrawer(
                      map: Reset(),
                      imagedata: 'assets/UI/icons/backup.png',
                      textdata: 'Reset Data'),
                ],
              ),
            ),
          ),
          //floatingActionButton: const FloatingPointx(goto: AddEvent()),
        ));
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
