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
        title: const Text('Comparison Results'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildPlanetDetailsColumn(planet1),
            ),
            const VerticalDivider(color: Colors.grey, thickness: 1),
            Expanded(
              child: _buildPlanetDetailsColumn(planet2),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to display the details of one planet
  Widget _buildPlanetDetailsColumn(Planet planet) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/logo.png', height: 120),
          const SizedBox(height: 16),
          Text(
            planet.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildDetailRow('Radius', '${planet.radius?.toStringAsFixed(2) ?? 'N/A'} x Earth'),
          _buildDetailRow('Mass', '${planet.mass?.toStringAsFixed(2) ?? 'N/A'} x Earth'),
          _buildDetailRow('Distance', '${planet.distanceFromEarth?.toStringAsFixed(2) ?? 'N/A'} pc'),
          _buildDetailRow('Stellar Temperature', '${planet.stellarTemperature?.toStringAsFixed(0) ?? 'N/A'} K'),
          const SizedBox(height: 16),
          // Displaying additional information
          _buildInfoBox('Habitability', planet.habitability ?? 'N/A', Colors.green),
          const SizedBox(height: 8),
          _buildInfoBox('Planet Composition', planet.composition ?? 'N/A', Colors.blue),
        ],
      ),
    );
  }

  // Helper widget to create a detail row
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

  // Helper widget for infographics
  Widget _buildInfoBox(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}