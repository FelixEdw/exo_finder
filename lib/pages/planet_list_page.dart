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

  // Variabel untuk fitur pencarian
  final TextEditingController _searchController = TextEditingController();
  List<Planet> _allPlanets = [];
  List<Planet> _filteredPlanets = [];
  bool _isLoading = true;

  // Variabel untuk paginasi (infinite scrolling)
  final ScrollController _scrollController = ScrollController();
  bool _isFetchingMore = false;
  int _offset = 0;
  final int _limit = 50; // Jumlah planet yang dimuat per permintaan

  @override
  void initState() {
    super.initState();
    _fetchInitialPlanets();

    // Listener untuk mendeteksi scroll hingga ke paling bawah
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _fetchMorePlanets();
      }
    });

    // Listener untuk pencarian
    _searchController.addListener(_filterPlanets);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose(); // Wajib di-dispose
    super.dispose();
  }

  // Fungsi untuk memuat data planet pertama kali
  void _fetchInitialPlanets() {
    setState(() {
      _isLoading = true;
    });
    apiService
        .fetchPlanets(offset: _offset, limit: _limit)
        .then((planets) {
          if (mounted) {
            setState(() {
              _allPlanets.addAll(planets);
              _filteredPlanets = List.from(_allPlanets);
              _isLoading = false;
              _offset += _limit;
            });
          }
        })
        .catchError((error) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          // Tampilkan pesan error jika perlu
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Failed to load: $error")));
        });
  }

  // Fungsi untuk memuat data selanjutnya saat di-scroll
  void _fetchMorePlanets() {
    // Jangan fetch lagi jika sedang dalam proses atau jika sedang melakukan pencarian
    if (_isFetchingMore || _searchController.text.isNotEmpty) return;

    setState(() {
      _isFetchingMore = true;
    });

    apiService.fetchPlanets(offset: _offset, limit: _limit).then((planets) {
      if (mounted) {
        setState(() {
          if (planets.isNotEmpty) {
            _allPlanets.addAll(planets);
            _filteredPlanets = List.from(_allPlanets);
            _offset += _limit;
          }
          _isFetchingMore = false;
        });
      }
    });
  }

  // Fungsi untuk memfilter planet berdasarkan nama
  void _filterPlanets() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPlanets = _allPlanets.where((planet) {
        // <--- Kuncinya di sini
        return planet.name.toLowerCase().contains(query);
      }).toList();
      _sortPlanets();
    });
  }

  // Fungsi untuk mengurutkan planet (yang dipilih pindah ke atas)
  void _sortPlanets() {
    _filteredPlanets.sort((a, b) {
      final isASelected = selectedPlanets.contains(a);
      final isBSelected = selectedPlanets.contains(b);
      if (isASelected && !isBSelected) return -1;
      if (!isASelected && isBSelected) return 1;
      return _allPlanets.indexOf(a).compareTo(_allPlanets.indexOf(b));
    });
  }

  // Fungsi yang dijalankan saat checkbox planet di-tap
  void _onPlanetSelected(bool? isSelected, Planet planet) {
    setState(() {
      if (isSelected == true) {
        if (selectedPlanets.length < 2) {
          selectedPlanets.add(planet);
        }
      } else {
        selectedPlanets.remove(planet);
      }
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
        title: const Text('Choose 2 Planets to Compare'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Here...',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController, // Pasang scroll controller
                    itemCount:
                        _filteredPlanets.length + (_isFetchingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Tampilkan loading indicator di item paling bawah
                      if (index == _filteredPlanets.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final planet = _filteredPlanets[index];
                      final isSelected = selectedPlanets.contains(planet);
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: CheckboxListTile(
                          value: isSelected,
                          onChanged: (bool? value) {
                            if (value == true && selectedPlanets.length >= 2) {
                              return;
                            }
                            _onPlanetSelected(value, planet);
                          },
                          secondary: const Icon(Icons.public, size: 40),
                          title: Text(
                            planet.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
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
              label: const Text('Compare'),
              icon: const Icon(Icons.compare_arrows),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
