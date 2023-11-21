import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_event/screen/Body/Screen/Drawer/calender.dart';
import 'package:project_event/screen/Body/Screen/Drawer/favorite.dart';
import 'package:project_event/screen/Body/Screen/main/Event/add_event.dart';
import 'package:project_event/screen/Body/Screen/main/home_screen.dart';

class MainBottom extends StatefulWidget {
  const MainBottom({super.key});

  @override
  State<MainBottom> createState() => _MainButtomState();
}

class _MainButtomState extends State<MainBottom> {
//   int myCurrentIndex = 0;
//   final List<Widget> pages = [
//     HomeScreen(),
//     const AddEvent(),
//     const Calender(),
//     const Favorite(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[myCurrentIndex],
//       bottomNavigationBar: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         decoration: BoxDecoration(boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 25,
//               offset: const Offset(8, 20)),
//         ]),
//         //color: Colors.white.withOpacity(0.8),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(30),
//           child: BottomNavigationBar(
//             backgroundColor: Colors.white,
//             selectedItemColor: Colors.blue,
//             unselectedItemColor: Colors.black,
//             currentIndex: myCurrentIndex,
//             onTap: (index) {
//               setState(() {
//                 myCurrentIndex = index;
//               });
//             },
//             items: const [
//               BottomNavigationBarItem(
//                   icon: SizedBox(
//                     height: 30,
//                     width: 30,
//                     child: Icon(Icons.home),
//                   ),
//                   label: 'Home'),
//               BottomNavigationBarItem(
//                   icon: SizedBox(
//                     height: 30,
//                     width: 30,
//                     child: Icon(Icons.add),
//                   ),
//                   label: 'Add Event'),
//               BottomNavigationBarItem(
//                   icon: SizedBox(
//                     height: 30,
//                     width: 30,
//                     child: Icon(Icons.calendar_month),
//                   ),
//                   label: 'Calender'),
//               BottomNavigationBarItem(
//                   icon: SizedBox(
//                     height: 30,
//                     width: 30,
//                     child: Icon(Icons.person),
//                   ),
//                   label: 'Profile'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: const Color(0XFFFFE6C7),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(255, 200, 200, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          child: GNav(
            backgroundColor: const Color.fromRGBO(255, 200, 200, 1),
            color: Color.fromARGB(255, 250, 3, 3),
            activeColor: Color.fromARGB(255, 255, 255, 255),
            tabBackgroundColor: const Color(0XFFFFE6C7),
            tabBackgroundGradient: const LinearGradient(colors: [
              Color.fromRGBO(255, 200, 200, 1),
              Color.fromARGB(255, 250, 3, 3)
            ]),
            gap: 6.0,
            padding: const EdgeInsets.all(10.0),
            // tabBorder: Border.all(color: Color(0XFFFF6000)),
            // tabActiveBorder: Border.all(color: Color(0XFFFFE6C7)),
            // tabShadow: [BoxShadow(color: Color(0XFFFFE6C7), blurRadius: 8)],
            // tabBorderRadius: 10.0,
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
    HomeScreen(),
    const AddEvent(),
    const Calender(),
    const Favorite(),
  ];
}
