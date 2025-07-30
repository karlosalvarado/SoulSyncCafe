// lib/screens/user_input_screen.dart

import 'package:flutter/material.dart';

class UserInputScreen extends StatefulWidget {
  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  DateTime? _birthDate;
  String _gender = 'female';
  String _fullName = '';

  // Helper to pick a date
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF6A5ACD), // Purple for mystical feel
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cosmic Profile"),
        backgroundColor: Color(0xFF6A5ACD),
      ),
      backgroundColor: Color(0xFFF0F8FF), // Light background
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person, color: Color(0xFF6A5ACD)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 20),

              // Full Name at Birth
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Full Name at Birth",
                  prefixIcon: Icon(Icons.edit, color: Color(0xFF6A5ACD)),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required for numerology';
                  }
                  return null;
                },
                onSaved: (value) => _fullName = value!,
              ),
              SizedBox(height: 20),

              // Birth Date
              ListTile(
                leading: Icon(Icons.cake, color: Color(0xFF6A5ACD)),
                title: Text(
                  _birthDate == null
                      ? "Select Birth Date"
                      : "Birth Date: ${_birthDate!.toLocal()}".split(' ')[0],
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () => _selectDate(context),
              ),
              SizedBox(height: 20),

              // Gender
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                  labelText: "Gender",
                  prefixIcon: Icon(Icons.wc, color: Color(0xFF6A5ACD)),
                  border: OutlineInputBorder(),
                ),
                items: ['female', 'male', 'non-binary', 'other']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                onSaved: (value) => _gender = value!,
              ),
              SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6A5ACD),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() && _birthDate != null) {
                    _formKey.currentState!.save();
                    // Pass data to MatchScreen
                    Navigator.pushNamed(
                      context,
                      '/match',
                      arguments: {
                        'name': _name,
                        'birthDate': _birthDate!.toIso8601String().split('T').first,
                        'gender': _gender,
                        'fullName': _fullName,
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select birth date")),
                    );
                  }
                },
                child: Text(
                  "Calculate My Cosmic Match",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}