// lib/main.dart

import 'package:flutter/material.dart';
import 'pages/welcome_page.dart'; // Pastikan import ini benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exo Finder',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'OpenSans',
      ),
      // Ganti baris ini
      home: const WelcomePage(), 
    );
  }
}