// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/match_screen.dart';

void main() {
  runApp(SoulSyncApp());
}

class SoulSyncApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoulSync',
      theme: ThemeData(
        primaryColor: Color(0xFF6A5ACD),
        scaffoldBackgroundColor: Color(0xFFF0F8FF),
        fontFamily: 'Arial',
      ),
      home: MatchScreen(),
    );
  }
}