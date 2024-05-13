import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  static final route = MaterialPageRoute(
    builder: (context) => const HomePageScreen(),
  );
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('HomePage'),
      ),
    );
  }
}
