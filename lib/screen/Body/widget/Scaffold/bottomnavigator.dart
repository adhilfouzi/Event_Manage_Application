import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_event/screen/Body/Screen/Drawer/calender.dart';
import 'package:project_event/screen/Body/Screen/Drawer/favorite.dart';
import 'package:project_event/screen/Body/Screen/main/Event/accountscreen.dart';
import 'package:project_event/screen/Body/Screen/main/Event/add_event.dart';
import 'package:project_event/screen/Body/Screen/main/home_screen.dart';
import 'package:sizer/sizer.dart';

class MainBottom extends StatefulWidget {
  const MainBottom({super.key});

  @override
  State<MainBottom> createState() => _MainButtomState();
}

class _MainButtomState extends State<MainBottom> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(255, 200, 200, 1),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.5.h),
          child: GNav(
            backgroundColor: const Color.fromRGBO(255, 200, 200, 1),
            color: const Color.fromARGB(255, 250, 3, 3),
            activeColor: const Color.fromARGB(255, 255, 255, 255),
            tabBackgroundColor: const Color(0XFFFFE6C7),
            tabBackgroundGradient: const LinearGradient(colors: [
              Color.fromRGBO(255, 200, 200, 1),
              Color.fromARGB(255, 250, 3, 3)
            ]),
            gap: 6.0,
            padding: const EdgeInsets.all(10.0),
            tabs: const [
              GButton(text: 'Home', icon: Icons.home),
              GButton(text: 'Add Event', icon: Icons.add),
              GButton(text: 'Calender', icon: Icons.calendar_month),
              GButton(text: 'Profile', icon: Icons.person),
            ],
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  // Define your pages or sections here
  final List<Widget> _pages = [
    // Replace these with your actual pages or widgets
    const HomeScreen(),
    const AddEvent(),
    const Calender(),
    const ProfileAccount()
  ];
}
