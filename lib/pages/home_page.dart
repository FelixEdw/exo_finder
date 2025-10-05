import 'package:flutter/material.dart';
import 'planet_list_page.dart';
import 'package:particles_flutter/particles_flutter.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"), 
                fit: BoxFit.cover,
              ),
            ),
          ),

          CircularParticle(
            key: UniqueKey(),
            awayRadius: 80,
            numberOfParticles: 200, 
            speedOfParticles: 1,
            height: screenHeight,
            width: screenWidth,
            onTapAnimation: true,
            particleColor: Colors.white.withAlpha(150), 
            awayAnimationCurve: Curves.easeInOut,
            awayAnimationDuration: const Duration(milliseconds: 600),
            maxParticleSize: 2, 
            isRandSize: true,
            isRandomColor: true,
            randColorList: [
              Colors.white.withAlpha(210),
              Colors.purple.withAlpha(150),
              Colors.blue.withAlpha(150),
              Colors.yellow.withAlpha(20),
            ],
            enableHover: false,
            hoverColor: Colors.white,
            hoverRadius: 90,
            connectDots: false, // true if you want the particles to connect
          ),

          // Layer 3: Main Content (Logo, Text, Button)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    width: 150,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Exo Finder',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [ 
                        Shadow(blurRadius: 10.0, color: Colors.black)
                      ]
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Discover and compare planets outside our solar system.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      shadows: [ // Add a shadow to make the text more readable
                        Shadow(blurRadius: 8.0, color: Colors.black)
                      ]
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Start Exploring'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlanetListPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}