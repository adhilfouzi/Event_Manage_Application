import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/List/eventviewdata.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class Report extends StatelessWidget {
  const Report({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          AppAction(icon: Icons.search, onPressed: () {}),
          AppAction(icon: Icons.more_vert, onPressed: () {}),
        ],
        titleText: 'Report',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            final cardInfo = cardData[index];
            return Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: buttoncolor, width: 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image(image: cardInfo['image'], width: 110),
                          title: Text(
                            cardInfo['text'],
                            style: raleway(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (cardInfo['report'] != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              cardInfo['report'](),
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Pending',
                                        style: raleway(
                                          color: Colors.red,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        '5',
                                        style: raleway(
                                          color: Colors.red,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    if (cardInfo['report'] != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              cardInfo['report'](),
                                        ),
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Completed',
                                        style: raleway(
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        '5',
                                        style: raleway(
                                          color: Colors.green,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
