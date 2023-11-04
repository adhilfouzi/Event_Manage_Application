import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/widget/Scaffold/app_bar.dart';

class Settlement extends StatelessWidget {
  const Settlement({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        actions: [
          AppAction(icon: Icons.search, onPressed: () {}),
          AppAction(icon: Icons.more_vert, onPressed: () {}),
        ],
        title: Text(
          'Settlement',
          style: racingSansOne(
              fontWeight: FontWeight.w500, fontSize: 22, color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Expenses',
                          style: readexPro(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '₹72,000',
                          style: readexPro(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  VerticalDivider(
                    endIndent: 15,
                    indent: 15,
                    width: 1,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Credit',
                          style: readexPro(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '₹100,000',
                          style: readexPro(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  VerticalDivider(
                    endIndent: 15,
                    indent: 15,
                    width: 1,
                    thickness: 2,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Balance',
                          style: readexPro(fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '+₹32,000',
                          style: readexPro(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 14,
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
                    leading: Image.asset(
                      'assets/UI/icons/person.png',
                    ),
                    title: Text(
                      'Sugith k',
                      style: raleway(color: Colors.black),
                    ),
                    subtitle: Text(
                      'Paid on 15/10/23',
                      style: readexPro(
                        color: Colors.black45,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      '+₹ 15000',
                      style: racingSansOne(
                          color: Colors.black54, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      //floatingActionButton: FloatingPointx(goto: AddGuest()),
    );
  }
}
