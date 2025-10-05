// lib/pages/welcome_page.dart

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
                height: 50,
              ),
              const Spacer(),
              Column(
                children: [
                  Image.asset(
                    'assets/lineball.png',
                    height: 250,
                  ),
                  const SizedBox(height: 40),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFF999999),
                      ],
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: const Text(
                      'The universe, limitless.\nDiscoveries, endless.',
                      textAlign: TextAlign.center, // Tambahkan ini
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w300, // Diubah dari bold
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home_page');
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