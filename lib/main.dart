import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/home_page.dart';
import 'pages/planet_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exo Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'OpenSans',
      ),
      // --- PERBAIKAN DI SINI ---
      // Tentukan halaman awal dan daftarkan semua rute yang akan digunakan
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home_page': (context) => const HomePage(),
        '/planet_list': (context) => const PlanetListPage(),
        // Anda bisa tambahkan rute lain di sini jika perlu
      },
      // Anda tidak perlu 'home' jika sudah menggunakan 'initialRoute'
      // home: const WelcomePage(),
    );
  }
}