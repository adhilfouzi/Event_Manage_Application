import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_event/Database/functions/fn_budgetmodel.dart';
import 'package:project_event/Database/functions/fn_evenmodel.dart';
import 'package:project_event/Database/functions/fn_guestmodel.dart';
import 'package:project_event/Database/functions/fn_incomemodel.dart';
import 'package:project_event/Database/functions/fn_paymodel.dart';
import 'package:project_event/Database/functions/fn_profilemodel.dart';
import 'package:project_event/Database/functions/fn_taskmodel.dart';
import 'package:project_event/Database/functions/fn_vendormodel.dart';
import 'package:project_event/screen/intro/splashscreen.dart';
import 'package:sizer/sizer.dart';

const logedinsp = 'UserLoggedin';
const introsp = 'Introseen';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeEventDb();
  await initializeTaskDb();
  await initializeGuestDatabase();
  await initializeBudgetDatabase();
  await initializeVendorDatabase();
  await initializePaymentDatabase();
  await initializeIncomeDatabase();
  await initializeProfileDB();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return SafeArea(
      child: Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'event',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(),
              primaryColor: Colors.grey[300],
              scaffoldBackgroundColor:
                  Colors.white, //const Color.fromRGBO(255, 200, 200, 1),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  fontFamily: 'ReadexPro',
                ),
              ),
            ),
            home: const SplashScreen()),
      ),
    );
  }
}
