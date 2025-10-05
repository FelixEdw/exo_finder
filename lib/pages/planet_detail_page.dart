import 'package:flutter/material.dart';
import '../models/planet_model.dart';

class PlanetDetailPage extends StatelessWidget {
  final Planet planet;

  const PlanetDetailPage({super.key, required this.planet});

  Widget _buildInfoCard(String label, String value) {
    return Card(
      color: const Color(0xFF1C1C1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Hero(
                      tag: planet.name,
                      child: SizedBox(
                        height: 280,
                        child: Image.asset(
                          planet.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [
                    Text(
                      planet.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      planet.description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[400], height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 24),
                    _buildInfoCard("Size (Surface Area)", planet.size),
                    const SizedBox(height: 12),
                    _buildInfoCard("Distance from Sun", planet.distance),
                    const SizedBox(height: 12),
                    _buildInfoCard("Main Atmosphere", planet.atmosphere),
                    const SizedBox(height: 12),
                    _buildInfoCard("Potential for Life (1-5)", planet.potentialForLife.toString()),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}