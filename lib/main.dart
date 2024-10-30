import 'package:bill/admin/bottomnavigation.dart';
import 'package:bill/admin/counter.dart';
import 'package:bill/admin/customers.dart';
import 'package:bill/admin/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'admin/credit_aging.dart';
import 'admin/login.dart';
import 'admin/new_receipt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}
