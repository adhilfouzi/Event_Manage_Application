import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/Screen/Drawer/appinfo.dart';
import 'package:project_event/screen/Body/Screen/Drawer/privacy.dart';
import 'package:project_event/screen/Body/Screen/Drawer/reset.dart';
import 'package:project_event/screen/Body/Screen/Drawer/terms.dart';
import 'package:project_event/screen/Body/Screen/main/Event/add_event.dart';
import 'package:project_event/screen/Body/Screen/main/Event/viewevent.dart';
import 'package:project_event/screen/Body/widget/Scaffold/floatingpointx.dart';
import 'package:project_event/screen/Body/widget/List/listtiledrawer.dart';
import 'package:project_event/screen/Body/widget/box/small_button.dart';
import 'package:project_event/screen/Body/widget/box/textfield.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    refreshEventdata();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                clearDb();
              },
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: Colors.transparent, //appbarcolor,
        toolbarHeight: 100,
        title: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            'assets/UI/Event Logo/event logo name.png',
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Column(
            children: [
              TextFieldicon(
                controller: searchController,
                icondata: Icons.search,
                textcontent: 'Search event',
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(buttoncolor),
                  ),
                  child: const Text(
                    'All',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 5),
                const SmallButton(textdata: 'Done'),
                const SizedBox(width: 5),
                const SmallButton(textdata: 'Pending'),
                const SizedBox(width: 5),
                const SmallButton(textdata: 'Cancelled'),
                const SizedBox(width: 5),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: eventList,
              builder: (context, value, child) {
                if (value.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Event available',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final data = value[index];
                      return Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                                      height: 260,
                                      width: double.infinity,
                                      child: Image.file(
                                        File(data.imagex),
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                              ),
                              Container(
                                height: 265,
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
                                          style: racingSansOne(fontSize: 18),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '${data.startingDay}  at  ${data.startingTime}',
                                              style:
                                                  racingSansOne(fontSize: 13),
                                            ),
                                            const SizedBox(width: 30),
                                            Text(
                                              data.location,
                                              style: racingSansOne(),
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
          color: const Color.fromRGBO(152, 228, 255, 1.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 20),

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
                  map: Reset(),
                  imagedata: 'assets/UI/icons/favorite.png',
                  textdata: 'Favorite'),
              const SizedBox(height: 15),
              const ListTileDrawer(
                  map: Reset(),
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
      floatingActionButton: const FloatingPointx(goto: AddEvent()),
    );
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
}

void clearDb() {
  clearEventDatabase();
  clearTaskDatabase();
  clearBudgetDatabase();
  clearGuestDatabase();
  clearVendorDatabase();
}
