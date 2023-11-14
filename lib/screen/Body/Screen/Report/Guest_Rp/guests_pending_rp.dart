import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/screen/Body/Screen/Edit/edit_guest.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class PendingRpGuests extends StatelessWidget {
  const PendingRpGuests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [
        AppAction(icon: Icons.search, onPressed: () {}),
        AppAction(icon: Icons.more_vert, onPressed: () {})
      ], titleText: 'Guests List'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: guestPendinglist,
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
                          leading: Image.asset('assets/UI/icons/person.png'),
                          title: Text(
                            data.gname,
                            style: raleway(color: Colors.black),
                          ),
                          subtitle: Text(
                            data.status == 0 ? 'Pending' : 'Completed',
                            style: raleway(
                              color:
                                  data.status == 0 ? Colors.red : Colors.green,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditGuest(
                                      guestdata: data,
                                    )));
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'No Task available',
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
