import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/model/getx/getxcontroller/mainscreen_controller_getx.dart';
import 'package:project_event/view/body_screen/main/home_screen.dart';
import 'package:project_event/view/body_screen/profile/calender_view_screen.dart';
import 'package:project_event/view/body_screen/main/profile_account_screen.dart';
import 'package:project_event/view/body_screen/event/add_event_screen.dart';
import 'package:sizer/sizer.dart';

class MainBottom extends StatelessWidget {
  final int? selectedIndex;
  final int profileid;

  const MainBottom({Key? key, required this.profileid, this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainBottomController controller = Get.put(MainBottomController());
    refreshRefreshid(profileid);

    final List<Widget> pages = [
      HomeScreen(profileid: profileid),
      AddEvent(profileid: profileid),
      Calender(profileid: profileid),
      ProfileAccount(profileid: profileid),
    ];

    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 1.5.h),
          child: GetBuilder<MainBottomController>(
            init: controller,
            builder: (_) => GNav(
              backgroundColor: Colors.white,
              color: const Color.fromARGB(255, 250, 3, 3),
              activeColor: const Color.fromARGB(255, 255, 255, 255),
              tabBackgroundColor: const Color(0XFFFFE6C7),
              tabBackgroundGradient: const LinearGradient(colors: [
                Color.fromRGBO(255, 200, 200, 1),
                Color.fromARGB(255, 250, 3, 3)
              ]),
              gap: 6.0,
              padding: EdgeInsets.all(1.h),
              selectedIndex: controller.selectedIndex.value,
              tabs: const [
                GButton(text: 'Home', icon: Icons.home),
                GButton(text: 'Add Event', icon: Icons.add),
                GButton(text: 'Calender', icon: Icons.calendar_month),
                GButton(text: 'Profile', icon: Icons.person),
              ],
              onTabChange: (index) {
                controller.changePage(index);
              },
            ),
          ),
        ),
      ),
      body: Obx(() => pages[controller.selectedIndex.value]),
    );
  }
}
