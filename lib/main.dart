import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const InjektrApp());
}

class InjektrApp extends StatelessWidget {
  const InjektrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Injektr',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
