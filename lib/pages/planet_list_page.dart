import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/planet_model.dart';
import 'planet_detail_page.dart';

class PlanetListPage extends StatefulWidget {
  const PlanetListPage({super.key});

  @override
  _PlanetListPageState createState() => _PlanetListPageState();
}

class _PlanetListPageState extends State<PlanetListPage> {
  late Future<List<Planet>> futurePlanets;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    futurePlanets = apiService.fetchPlanets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exo Finder - Planet Terdekat'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Planet>>(
          future: futurePlanets,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Tidak ada data planet ditemukan.');
            } else {
              List<Planet> planets = snapshot.data!;
              return ListView.builder(
                itemCount: planets.length,
                itemBuilder: (context, index) {
                  final planet = planets[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.public, size: 40),
                      title: Text(planet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Jarak: ${planet.distanceFromEarth?.toStringAsFixed(2) ?? 'N/A'} parsec\n'
                          'Radius: ${planet.radius?.toStringAsFixed(2) ?? 'N/A'} x Bumi',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlanetDetailPage(planet: planet),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}