import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Injektr'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // TODO: Implement navigation menu or drawer
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Hamburger tapped 🍔')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Injektr!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Placeholder for navigation later
              },
              child: const Text('Log a Dose'),
            ),
          ],
        ),
      ),
    );
  }
}
