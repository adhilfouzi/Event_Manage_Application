import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/screen/Body/Screen/main/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize_event_db();
  await initialize_task_db();
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
          primaryColor: appbarcolor,
          scaffoldBackgroundColor: backgroundcolor,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'ReadexPro',
            ),
          ),
        ),
        home: AnimatedSplashScreen(
          splash: 'assets/UI/Event Logo/event logo top.png',
          splashIconSize: 500,
          nextScreen: HomeScreen(),
          backgroundColor: appbarcolor,
          duration: 3000,
          splashTransition: SplashTransition.sizeTransition,
        ));
  }
}
