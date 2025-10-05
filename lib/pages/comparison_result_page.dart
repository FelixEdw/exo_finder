// lib/pages/comparison_result_page.dart

import 'package:flutter/material.dart';
import '../models/planet_model.dart';

class ComparisonResultPage extends StatelessWidget {
  final Planet planet1;
  final Planet planet2;

  const ComparisonResultPage({
    super.key,
    required this.planet1,
    required this.planet2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparison Result'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kolom untuk Planet 1
            Expanded(
              child: _buildPlanetDetailsColumn(planet1),
            ),
            // Garis pemisah
            const VerticalDivider(color: Colors.grey, thickness: 1),
            // Kolom untuk Planet 2
            Expanded(
              child: _buildPlanetDetailsColumn(planet2),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk menampilkan detail satu planet
  Widget _buildPlanetDetailsColumn(Planet planet) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gunakan gambar generik untuk semua planet
          Image.asset('assets/logo.png', height: 120), // Menggunakan logo sebagai placeholder
          const SizedBox(height: 16),
          Text(
            planet.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildDetailRow('Radius', '${planet.radius?.toStringAsFixed(2) ?? 'N/A'} x Bumi'),
          _buildDetailRow('Massa', '${planet.mass?.toStringAsFixed(2) ?? 'N/A'} x Bumi'),
          _buildDetailRow('Jarak', '${planet.distanceFromEarth?.toStringAsFixed(2) ?? 'N/A'} pc'),
          _buildDetailRow('Suhu Bintang', '${planet.stellarTemperature?.toStringAsFixed(0) ?? 'N/A'} K'),
        ],
      ),
    );
  }

  // Helper widget untuk membuat baris detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14), textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}