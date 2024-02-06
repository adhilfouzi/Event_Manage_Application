import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project_event/model/db_functions/fn_budgetmodel.dart';
import 'package:project_event/model/db_functions/fn_evenmodel.dart';
import 'package:project_event/model/db_functions/fn_guestmodel.dart';
import 'package:project_event/model/db_functions/fn_incomemodel.dart';
import 'package:project_event/model/db_functions/fn_paymodel.dart';
import 'package:project_event/model/db_functions/fn_profilemodel.dart';
import 'package:project_event/model/db_functions/fn_taskmodel.dart';
import 'package:project_event/model/db_functions/fn_vendormodel.dart';
import 'package:project_event/view/intro_screen/splash_screen.dart';
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
        builder: (context, orientation, deviceType) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'event',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(),
              primaryColor: Colors.grey[300],
              scaffoldBackgroundColor: Colors.white,
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
