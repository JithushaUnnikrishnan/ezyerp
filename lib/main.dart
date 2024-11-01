import 'package:bill/admin/bottomnavigation.dart';
import 'package:bill/admin/counter.dart';
import 'package:bill/admin/customers.dart';
import 'package:bill/admin/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/credit_aging.dart';
import 'admin/login.dart';
import 'admin/new_receipt.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    bool isLoggin = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggin = prefs.getBool('_isLogging') ?? false;
      print("Login status is $isLoggin");
    });
  }
  // This widget is the root of your application.
  @override
 
  Widget build(BuildContext context) {

//   bool isLoggin = false;
//        Loginnn()async {{
//   SharedPreferences prefs= await SharedPreferences.getInstance();
//   isLoggin=prefs.getBool('_isLogging')??false;
//   print("jithu is $isLoggin");
 
// }}

// WidgetsBinding.instance?.addPostFrameCallback((_) {
//       Loginnn();
//     });
   
 

    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:Login(),
    );
  }
}
