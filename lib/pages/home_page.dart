// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import '../models/planet_model.dart';
import '../services/api_services.dart';
import 'comparison_result_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  List<Planet>? _allPlanets;
  Planet? _selectedPlanet1;
  Planet? _selectedPlanet2;

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPlanets();
  }

  Future<void> _fetchPlanets() async {
    try {
      final planets = await _apiService.fetchPlanets();
      setState(() {
        _allPlanets = planets;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat data planet: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COMPARE PLANETS'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _allPlanets == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPlanetAutocomplete(
                    controller: _controller1,
                    hint: 'Search Planet 1',
                    onSelected: (planet) {
                      setState(() {
                        _selectedPlanet1 = planet;
                      });
                    },
                    onClear: () {
                      setState(() {
                        _controller1.clear();
                        _selectedPlanet1 = null;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildPlanetAutocomplete(
                    controller: _controller2,
                    hint: 'Search Planet 2',
                    onSelected: (planet) {
                      setState(() {
                        _selectedPlanet2 = planet;
                      });
                    },
                     onClear: () {
                      setState(() {
                        _controller2.clear();
                        _selectedPlanet2 = null;
                      });
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: (_selectedPlanet1 != null && _selectedPlanet2 != null)
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ComparisonResultPage(
                                    planet1: _selectedPlanet1!,
                                    planet2: _selectedPlanet2!,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: const Text('COMPARE', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildPlanetAutocomplete({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<Planet> onSelected,
    required VoidCallback onClear,
  }) {
    return Autocomplete<Planet>(
      displayStringForOption: (Planet option) => option.name,
      optionsBuilder: (TextEditingValue textEditingValue) {
        // --- PERBAIKAN DI SINI ---
        // 1. Cek dulu apakah data planet sudah ada. Jika belum, jangan lakukan apa-apa.
        if (_allPlanets == null) {
          return const Iterable<Planet>.empty();
        }
        
        // 2. Cek apakah kotak pencarian kosong.
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Planet>.empty();
        }
        
        // 3. Jika semua aman, baru lakukan filter.
        return _allPlanets!.where((Planet planet) {
          return planet.name.toLowerCase().contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (Planet selection) {
        onSelected(selection);
        controller.text = selection.name;
      },
      fieldViewBuilder: (BuildContext context, TextEditingController fieldController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: controller,
          focusNode: fieldFocusNode,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white70),
                  onPressed: onClear,
                )
              : null,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.grey[850],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (text) {
            setState(() {});
            fieldController.text = text;
          },
        );
      },
      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Planet> onSelected, Iterable<Planet> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            color: Colors.grey[800],
            child: SizedBox(
              height: 200.0,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final Planet option = options.elementAt(index);
                  final String inputText = controller.text;

                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          children: _highlightOccurrences(option.name, inputText),
                          style: DefaultTextStyle.of(context).style,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  List<TextSpan> _highlightOccurrences(String source, String query) {
    if (query.isEmpty) {
      return [TextSpan(text: source)];
    }

    var matches = query.toLowerCase().allMatches(source.toLowerCase());
    if (matches.isEmpty) {
      return [TextSpan(text: source)];
    }
    
    List<TextSpan> spans = [];
    int start = 0;
    for (var match in matches) {
      if (match.start > start) {
        spans.add(TextSpan(text: source.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ));
      start = match.end;
    }

    if (start < source.length) {
      spans.add(TextSpan(text: source.substring(start, source.length)));
    }
    
    return spans;
  }
}