// ignore_for_file: prefer_const_constructors

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myhabeeb/AdminPages/AdminMainPage.dart';
import 'package:myhabeeb/LoginPages/loginPage.dart';
import 'package:myhabeeb/LoginPages/welcomepage.dart';
import 'package:myhabeeb/Styles/theme.dart';
import 'package:myhabeeb/UserPages/Home.dart';
import 'package:myhabeeb/UserPages/MainPage.dart';
import 'package:get/get.dart';
import 'package:myhabeeb/binding/initial_binding.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar');

  await Firebase.initializeApp();
   await FirebaseAppCheck.instance.activate(
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
            initialBinding: InitialBinding(),

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          // Initialize ScreenSize here
          ScreenSize.init(context);
          return Welcomepage();
        },
      ),
    );
  }
}
