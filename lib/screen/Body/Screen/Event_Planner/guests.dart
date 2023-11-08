import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/screen/Body/Screen/Add/add_guest.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_guest.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';
import 'package:project_event/screen/Body/widget/Scaffold/floatingpointx.dart';

class Guests extends StatelessWidget {
  final int eventid;
  const Guests({super.key, required this.eventid});

  @override
  Widget build(BuildContext context) {
    refreshguestdata(eventid);

    return Scaffold(
      appBar: CustomAppBar(actions: [
        AppAction(icon: Icons.search, onPressed: () {}),
        AppAction(icon: Icons.more_vert, onPressed: () {})
      ], titleText: 'Guests'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: guestlist,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = value[index];
                  return Slidable(
                    key: const ValueKey(1),
                    startActionPane: ActionPane(
                      dragDismissible: false,
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            int fine = data.status = 0;
                            editGuest(
                                data.id,
                                data.eventid,
                                data.gname,
                                data.sex,
                                data.note,
                                fine,
                                data.number,
                                data.email,
                                data.address);
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.pending_actions,
                          label: 'Pending',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dragDismissible: false,
                      dismissible: DismissiblePane(onDismissed: () {}),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) {
                            int fine = data.status = 1;
                            editGuest(
                                data.id,
                                data.eventid,
                                data.gname,
                                data.sex,
                                data.note,
                                fine,
                                data.number,
                                data.email,
                                data.address);
                          },
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.verified,
                          label: 'invited',
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      EditGuest(guestdata: data)));
                            },
                            leading: Image.asset('assets/UI/icons/person.png'),
                            title: Text(
                              data.gname,
                              style: raleway(color: Colors.black),
                            ),
                            subtitle: Text(
                              data.status == 0
                                  ? 'Pending invitation'
                                  : 'Invitation sent',
                              style: raleway(
                                color: data.status == 0
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 12,
                              ),
                            ),
                            // trailing: Text(
                            //   '+1',
                            //   style: racingSansOne(
                            //       color: Colors.black54,
                            //       fontWeight: FontWeight.normal),
                            // ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No Guest available',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingPointx(
          goto: AddGuest(
        eventID: eventid,
      )),
    );
  }
}

void doNothing(BuildContext context) {}
