import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

// Definisi data untuk planet
class PlanetData {
  final String name;
  final String imagePath;
  final String size;
  final String distance;
  final String atmosphere;
  final int potentialForLife;

  PlanetData({
    required this.name,
    required this.imagePath,
    required this.size,
    required this.distance,
    required this.atmosphere,
    required this.potentialForLife,
  });
}

// Data dummy untuk contoh
final List<PlanetData> planetPages = [
  PlanetData(
    name: "EARTH",
    imagePath: 'assets/earth.jpeg', // Ganti dengan path gambar Earth Anda
    size: "500000000 N",
    distance: "24,007 km/s",
    atmosphere: "24,007 km/s",
    potentialForLife: 5,
  ),
  PlanetData(
    name: "MARS",
    imagePath: 'assets/mars.png', // Ganti dengan path gambar Mars Anda
    size: "500000000 N",
    distance: "24,007 km/s",
    atmosphere: "24,007 km/s",
    potentialForLife: 5,
  ),
];

void main() {
  // Pastikan Anda telah menambahkan gambar Earth dan Mars di folder 'assets/' 
  // dan mendeklarasikannya di pubspec.yaml
  runApp(const ExofinderApp());
}

class ExofinderApp extends StatelessWidget {
  const ExofinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exofinder UI',
      theme: ThemeData(
        // Tema gelap sesuai desain
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
          labelLarge: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        // Menggunakan tema gelap untuk Card
        cardTheme: CardThemeData(
          color: Colors.grey.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Widget untuk Halaman Intro
class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('EXOFINDER', style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 50),
          // Area gambar 'The universe, limitless.'
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white12),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            alignment: Alignment.center,
            //child: const Text('Gambar Ilustrasi Bola Garis', style: TextStyle(color: Colors.white54)),
            child: Image.asset('assets/lineball.jpeg'),
          ),
          const SizedBox(height: 30),
          const Text(
            'The universe, limitless.\nDiscoveries, endless.',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
          ),
          const Spacer(),
          // Indikator dan tombol panah
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: index == 0 ? 20.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.white : Colors.white38,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_forward, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget untuk Halaman Planet
class PlanetPage extends StatelessWidget {
  final PlanetData data;
  const PlanetPage({super.key, required this.data});

  // Widget pembantu untuk menampilkan detail info planet
  Widget _buildInfoCard(String label, String value, {bool isPotential = false}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: isPotential && int.tryParse(value) == 5 ? Colors.greenAccent : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian 'Welcome' dan indikator navigasi
            const Text('Welcome', style: TextStyle(color: Colors.white70, fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              children: [
                // Garis putus-putus sederhana
                ...List.generate(6, (index) => Container(
                  width: 10,
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  color: index % 2 == 0 ? Colors.white : Colors.transparent,
                )),
                const Spacer(),
                // Titik indikator
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Nama Planet
            Text(data.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 30),

            // Area Gambar Planet dan Info Statistik
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                // Kartu Informasi Statistik
                Container(
                  margin: const EdgeInsets.only(top: 120),
                  padding: const EdgeInsets.only(top: 140, left: 15, right: 15, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 15),
                      // Kartu Detail
                      _buildInfoCard("Size", data.size),
                      const SizedBox(height: 8),
                      _buildInfoCard("distance", data.distance),
                      const SizedBox(height: 8),
                      _buildInfoCard("atmosphere", data.atmosphere),
                      const SizedBox(height: 8),
                      _buildInfoCard("potential for Life", data.potentialForLife.toString(), isPotential: true),
                    ],
                  ),
                ),
                
                // Gambar Planet
                Positioned(
                  top: 0,
                  child: Image.asset(
                    data.imagePath,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                    // Tambahkan properti errorBuilder jika gambar tidak ditemukan
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 250,
                      width: 250,
                      color: Colors.grey.shade800,
                      child: const Center(child: Text("Gambar tidak ditemukan", style: TextStyle(fontSize: 12))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget utama dengan PageView
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page!.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Total 3 halaman: Home, Earth, Mars.
    // Untuk PageView, kita hanya menampilkan Earth dan Mars. Halaman 'Home' di kiri adalah navigasi/intro.
    // Di sini saya mengimplementasikan 3 halaman dalam satu PageView untuk mencakup desain geser.
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_currentPage == 0 ? 'Home' : planetPages[_currentPage - 1].name, style: Theme.of(context).textTheme.labelLarge),
            _currentPage > 0 ? Text('MARS', style: Theme.of(context).textTheme.labelLarge) : const Text(''), // Indikator halaman
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        // Halaman 1: Intro
        // Halaman 2: Earth
        // Halaman 3: Mars
        children: [
          IntroPage(),
          PlanetPage(data: planetPages[0]), // Earth
          PlanetPage(data: planetPages[1]), // Mars
        ],
      ),
    );
  }
}
