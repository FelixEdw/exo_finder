import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/planet_model.dart';
import 'comparison_result_page.dart';

class PlanetListPage extends StatefulWidget {
  const PlanetListPage({super.key});

  @override
  _PlanetListPageState createState() => _PlanetListPageState();
}

class _PlanetListPageState extends State<PlanetListPage> {
  final ApiService apiService = ApiService();
  final List<Planet> selectedPlanets = [];

  // Variabel untuk fitur pencarian dan filtering
  final TextEditingController _searchController = TextEditingController();
  List<Planet> _allPlanets = [];
  List<Planet> _filteredPlanets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Mengambil data planet saat halaman pertama kali dimuat
    apiService.fetchPlanets().then((planets) {
      setState(() {
        _allPlanets = planets;
        _filteredPlanets = planets;
        _isLoading = false;
      });
    });

    // Listener untuk memperbarui daftar berdasarkan input pencarian
    _searchController.addListener(_filterPlanets);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi untuk memfilter planet berdasarkan nama
  void _filterPlanets() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPlanets = _allPlanets.where((planet) {
        return planet.name.toLowerCase().contains(query);
      }).toList();
      // Panggil fungsi sort agar planet terpilih tetap di atas
      _sortPlanets();
    });
  }

  // Fungsi untuk mengurutkan planet (yang dipilih pindah ke atas)
  void _sortPlanets() {
    _filteredPlanets.sort((a, b) {
      final isASelected = selectedPlanets.contains(a);
      final isBSelected = selectedPlanets.contains(b);
      if (isASelected && !isBSelected) {
        return -1; // 'a' (yang dipilih) akan berada sebelum 'b'
      } else if (!isASelected && isBSelected) {
        return 1; // 'b' (yang dipilih) akan berada sebelum 'a'
      }
      // Jika statusnya sama (sama-sama dipilih atau tidak), urutan tidak berubah
      return _allPlanets.indexOf(a).compareTo(_allPlanets.indexOf(b));
    });
  }

  // Fungsi yang dijalankan saat checkbox planet di-tap
  void _onPlanetSelected(bool? isSelected, Planet planet) {
    setState(() {
      if (isSelected == true) {
        // Hanya bisa memilih maksimal 2 planet
        if (selectedPlanets.length < 2) {
          selectedPlanets.add(planet);
        }
      } else {
        selectedPlanets.remove(planet);
      }
      // Panggil sort setiap kali ada perubahan pilihan
      _sortPlanets();
    });
  }

  // Navigasi ke halaman perbandingan
  void _navigateToComparison() {
    if (selectedPlanets.length == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ComparisonResultPage(
            planet1: selectedPlanets[0],
            planet2: selectedPlanets[1],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih 2 Planet untuk Dibandingkan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 1. WIDGET SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Planet...',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // 2. DAFTAR PLANET
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filteredPlanets.length,
                    itemBuilder: (context, index) {
                      final planet = _filteredPlanets[index];
                      final isSelected = selectedPlanets.contains(planet);
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: CheckboxListTile(
                          value: isSelected,
                          onChanged: (bool? value) {
                            // Mencegah pemilihan planet ketiga
                            if (value == true && selectedPlanets.length >= 2) return;
                            _onPlanetSelected(value, planet);
                          },
                          secondary: const Icon(Icons.public, size: 40),
                          title: Text(planet.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              'Jarak: ${planet.distanceFromEarth?.toStringAsFixed(2) ?? 'N/A'} parsec\n'
                              'Radius: ${planet.radius?.toStringAsFixed(2) ?? 'N/A'} x Bumi',
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: selectedPlanets.length == 2
          ? FloatingActionButton.extended(
              onPressed: _navigateToComparison,
              label: const Text('Bandingkan'),
              icon: const Icon(Icons.compare_arrows),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}