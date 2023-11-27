// import 'package:flutter/material.dart';
// import 'package:project_event/Database/functions/fn_profilemodel.dart';
// import 'package:project_event/main.dart';
// import 'package:project_event/screen/Body/widget/Scaffold/bottomnavigator.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // checkuserloggedin(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/UI/Event Logo/event logo top.png',
//             height: 500,
//           ),
//           const CircularProgressIndicator(
//             color: Colors.red,
//           ),
//         ],
//       ),
//     );
//   }

//   // Future<void> checkuserloggedin(BuildContext context) async {
//   //   final sharedPrefer = await SharedPreferences.getInstance();
//   //   final userlogged = sharedPrefer.getBool(sharedPreferences);

//   //   if (userlogged != null && userlogged) {
//   //     Navigator.of(context).pushReplacement(MaterialPageRoute(
//   //         builder: (context) => MainBottom(
//   //               profileid: profileData.value.first.id!,
//   //             )));
//   //   }
//   // }
// }
