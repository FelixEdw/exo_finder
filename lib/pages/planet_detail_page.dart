// lib/pages/planet_detail_page.dart

import 'package:flutter/material.dart';
import '../models/planet_model.dart'; // Pastikan model di-importflu

class PlanetDetailPage extends StatelessWidget {
  final Planet planet; // Variabel untuk menyimpan data planet

  // Constructor yang WAJIB menerima data planet
  const PlanetDetailPage({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Tampilkan nama planet di AppBar
        title: Text(planet.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan detail planet di sini
            Text('Detail untuk: ${planet.name}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Radius: ${planet.radius?.toStringAsFixed(2) ?? 'N/A'} x Jupiter'),
            SizedBox(height: 10),
            Text('Massa: ${planet.mass?.toStringAsFixed(2) ?? 'N/A'} x Jupiter'),
            SizedBox(height: 10),
            Text('Jarak dari Bumi: ${planet.distanceFromEarth?.toStringAsFixed(2) ?? 'N/A'} parsec'),
            SizedBox(height: 10),
            Text('Temperatur Bintang Induk: ${planet.stellarTemperature?.toStringAsFixed(0) ?? 'N/A'} K'),
          ],
        ),
      ),
    );
  }
}