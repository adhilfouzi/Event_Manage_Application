import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/screen/Body/Screen/main/Event/viewevent.dart';
import 'package:project_event/screen/Body/Screen/main/home_screen.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:sizer/sizer.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(actions: [], titleText: 'Favorite Events'),
      body: ValueListenableBuilder(
        valueListenable: favoriteEventlist,
        builder: (context, value, child) {
          if (value.isEmpty) {
            return Center(
              child: Text(
                'No Event available',
                style: TextStyle(fontSize: 18.sp),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                final data = value[index];
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 1.h, vertical: 0.5.h),
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
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.transparent, // Start with transparency
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.eventname,
                                    style: racingSansOne(fontSize: 13.sp),
                                  ),
                                  Text(
                                    '${data.startingDay}  at  ${data.startingTime}',
                                    style: racingSansOne(fontSize: 10.sp),
                                  ),
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    data.location,
                                    style: racingSansOne(fontSize: 10.sp),
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
    );
  }
}
