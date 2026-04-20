import 'package:flutter/material.dart';
import 'package:pos_front/navbar/MainLayout.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
         body: const Center(
          child: Text(
            "Welcome to Dashboard 🎉",
            style: TextStyle(fontSize: 22),
          ),
        ),

    ),
    );
  }
}