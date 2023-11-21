import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/screen/Body/Screen/main/Event/viewevent.dart';
import 'package:project_event/screen/Body/Screen/main/home_screen.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

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
                                height: 200,
                                width: double.infinity,
                                child: Image.file(
                                  File(data.imagex),
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                        Container(
                          height: 205,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
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
                                    style: racingSansOne(fontSize: 18),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${data.startingDay}  at  ${data.startingTime}',
                                        style: racingSansOne(fontSize: 13),
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
    );
  }
}
