import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'settings_screen.dart';
import 'dose_calculator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isOled = context.watch<ThemeProvider>().isOledBlack;

    final fabBackground = isOled
        ? Colors.black
        : isDark
        ? theme.colorScheme.secondaryContainer
        : theme.colorScheme.primary;

    final fabForeground = isOled
        ? Colors.white
        : isDark
        ? Colors.black
        : Colors.white;

    return Scaffold(
      appBar: AppBar(title: const Text('Injektr')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Dose Calculator'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DoseCalculatorScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Injektr v0.1.0 – Developed by SaladevX'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Home Page')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, right: 8.0),
        child: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          backgroundColor: fabBackground,
          foregroundColor: fabForeground,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          spacing: 12,
          spaceBetweenChildren: 8,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.sick),
              // backgroundColor: fabBackground,
              // foregroundColor: fabForeground,
              label: 'Add Side Effect',
              onTap: () {
                debugPrint('Add Side Effect');
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.medical_services),
              // backgroundColor: fabBackground,
              // foregroundColor: fabForeground,
              label: 'Add Injection',
              onTap: () {
                // TODO: Navigate or show dialog
                debugPrint('Add Injection');
              },
            ),
          ],
        ),
      ),
    );
  }
}
