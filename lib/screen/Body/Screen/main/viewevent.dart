import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/model/Event/event_model.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/budget.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/guests.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/report.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/settlement.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/task_list.dart';
import 'package:project_event/screen/Body/Screen/Event_Planner/vendors.dart';

import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class ViewEvent extends StatelessWidget {
  final Eventmodel eventModel;

  ViewEvent({
    Key? key,
    required this.eventModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        textcolor: Colors.white,
        actions: [AppAction(icon: Icons.more_vert, onPressed: () {})],
        titleText: 'Event Planner & Organizer',
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.file(
                  File(eventModel.imagex),
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.center,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                    stops: [0.3, 1.0],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 50,
                right: 50,
                child: Column(
                  children: [
                    Text(
                      eventModel.eventname,
                      style: racingSansOne(fontSize: 20),
                    ),
                    Text(
                      '19 : 20 : 14 : 52',
                      style: racingSansOne(fontSize: 20),
                    ),
                    Text(
                      'Days : Hrs : Mins : Secs',
                      style: racingSansOne(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),

//----------------------------------------------------------//
          //----------------------------------------------------------//
          Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctr) => TaskList(
                                  eventid: eventModel.id!,
                                ),
                              ),
                            ),
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              color: const Color.fromRGBO(227, 100, 136, 1),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Image(
                                      image: AssetImage(
                                          'assets/UI/icons/Task List.png'),
                                      width: 90),
                                  Text(
                                    'Task List',
                                    style: raleway(color: Colors.white),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctr) => const Guests(),
                              ),
                            ),
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              color: const Color.fromRGBO(234, 28, 140, 1),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Image(
                                      image: AssetImage(
                                          'assets/UI/icons/Guests.png'),
                                      width: 90),
                                  Text(
                                    'Guests',
                                    style: raleway(color: Colors.white),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctr) => const Budget(),
                              ),
                            ),
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              color: const Color.fromRGBO(211, 234, 43, 1),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Image(
                                      image: AssetImage(
                                          'assets/UI/icons/budget.png'),
                                      width: 90),
                                  Text(
                                    'Budget',
                                    style: raleway(color: Colors.white),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctr) => const Vendors(),
                              ),
                            ),
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              color: const Color.fromRGBO(250, 166, 68, 11),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Image(
                                      image: AssetImage(
                                          'assets/UI/icons/vendors.png'),
                                      width: 90),
                                  Text(
                                    'Vendors',
                                    style: raleway(color: Colors.white),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctr) => const Report(),
                              ),
                            ),
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              color: const Color.fromRGBO(129, 236, 114, 1),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Image(
                                      image: AssetImage(
                                          'assets/UI/icons/report.png'),
                                      width: 90),
                                  Text(
                                    'Report',
                                    style: raleway(color: Colors.white),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctr) => const Settlement(),
                              ),
                            ),
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 4,
                              color: const Color.fromRGBO(67, 229, 181, 1),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20),
                                  const Image(
                                      image: AssetImage(
                                          'assets/UI/icons/settlement.png'),
                                      width: 90),
                                  Text(
                                    'Settlementt',
                                    style: raleway(color: Colors.white),
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
