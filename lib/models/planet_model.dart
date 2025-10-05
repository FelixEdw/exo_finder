// lib/models/planet_model.dart

class Planet {
  final String name;
  final double? radius;
  final double? mass;
  final double? distanceFromEarth;
  final double? stellarTemperature;
  final String? habitability; // Tambahan: Status kelayakhunian
  final String? composition;  // Tambahan: Susunan planet

  Planet({
    required this.name,
    this.radius,
    this.mass,
    this.distanceFromEarth,
    this.stellarTemperature,
    this.habitability,
    this.composition,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    double? stellarTemp = (json['st_teff'] as num?)?.toDouble();
    double? planetRadius = (json['pl_rade'] as num?)?.toDouble();
    String habitabilityStatus = 'Tidak diketahui';
    String planetComposition = 'Tidak diketahui';

    // Logika sederhana untuk menentukan kelayakhunian
    if (stellarTemp != null && stellarTemp > 4000 && stellarTemp < 7000) {
      habitabilityStatus = 'Berpotensi layak huni';
    } else {
      habitabilityStatus = 'Tidak layak huni';
    }

    // Logika sederhana untuk menentukan komposisi
    if (planetRadius != null) {
      if (planetRadius < 2) {
        planetComposition = 'Batuan';
      } else if (planetRadius >= 2 && planetRadius < 10) {
        planetComposition = 'Gas';
      } else {
        planetComposition = 'Raksasa Gas';
      }
    }

    return Planet(
      name: json['pl_name'] as String,
      radius: planetRadius,
      mass: (json['pl_masse'] as num?)?.toDouble(),
      distanceFromEarth: (json['sy_dist'] as num?)?.toDouble(),
      stellarTemperature: stellarTemp,
      habitability: habitabilityStatus,
      composition: planetComposition,
    );
  }
}