// lib/screens/match_screen.dart

import 'package:flutter/material.dart';
import '../services/match_service.dart';

class MatchScreen extends StatefulWidget {
 final Map<String, dynamic>? user1Data;

  MatchScreen({this.user1Data});

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final MatchService _matchService = MatchService();
  Map<String, dynamic>? matchResult;
  bool _loading = false;

void _calculateMatch() async {
  setState(() {
    _loading = true;
    matchResult = null;
  });

  try {
    final result = await _matchService.getCompatibility(
      name1: widget.user1Data?['name'] ?? "You",
      birthDate1: widget.user1Data?['birthDate'] ?? "1990-01-01",
      gender1: widget.user1Data?['gender'] ?? "female",
      fullName1: widget.user1Data?['fullName'] ?? "Your Name",
      name2: "Orion",
      birthDate2: "1990-01-20",
      gender2: "male",
      fullName2: "Orion Star",
    );

    setState(() {
      matchResult = result;
      _loading = false;
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
    setState(() {
      _loading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SoulSync Match")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _calculateMatch,
              child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Find Cosmic Match"),
            ),
            SizedBox(height: 30),

           if (matchResult != null)
  Column(
    children: [
      Text(
        "🌟 Compatibility Score",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      Text(
        "${matchResult!['total_score']}/100",
        style: TextStyle(fontSize: 40, color: Colors.purple, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 20),
      Text(
        matchResult!['insight'],
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
      ),
      SizedBox(height: 20),
      _buildBreakdown("Astrology", (matchResult!['breakdown']['astrology'] as num).toDouble()),
      _buildBreakdown("Chinese Zodiac", (matchResult!['breakdown']['chinese_zodiac'] as num).toDouble()),
      _buildBreakdown("Numerology", (matchResult!['breakdown']['numerology'] as num).toDouble()),
      _buildBreakdown("Feng Shui", (matchResult!['breakdown']['feng_shui'] as num).toDouble()),
    ],
  )
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdown(String label, num score) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text("$score", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}