import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const nameRoute = 'homeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
    );
  }
}