import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/font.dart';
import 'package:project_event/screen/Body/widget/Scaffold/bottomborderappbar.dart';
import 'package:sizer/sizer.dart';

class AppAction extends StatelessWidget {
  final double? sizer;
  final IconData icon;
  final VoidCallback onPressed;

  const AppAction(
      {super.key, required this.icon, required this.onPressed, this.sizer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(0.8.h),
        child: Icon(icon, weight: 2.h, size: sizer),
      ),
    );
  }
}

//-----------------------------------------------
//-----------------------------------------------

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? automaticallyImplyLeadingtitle;
  final List<Widget> actions;
  final String titleText;
  final Color? backgroundColor;
  final Color? textcolor;
  final PreferredSizeWidget? bottom;
  const CustomAppBar({
    Key? key,
    required this.actions,
    required this.titleText,
    this.backgroundColor,
    this.textcolor,
    this.bottom,
    this.automaticallyImplyLeadingtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeadingtitle ?? true,
      centerTitle: true,
      foregroundColor: textcolor ?? Colors.black,
      backgroundColor: Colors.transparent, // backgroundColor ?? appbarcolor,
      title: Text(
        titleText,
        style: readexPro(fontSize: 17.sp, color: textcolor ?? Colors.black),
      ),
      actions: actions,
      bottom: bottom ?? const BottomBorderWidget(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
