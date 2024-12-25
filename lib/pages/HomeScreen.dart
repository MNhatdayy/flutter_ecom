import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to Home Screen!',
          style: Theme.of(context).textTheme.headlineMedium, // Updated from headline4
        ),
      ),
    );
  }
}
