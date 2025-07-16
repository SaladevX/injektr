import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GLP1App());
}

class GLP1App extends StatelessWidget {
  const GLP1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Injektr',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const HomeScreen(),
    );
  }
}
