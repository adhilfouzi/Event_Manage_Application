import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/screen/Body/Screen/main/home_screen.dart';
import 'package:project_event/screen/intro/intro.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize_event_db();
  await initialize_task_db();
  await initialize_guest_database();
  await initializeBudgetDatabase();
  await initializeVendorDatabase();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'event',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color.fromRGBO(255, 200, 200, 1),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'ReadexPro',
          ),
        ),
      ),
      home: AnimatedSplashScreen(
        splash: 'assets/UI/Event Logo/event logo top.png',
        splashIconSize: 500,
        nextScreen: const OnBoardingPage(),
        backgroundColor: appbarcolor,
        duration: 3000,
        splashTransition: SplashTransition.sizeTransition,
      ),
      routes: {
        '/Home': (context) => HomeScreen(),
        // '/Task':(context) => TaskList(eventid: eventid)
      },
    );
  }
}
