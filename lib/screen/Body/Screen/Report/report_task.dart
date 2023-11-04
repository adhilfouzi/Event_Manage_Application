import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class RpTaskList extends StatelessWidget {
  const RpTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [
        AppAction(icon: Icons.search, onPressed: () {}),
        AppAction(icon: Icons.more_vert, onPressed: () {})
      ], titleText: 'Task List'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              key: const ValueKey(1),
              startActionPane: ActionPane(
                dragDismissible: false,
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {}),
                children: const [
                  SlidableAction(
                    onPressed: doNothing,
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
                children: const [
                  SlidableAction(
                    onPressed: doNothing,
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.verified,
                    label: 'Done',
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
                      leading: Image.asset('assets/UI/icons/Accommodation.png'),
                      title: Text(
                        'Gust Stay',
                        style: raleway(color: Colors.black),
                      ),
                      subtitle: Text(
                        'Pending',
                        style: raleway(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                      trailing: Column(children: [
                        Text(
                          '15/10/2023',
                          style: racingSansOne(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          'Subtask: 0/3',
                          style: racingSansOne(
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
