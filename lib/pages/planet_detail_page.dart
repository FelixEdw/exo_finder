import 'package:flutter/material.dart';
import '../models/planet_model.dart';

class PlanetDetailPage extends StatelessWidget {
  final Planet planet;

  const PlanetDetailPage({super.key, required this.planet});
  Widget _buildInfoCard(String label, String value) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: Colors.white70, fontSize: 16)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gunakan gambar placeholder, karena API tidak menyediakan gambar
            Image.asset(
              'assets/logo.png',
              height: 200,
            ),
            const SizedBox(height: 24),
            Text(
              planet.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildInfoCard('Radius (x Bumi)', planet.radius?.toStringAsFixed(2) ?? 'N/A'),
            _buildInfoCard('Massa (x Bumi)', planet.mass?.toStringAsFixed(2) ?? 'N/A'),
            _buildInfoCard('Jarak (parsec)', planet.distanceFromEarth?.toStringAsFixed(2) ?? 'N/A'),
            _buildInfoCard('Suhu Bintang (K)', planet.stellarTemperature?.toStringAsFixed(0) ?? 'N/A'),
          ],
        ),
      ),
    );
  }
}