import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isOledBlack = false;

  bool get isDarkMode => _isDarkMode;
  bool get isOledBlack => _isOledBlack;

  ThemeProvider() {
    _loadPrefs();
  }

  void _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isOledBlack = prefs.getBool('isOledBlack') ?? false;
    notifyListeners();
  }

  void setDarkMode(bool value) async {
    _isDarkMode = value;
    if (!_isDarkMode) _isOledBlack = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setBool('isOledBlack', _isOledBlack);
    notifyListeners();
  }

  void setOledBlack(bool value) async {
    _isOledBlack = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOledBlack', _isOledBlack);
    notifyListeners();
  }
}
