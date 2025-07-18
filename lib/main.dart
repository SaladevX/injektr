import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const InjektrApp(),
    ),
  );
}

class InjektrApp extends StatelessWidget {
  const InjektrApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final isDark = themeProvider.isDarkMode;
    final isOled = themeProvider.isOledBlack;

    return MaterialApp(
      title: 'Injektr',
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: isOled
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
              canvasColor: Colors.black,
            )
          : ThemeData.dark(),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
