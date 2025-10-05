// lib/pages/home_page.dart

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 35,
              ),
              const Spacer(),
              Column(
                children: [
                  Image.asset(
                    'assets/lineball.png',
                    height: 320,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    // --- PERUBAHAN UTAMA DI SINI ---
                    // Menggunakan ShaderMask untuk membuat teks gradasi
                    child: ShaderMask(
                      // BlendMode.srcIn akan menerapkan gradasi ke dalam bentuk teks
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          // Warna awal (FFFFFF)
                          Color(0xFFFFFFFF),
                          // Warna akhir (999999)
                          Color(0x999999),
                        ],
                        // Anda bisa mengatur arah gradasi di sini
                        // begin: Alignment.topCenter,
                        // end: Alignment.bottomCenter,
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      // Teks yang akan diberi gradasi
                      child: const Text(
                        'The universe, limitless.\nDiscoveries, endless.',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/planet-list');
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white.withOpacity(0.5), width: 1),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}