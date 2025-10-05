// lib/pages/planet_list_page.dart

import 'dart:math';
import 'package:flutter/material.dart';
import '../models/planet_model.dart';
import 'planet_detail_page.dart';

class PlanetListPage extends StatefulWidget {
  const PlanetListPage({super.key});

  @override
  State<PlanetListPage> createState() => _PlanetListPageState();
}

class _PlanetListPageState extends State<PlanetListPage> {
  late final PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(planets.length, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: index == _currentPage.round() ? Colors.white : Colors.white38,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset('assets/logo.png', height: 30),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildPageIndicator(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: planets.length,
              itemBuilder: (context, index) {
                return _buildPlanetPage(context, planets[index], index, _currentPage);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanetPage(
      BuildContext context, Planet planet, int index, double currentPage) {
    final double progress = (currentPage - index);
    final double screenWidth = MediaQuery.of(context).size.width;

    // Animasi Gambar Planet (Tetap Sama)
    double dx;
    double dy;
    double rotationAngle = progress * -pi;

    if (progress < 0) {
      dx = screenWidth * progress.abs();
      dy = -150 * progress.abs();
    } else {
      dx = screenWidth * progress;
      dy = sin(progress * pi) * 150;
    }

    final Matrix4 imageTransformMatrix = Matrix4.identity()
      ..translate(dx, dy, 0)
      ..rotateZ(rotationAngle);
      
    // Animasi Teks Nama Planet (Tetap Sama)
    final double textProgress = (currentPage - index);
    double textDx, textDy, textRotation, textOpacity;

    if (textProgress > -1.0 && textProgress < 1.0) {
      textDx = -textProgress * screenWidth * 0.6;
      textDy = sin(textProgress * pi) * 80;
      textRotation = textProgress * pi / 6;
      textOpacity = 1.0 - textProgress.abs();
    } else {
      textDx = 0;
      textDy = 0;
      textRotation = 0;
      textOpacity = 0;
    }

    final Matrix4 textTransformMatrix = Matrix4.identity()
      ..translate(textDx, textDy, 0)
      ..rotateZ(textRotation);
    
    // ================== PERUBAHAN DI SINI ==================
    // Menentukan posisi planet berdasarkan namanya
    double bottomPosition;
    double leftPosition;
    double rightPosition;

    if (planet.name == 'Saturn') {
      // Atur posisi khusus untuk Saturnus karena ukurannya berbeda
      bottomPosition = -445; // Lebih ke bawah
      leftPosition = -250;
      rightPosition = -250;
    } else {
      // Atur posisi default untuk semua planet lainnya
      bottomPosition = -270;
      leftPosition = -50;
      rightPosition = -50;
    }
    // ========================================================

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50), 
              Center(
                child: Opacity(
                  opacity: textOpacity,
                  child: Transform(
                    transform: textTransformMatrix,
                    alignment: Alignment.center,
                    child: Text(
                      planet.name.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // --- Gunakan variabel posisi yang sudah ditentukan ---
        Positioned(
          bottom: bottomPosition,
          left: leftPosition,
          right: rightPosition,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 800),
                  reverseTransitionDuration: const Duration(milliseconds: 800),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PlanetDetailPage(planet: planet);
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
            child: Hero(
              tag: planet.name,
              child: Transform(
                transform: imageTransformMatrix,
                alignment: Alignment.center,
                child: Image.asset(
                  planet.imagePath,
                  height: planet.imageHeight,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}