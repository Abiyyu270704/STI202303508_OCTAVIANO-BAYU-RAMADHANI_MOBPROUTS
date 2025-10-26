import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyEventPlannerApp());
}

class MyEventPlannerApp extends StatelessWidget {
  const MyEventPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Event Planner',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}