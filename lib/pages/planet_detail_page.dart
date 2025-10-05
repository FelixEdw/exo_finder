// lib/pages/planet_detail_page.dart

import 'package:flutter/material.dart';
import '../models/planet_model.dart'; // Impor model data

class PlanetDetailPage extends StatelessWidget {
  final Planet planet;

  const PlanetDetailPage({super.key, required this.planet});

  // Widget helper untuk kartu info, sedikit disesuaikan agar mirip referensi
  Widget _buildInfoCard(String label, String value) {
    return Card(
      // Warna dan bentuk tetap sama
      color: const Color(0xFF1C1C1E), // Warna abu-abu gelap yang solid
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
                fontWeight: FontWeight.bold, // Dibuat tebal agar lebih jelas
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
      // Kita tidak lagi menggunakan Stack karena tombol back sudah dihapus
      body: SafeArea( // Menggunakan SafeArea agar konten tidak menabrak status bar
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Gambar planet lebih kecil dan bisa diketuk untuk kembali
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: GestureDetector( // 3. Dibungkus GestureDetector untuk navigasi kembali
                  onTap: () {
                    Navigator.pop(context); // Aksi untuk kembali
                  },
                  child: Center(
                    child: Hero(
                      tag: planet.name, // Tag harus SAMA dengan di halaman list
                      child: SizedBox(
                        height: 280, // 1. Ukuran gambar diperkecil
                        child: Image.asset(
                          planet.imagePath,
                          fit: BoxFit.contain, // Gunakan contain agar proporsi gambar benar
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Konten Teks dan Informasi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                // 5. Column ini diubah untuk membuat card full-width
                child: Column(
                  // Menggunakan stretch akan memaksa semua child (termasuk Card)
                  // untuk memenuhi lebar horizontal yang tersedia.
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [
                    Text(
                      planet.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 36, // 4. Ukuran font nama planet diperkecil
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
                    const SizedBox(height: 24), // Memberi sedikit ruang di bagian bawah
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