import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'HomeScreen.dart';

void main() async {


  await Hive.initFlutter();

  var box = await Hive.openBox('TaskBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.red)),
      home: const HomeScreen(),
    );
  }
}
