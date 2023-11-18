import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/List/eventviewdata.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class Report extends StatelessWidget {
  final int eventid;

  const Report({super.key, required this.eventid});
  @override
  Widget build(BuildContext context) {
    refreshBudgetData(eventid);
    refreshVendorData(eventid);
    refreshEventtaskdata(eventid);
    refreshguestdata(eventid);
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
                          leading: Image(
                            image: cardInfo['image'],
                            height: 100,
                          ),
                          title: Text(
                            cardInfo['text'],
                            style: raleway(color: Colors.black),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
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
                                child: Text(
                                  'Completed : 5 ',
                                  style: readexPro(
                                    color: Colors.green,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (cardInfo['reportP'] != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            cardInfo['reportP'](),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  'Pending : 5 ',
                                  style: readexPro(
                                    color: Colors.red,
                                    fontSize: 15,
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
