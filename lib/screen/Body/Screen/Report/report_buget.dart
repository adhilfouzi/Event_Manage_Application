import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class RpBudget extends StatelessWidget {
  const RpBudget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [
        AppAction(icon: Icons.search, onPressed: () {}),
        AppAction(icon: Icons.more_vert, onPressed: () {})
      ], titleText: 'Budget'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
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
                      'Guest Stay',
                      style: raleway(color: Colors.black),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pending',
                              style: raleway(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '25000',
                              style: racingSansOne(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pending:20,000',
                              style: racingSansOne(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Paid: 5000',
                              style: racingSansOne(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ],
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
