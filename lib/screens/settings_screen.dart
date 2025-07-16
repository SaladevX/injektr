import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _isOledBlack = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Appearance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
                // If dark mode is turned off, disable OLED Black
                if (!value) {
                  _isOledBlack = false;
                }
              });
            },
            secondary: const Icon(Icons.dark_mode),
          ),
          SwitchListTile(
            title: const Text('OLED Black'),
            subtitle: const Text('Only enabled in dark mode'),
            value: _isOledBlack,
            onChanged: _isDarkMode
                ? (bool value) {
                    setState(() {
                      _isOledBlack = value;
                    });
                  }
                : null, // disables the toggle when dark mode is off
            secondary: const Icon(Icons.brightness_3),
          ),
        ],
      ),
    );
  }
}
