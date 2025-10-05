// lib/main.dart

import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/planet_list_page.dart';
import 'pages/planet_detail_page.dart';
import 'models/planet_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExoFinder',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/planet-list': (context) => const PlanetListPage(),
        '/planet-detail': (context) {
          final planet = ModalRoute.of(context)!.settings.arguments as Planet;
          return PlanetDetailPage(planet: planet);
        },
      },
    );
  }
}